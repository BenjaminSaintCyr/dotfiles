(specifications->manifest
 '(;; compilers
   "gcc-toolchain"
   "clang"
   "spin"
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
   "tbb"))

;; BUILD
;; guix package -m ~/.config/guix/manifests/school.scm -p .guix-extra-profiles/school/school

