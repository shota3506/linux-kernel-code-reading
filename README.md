# Linux kernel code reading

Docker image for Linux kernel code reading.

It pulls [the Linux kernel source code from the official repository](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git) and set up neovim.

## Setup

```bash
docker build -t linux-kernel .
```

## Usage

```bash
docker run -it --rm linux-kernel
```
