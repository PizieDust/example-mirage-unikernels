open Mirage
(* Copy a file from a block device to another block device *)
let main = 
  let packages = 
    [
      package "io-page";
      package ~build:true "bos";
      package ~build:true "fpath";
    ]
  in
  main ~packages "Unikernel.Main" (block @-> block @-> job)

let img_1 = 
  Key.(if_impl is_solo5) (block_of_file "storage_1") (block_of_file "disk_1.img")

let img_2 = 
  Key.(if_impl is_solo5) (block_of_file "storage_2") (block_of_file "disk_2.img")

let () = register "between_blocks" [ main $ img_1 $ img_2 ]