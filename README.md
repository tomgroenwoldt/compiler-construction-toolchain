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

Copy the `start_example.sh` script:
```
cp start_example.sh start.sh
```

Adjust the new `start.sh` script to your liking. **You have to specify your shared folder.**

Finally, run the container:
```
./start.sh
```
