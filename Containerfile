FROM debian:bullseye

# Install toolchain.
RUN apt-get update
RUN apt-get -y install bison build-essential clang-9 curl flex \
ghc git libedit-dev libgmp-dev libz-dev \
llvm-9 libnuma-dev wget lsb-release p7zip-full clangd bear
RUN curl -sSL https://get.haskellstack.org/ | sh

# Install convenient tools for development. 
RUN wget -qO - 'https://proget.makedeb.org/debian-feeds/prebuilt-mpr.pub' | gpg --dearmor | tee /usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg 1> /dev/null
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg] https://proget.makedeb.org prebuilt-mpr $(lsb_release -cs)" | tee /etc/apt/sources.list.d/prebuilt-mpr.list
RUN apt update
RUN apt install just

# Add non-root user.
RUN useradd -m user
USER user

# Install the rest of the toolchain locally for the user,
# as recommended by the installation slides.
RUN echo "export PATH=${HOME}/.local/bin:${PATH}" >> ${HOME}/.bashrc
RUN stack --resolver lts-18.28 --install-ghc install BNFC alex happy

# Install rust toolchain for building the helix editor from source.
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o ~/rustup.sh && chmod u+x ~/rustup.sh && ~/rustup.sh -y

# Install the helix editor
RUN git clone https://github.com/helix-editor/helix.git ~/helix
RUN cd ~/helix && export PATH=$PATH:$HOME/.cargo/bin && cargo install --path helix-term && hx --grammar fetch && hx --grammar build
RUN echo "alias helix=~/.cargo/bin/hx" >> ~/.bashrc
COPY helix /home/user/.config/helix

# Prepare folder for volume mount.
RUN mkdir ${HOME}/cc