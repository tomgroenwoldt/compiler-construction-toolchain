### Requirements:

- [podman](https://github.com/containers/podman/blob/main/docs/tutorials/podman_tutorial.md)

### Setup

##### Clone the repository:
```
git clone https://github.com/tomgroenwoldt/compiler-construction-toolchain.git
cd compiler-construction-toolchain
```

##### Build the container:
```
podman build . -t cc-toolchain
```

##### Run the container:
```
podman run -v /path/to/your/compiler-construction-folder:/home/user/cc \
--userns=keep-id -w /home/user/cc -it cc-toolchain:latest
```

Alternatively, run the container via the `start.sh` script to avoid repetitively typing out this command.
