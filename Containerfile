FROM debian:bullseye

# Install toolchain.
RUN apt-get update
RUN apt-get -y install bison build-essential clang-9 curl flex \
ghc git libedit-dev libgmp-dev libz-dev \
llvm-9 libnuma-dev
RUN curl -sSL https://get.haskellstack.org/ | sh

# Add non-root user.
RUN useradd -m user
USER user

# Install the rest of the toolchain locally for the user,
# as recommended by the installation slides.
RUN echo "export PATH=${HOME}/.local/bin:${PATH}" >> ${HOME}/.bashrc
RUN stack --resolver lts-18.28 --install-ghc install BNFC alex happy

# Prepare folder for volume mount.
RUN mkdir ${HOME}/cc