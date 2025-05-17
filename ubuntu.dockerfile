################################################################################
# Base Docker File for Ubuntu                                                  #
# Copyright 2025 - arulprakash.dev                                             #
################################################################################

# Use Ubuntu as the base image
FROM ubuntu:latest

# Set environment variables to ensure non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install necessary build tools and dependencies
# for TF-A, EDK2, and the Linux Kernel using apt-get.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    # Essential build tools (includes make, gcc, g++, libc-dev, etc.)
    build-essential \
    # AArch64 cross-compiler and related tools
    gcc-aarch64-linux-gnu \
    binutils-aarch64-linux-gnu \
    # Python 3 (required by all projects)
    python3 \
    # Device Tree Compiler (required by TF-A and Kernel)
    device-tree-compiler \
    # Netwide Assembler (required by EDK2)
    nasm \
    # ACPI Source Language compiler (part of acpica-tools, required by EDK2)
    acpica-tools \
    # Provides libuuid (required by EDK2)
    uuid-dev \
    # Arbitrary precision calculator (required by Kernel)
    bc \
    # Lexical analyzer generator (required by Kernel)
    flex \
    # Parser generator (required by Kernel)
    bison \
    # OpenSSL development libraries (required by Kernel)
    libssl-dev \
    # DWARF inspector (required by Kernel)
    dwarves \
    # Perl (required by Kernel build scripts)
    perl \
    # Compression utilities (required by Kernel)
    zstd \
    xz-utils \
    gzip \
    bzip2 \
    # Cpio archive tool (required by Kernel)
    cpio \
    # ELF development libraries (required by Kernel)
    libelf-dev && \
    # Clean up apt cache to reduce image size
    rm -rf /var/lib/apt/lists/*

# Set a working directory inside the container (optional but recommended)
WORKDIR /build