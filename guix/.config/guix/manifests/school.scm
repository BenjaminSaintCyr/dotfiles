(specifications->manifest
 '(;; compilers
   "gcc-toolchain"
   "clang"
   "spin"
   "tcl"
   ;; tools
   "gdb"
   "git"
   ;;; build system
   "cmake"
   "make"
   "autobuild"
   ;;; linter
   "cppcheck"
   ;;; tracing/profiler
   "valgrind"
   "kcachegrind"
   "strace"
   "lttng-tools"          
   "lttng-ust"
   ;;; virtualization
   "qemu"
   "docker"
   "docker-cli"
   "containerd"
   ;; libs
   "libpng"
   "bc"
   "perf"
   "grpc"
   "tbb"
   "freeglut"
   "glew"
   ;;; opencl
   "opencl-headers"
   "opencl-icd-loader"
   "pocl"
   ))

;; BUILD
;; guix package -m ~/.config/guix/manifests/school.scm -p .guix-extra-profiles/school/school

