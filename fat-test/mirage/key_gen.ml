let allocation_policy =
  Functoria_runtime.Key.create
    (Functoria_runtime.Arg.opt Mirage_runtime.Arg.allocation_policy `Next_fit
       (Cmdliner.Arg.info ~docs:"OCAML RUNTIME PARAMETERS"
          ?docv:(Some "ALLOCATION")
          ?doc:
            (Some
               "The policy used for allocating in the OCaml heap. Possible \
                values are: $(i,next-fit), $(i,first-fit), $(i,best-fit). \
                Best-fit is only supported since OCaml 4.10.  ")
          ?env:None [ "allocation-policy" ]))

let allocation_policy_t = Functoria_runtime.Key.term allocation_policy
let allocation_policy () = Functoria_runtime.Key.get allocation_policy

let backtrace =
  Functoria_runtime.Key.create
    (Functoria_runtime.Arg.opt Cmdliner.Arg.bool true
       (Cmdliner.Arg.info ~docs:"OCAML RUNTIME PARAMETERS" ?docv:(Some "BOOL")
          ?doc:
            (Some
               "Trigger the printing of a stack backtrace when an uncaught \
                exception aborts the unikernel.  ")
          ?env:None [ "backtrace" ]))

let backtrace_t = Functoria_runtime.Key.term backtrace
let backtrace () = Functoria_runtime.Key.get backtrace

let custom_major_ratio =
  Functoria_runtime.Key.create
    (Functoria_runtime.Arg.opt
       (Cmdliner.Arg.some Cmdliner.Arg.int)
       None
       (Cmdliner.Arg.info ~docs:"OCAML RUNTIME PARAMETERS"
          ?docv:(Some "CUSTOM MAJOR RATIO")
          ?doc:
            (Some
               "Target ratio of floating garbage to major heap size for \
                out-of-heap memory held by custom values. Default: 44.  ")
          ?env:None [ "custom-major-ratio" ]))

let custom_major_ratio_t = Functoria_runtime.Key.term custom_major_ratio
let custom_major_ratio () = Functoria_runtime.Key.get custom_major_ratio

let custom_minor_max_size =
  Functoria_runtime.Key.create
    (Functoria_runtime.Arg.opt
       (Cmdliner.Arg.some Cmdliner.Arg.int)
       None
       (Cmdliner.Arg.info ~docs:"OCAML RUNTIME PARAMETERS"
          ?docv:(Some "CUSTOM MINOR MAX SIZE")
          ?doc:
            (Some
               "Maximum amount of out-of-heap memory for each custom value \
                allocated in the minor heap. Default: 8192 bytes.  ")
          ?env:None
          [ "custom-minor-max-size" ]))

let custom_minor_max_size_t = Functoria_runtime.Key.term custom_minor_max_size
let custom_minor_max_size () = Functoria_runtime.Key.get custom_minor_max_size

let custom_minor_ratio =
  Functoria_runtime.Key.create
    (Functoria_runtime.Arg.opt
       (Cmdliner.Arg.some Cmdliner.Arg.int)
       None
       (Cmdliner.Arg.info ~docs:"OCAML RUNTIME PARAMETERS"
          ?docv:(Some "CUSTOM MINOR RATIO")
          ?doc:
            (Some
               "Bound on floating garbage for out-of-heap memory held by \
                custom values in the minor heap. Default: 100.  ")
          ?env:None [ "custom-minor-ratio" ]))

let custom_minor_ratio_t = Functoria_runtime.Key.term custom_minor_ratio
let custom_minor_ratio () = Functoria_runtime.Key.get custom_minor_ratio

let gc_verbosity =
  Functoria_runtime.Key.create
    (Functoria_runtime.Arg.opt
       (Cmdliner.Arg.some Cmdliner.Arg.int)
       None
       (Cmdliner.Arg.info ~docs:"OCAML RUNTIME PARAMETERS"
          ?docv:(Some "VERBOSITY")
          ?doc:
            (Some
               "GC messages on standard error output. Sum of flags. Check GC \
                module documentation for details.  ")
          ?env:None [ "gc-verbosity" ]))

let gc_verbosity_t = Functoria_runtime.Key.term gc_verbosity
let gc_verbosity () = Functoria_runtime.Key.get gc_verbosity

let gc_window_size =
  Functoria_runtime.Key.create
    (Functoria_runtime.Arg.opt
       (Cmdliner.Arg.some Cmdliner.Arg.int)
       None
       (Cmdliner.Arg.info ~docs:"OCAML RUNTIME PARAMETERS"
          ?docv:(Some "WINDOW SIZE")
          ?doc:
            (Some
               "The size of the window used by the major GC for smoothing out \
                variations in its workload. Between 1 adn 50, default: 1.  ")
          ?env:None [ "gc-window-size" ]))

let gc_window_size_t = Functoria_runtime.Key.term gc_window_size
let gc_window_size () = Functoria_runtime.Key.get gc_window_size

let logs =
  Functoria_runtime.Key.create
    (Functoria_runtime.Arg.opt
       (Cmdliner.Arg.list Mirage_runtime.Arg.log_threshold)
       []
       (Cmdliner.Arg.info ~docs:"UNIKERNEL PARAMETERS" ?docv:(Some "LEVEL")
          ?doc:
            (Some
               "Be more or less verbose. $(docv) must be of the form\n\
                $(b,*:info,foo:debug) means that that the log threshold is set \
                to\n\
                $(b,info) for every log sources but the $(b,foo) which is set to\n\
                $(b,debug).  ")
          ?env:(Some (Cmdliner.Cmd.Env.info "MIRAGE_LOGS"))
          [ "l"; "logs" ]))

let logs_t = Functoria_runtime.Key.term logs
let logs () = Functoria_runtime.Key.get logs

let major_heap_increment =
  Functoria_runtime.Key.create
    (Functoria_runtime.Arg.opt
       (Cmdliner.Arg.some Cmdliner.Arg.int)
       None
       (Cmdliner.Arg.info ~docs:"OCAML RUNTIME PARAMETERS"
          ?docv:(Some "MAJOR INCREMENT")
          ?doc:
            (Some
               "The size increment for the major heap (in words). If less than \
                or equal 1000, it is a percentage of the current heap size. If \
                more than 1000, it is a fixed number of words. Default: 15.  ")
          ?env:None [ "major-heap-increment" ]))

let major_heap_increment_t = Functoria_runtime.Key.term major_heap_increment
let major_heap_increment () = Functoria_runtime.Key.get major_heap_increment

let max_space_overhead =
  Functoria_runtime.Key.create
    (Functoria_runtime.Arg.opt
       (Cmdliner.Arg.some Cmdliner.Arg.int)
       None
       (Cmdliner.Arg.info ~docs:"OCAML RUNTIME PARAMETERS"
          ?docv:(Some "MAX SPACE OVERHEAD")
          ?doc:
            (Some
               "Heap compaction is triggered when the estimated amount of \
                wasted memory exceeds this (percentage of live data). If above \
                1000000, compaction is never triggered. Default: 500.  ")
          ?env:None [ "max-space-overhead" ]))

let max_space_overhead_t = Functoria_runtime.Key.term max_space_overhead
let max_space_overhead () = Functoria_runtime.Key.get max_space_overhead

let minor_heap_size =
  Functoria_runtime.Key.create
    (Functoria_runtime.Arg.opt
       (Cmdliner.Arg.some Cmdliner.Arg.int)
       None
       (Cmdliner.Arg.info ~docs:"OCAML RUNTIME PARAMETERS"
          ?docv:(Some "MINOR SIZE")
          ?doc:(Some "The size of the minor heap (in words). Default: 256k.  ")
          ?env:None [ "minor-heap-size" ]))

let minor_heap_size_t = Functoria_runtime.Key.term minor_heap_size
let minor_heap_size () = Functoria_runtime.Key.get minor_heap_size

let randomize_hashtables =
  Functoria_runtime.Key.create
    (Functoria_runtime.Arg.opt Cmdliner.Arg.bool true
       (Cmdliner.Arg.info ~docs:"OCAML RUNTIME PARAMETERS" ?docv:(Some "BOOL")
          ?doc:(Some "Turn on randomization of all hash tables by default.  ")
          ?env:None [ "randomize-hashtables" ]))

let randomize_hashtables_t = Functoria_runtime.Key.term randomize_hashtables
let randomize_hashtables () = Functoria_runtime.Key.get randomize_hashtables

let space_overhead =
  Functoria_runtime.Key.create
    (Functoria_runtime.Arg.opt
       (Cmdliner.Arg.some Cmdliner.Arg.int)
       None
       (Cmdliner.Arg.info ~docs:"OCAML RUNTIME PARAMETERS"
          ?docv:(Some "SPACE OVERHEAD")
          ?doc:
            (Some
               "The percentage of live data of wasted memory, due to GC does \
                not immediately collect unreachable blocks. The major GC speed \
                is computed from this parameter, it will work more if smaller. \
                Default: 80.  ")
          ?env:None [ "space-overhead" ]))

let space_overhead_t = Functoria_runtime.Key.term space_overhead
let space_overhead () = Functoria_runtime.Key.get space_overhead
let target () = `Unix

let runtime_keys =
  List.combine
    [
      allocation_policy_t;
      backtrace_t;
      custom_major_ratio_t;
      custom_minor_max_size_t;
      custom_minor_ratio_t;
      gc_verbosity_t;
      gc_window_size_t;
      logs_t;
      major_heap_increment_t;
      max_space_overhead_t;
      minor_heap_size_t;
      randomize_hashtables_t;
      space_overhead_t;
    ]
    [
      "allocation-policy";
      "backtrace";
      "custom-major-ratio";
      "custom-minor-max-size";
      "custom-minor-ratio";
      "gc-verbosity";
      "gc-window-size";
      "logs";
      "major-heap-increment";
      "max-space-overhead";
      "minor-heap-size";
      "randomize-hashtables";
      "space-overhead";
    ]
