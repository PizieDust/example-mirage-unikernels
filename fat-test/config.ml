open Mirage

let main =
  let packages =
    [
      package "fat-filesystem";
      package "mbr-format";
      package "io-page";
      package ~build:true "bos";
      package ~build:true "fpath";
    ]
  in
  main ~packages "Unikernel.Main" (block @-> job)

let img =
  Key.(if_impl is_solo5) (block_of_file "storage") (block_of_file "disk.img")

let () = register "block_with_fat" [ main $ img ]
