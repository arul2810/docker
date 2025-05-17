################################################################################
# Base Docker File for Alpine                                                  #
# Copyright 2025 - arulprakash.dev                                             #
################################################################################

# Use Alpine Linux as the base image
FROM alpine:latest

# Set environment variables to ensure non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install necessary build tools and dependencies
# for TF-A, EDK2, and the Linux Kernel.
# We use --no-cache to keep the image size down and remove the apk cache afterwards.
RUN apk update && \
    apk add --no-cache \
    # Essential build tools (includes make, gcc, g++, libc-dev, etc.)
    alpine-sdk \
    # AArch64 cross-compiler and related tools
    gcc-aarch64-linux-gnu \
    binutils-aarch64-linux-gnu \
    # Python 3 (required by all projects)
    python3 \
    # Device Tree Compiler (required by TF-A and Kernel)
    dtc \
    # Netwide Assembler (required by EDK2)
    nasm \
    # ACPI Source Language compiler (part of acpica-tools, required by EDK2)
    acpica-tools \
    # Provides libuuid (required by EDK2)
    util-linux \
    # Arbitrary precision calculator (required by Kernel)
    bc \
    # Lexical analyzer generator (required by Kernel)
    flex \
    # Parser generator (required by Kernel)
    bison \
    # OpenSSL development libraries (required by Kernel)
    openssl-dev \
    # DWARF inspector (required by Kernel)
    dwarves \
    # Perl (required by Kernel build scripts)
    perl \
    # Compression utilities (required by Kernel)
    zstd \
    lz4 \
    xz \
    gzip \
    bzip2 \
    # Cpio archive tool (required by Kernel)
    cpio \
    # ELF development libraries (required by Kernel)
    elfutils-dev && \
    # Clean up apk cache to reduce image size
    rm -rf /var/cache/apk/*