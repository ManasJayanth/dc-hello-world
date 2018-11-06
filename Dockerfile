FROM ubuntu:18.04

# RUN apt-get update
RUN apt-get update && apt-get install -y git make cmake clang || apt-get update && apt-get install -y git make cmake clang || apt-get update && apt-get install -y git make cmake clang 

WORKDIR /llvmwasm
RUN git clone https://github.com/sanderspies/llvm

WORKDIR /llvmwasm/llvm/tools
RUN git clone https://github.com/sanderspies/lld

WORKDIR /llvmwasm/llvm-build
RUN cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=$INSTALLDIR -DLLVM_TARGETS_TO_BUILD= -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=WebAssembly /llvmwasm/llvm 
RUN make -j 6

WORKDIR /
RUN git clone --recursive https://github.com/sanderspies/wabt
RUN ls -l
RUN git clone https://github.com/SanderSpies/ocaml

WORKDIR /wabt
RUN make

WORKDIR /ocaml
ENV LLVM_HOME /llvmwasm/llvm-build

# RUN git checkout before_gc
# RUN ./configure -no-pthread -no-debugger -no-curses -no-ocamldoc -no-graph -target-wasm32
# RUN make coldstart	
# RUN ../wabt/bin/wasm2wat --help
# RUN make wasm32
