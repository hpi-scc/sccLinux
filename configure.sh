#!/bin/bash

BUILDROOT_VERSION=2011.11
KERNEL_VERSION=3.1.4-100

BUILDROOT=buildroot-${BUILDROOT_VERSION}
BUILDROOT_FILE=${BUILDROOT}.tar.bz2
BUILDROOT_PATCH=${BUILDROOT}-scc.patch
KERNEL_PATCH=linux-${BUILDROOT_VERSION}-scc.patch

# Download
if [ ! -f $BUILDROOT_FILE ]; then
	echo "Downloading ${BUILDROOT_FILE}"
	wget http://buildroot.uclibc.org/downloads/${BUILDROOT_FILE}
fi

# Extract
echo "Extracting..."
tar xf ${BUILDROOT_FILE}
cp -R ${BUILDROOT} ${BUILDROOT}.orig

echo "Applying patch file ${BUILDROOT_PATCH}"
patch -d ${BUILDROOT} -p1 < patches/${BUILDROOT_PATCH}

echo "Copying the kernel patch file ${KERNEL_PATCH}"
cp linux-kernel-patches/${KERNEL_PATCH} ${BUILDROOT}/board/intel/scc/kernel-patches/

echo "Copying binary files..."
cp -a target_skeleton ${BUILDROOT}/board/intel/scc >& /dev/null
find  ${BUILDROOT}/board/intel/scc/target_skeleton -name ".svn" -exec rm -rf {} \; >& /dev/null

echo "Copying applications..."
mkdir -p ${BUILDROOT}/dl
cp -a apps/* ${BUILDROOT}/dl

echo "Done."
