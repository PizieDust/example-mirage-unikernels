open Lwt.Syntax

module Main (B1: Mirage_block.S) (B2: Mirage_block.S) = struct
  let start block_1 block_2 =
    let* info_1 = B1.get_info block_1 in
    Format.printf "%a\n" Mirage_block.pp_info info_1;

    let* info_2 = B2.get_info block_2 in
    Format.printf "%a\n" Mirage_block.pp_info info_2;

    let buf_1 = Cstruct.create info_1.sector_size in
    let* data_1 = B1.read block_1 1L [buf_1]  in
    let ()  = match data_1 with
     | Ok () -> 
          Printf.printf "Data has been read from the first device\n";
     | Error e -> Format.eprintf "An error occured when reading the data: %a\n" B1.pp_error e;
    
     in

     Printf.printf "Now wrtiting to the second device \n";

     let* data_2 = B2.write block_2 1L [buf_1] in
     let () = match data_2 with
      | Ok () -> Printf.printf "Data has been written to the second device\n";
      | Error e -> Format.eprintf "An error occured: %a\n" B2.pp_write_error e;
     in
    

  Lwt.return_unit
end