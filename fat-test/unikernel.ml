open Lwt.Syntax

module Main (B : Mirage_block.S) = struct
  module FatPartition = Fat.Make (B)

  let start block =
    let* info = B.get_info block in
    Format.printf "%a\n" Mirage_block.pp_info info;

    let partition1 =
      match Mbr.Partition.make ~partition_type:6 1024l 1000l with
      | Ok partition -> partition
      | Error er ->
          Printf.printf "An error occured: %s\n" er;
          exit 1
    in
    let partition2 =
      match Mbr.Partition.make ~partition_type:7 4096l 2000l with
      | Ok partition -> partition
      | Error er ->
          Printf.printf "An error occured: %s\n" er;
          exit 1
    in
    let mbr =
      match Mbr.make [ partition1; partition2 ] with
      | Ok mbr -> mbr
      | Error er ->
          Printf.printf "An error occured: %s\n" er;
          exit 1
    in
    let mbr_buffer = Cstruct.create Mbr.sizeof in
    Mbr.marshal mbr_buffer mbr;
    let* mbr_header = B.write block 1024L [ mbr_buffer ] in
    let () =
      match mbr_header with
      | Ok () -> Printf.printf "MBR header has been written\n"
      | Error er -> Format.printf "An error occured: %a\n" B.pp_write_error er
    in

    let* fs_result = FatPartition.format block 1024L in
    let () =
      match fs_result with
      | Ok _fs -> Printf.printf "FAT filesystem created\n"
      | Error err ->
          Format.printf "An error occurred: %a\n" FatPartition.pp_write_error
            err
    in
    Lwt.return_unit
end
