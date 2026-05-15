```bash
git clone -b circinus --single-branch https://github.com/vyos/vyos-build
cd vyos-build
docker run --rm -it --privileged -v $(pwd):/vyos -w /vyos vyos/vyos-build:circinus bash
sudo make clean
sudo ./build-vyos-image --architecture amd64 --build-by "anonymous" generic
```