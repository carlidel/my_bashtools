#!/bin/bash

# Loading the correct CVMFS release for the OS and GPU configuration

# Function to load CUDA-flavored CVMFS release for CentOS 7
load_centos7_cuda_release() {
    echo "Loading CUDA-flavored CVMFS release for CentOS 7..."
    source /cvmfs/sft.cern.ch/lcg/views/LCG_104a_cuda/x86_64-centos7-gcc11-opt/setup.sh
}

# Function to load CUDA-flavored CVMFS release for CentOS 8
load_centos8_cuda_release() {
    echo "Loading CUDA-flavored CVMFS release for CentOS 8..."
    source /cvmfs/sft.cern.ch/lcg/views/LCG_104a_cuda/x86_64-centos8-gcc11-opt/setup.sh
}

# Function to load CUDA-flavored CVMFS release for Alma Linux 9
load_alma_linux9_cuda_release() {
    echo "Loading CUDA-flavored CVMFS release for Alma Linux 9..."
    source /cvmfs/sft.cern.ch/lcg/views/LCG_104a_cuda/x86_64-el9-gcc11-opt/setup.sh
}

# Function to load non-CUDA CVMFS release for CentOS 7
load_centos7_non_cuda_release() {
    echo "Loading non-CUDA CVMFS release for CentOS 7..."
    source /cvmfs/sft.cern.ch/lcg/views/LCG_104a/x86_64-centos7-gcc11-opt/setup.sh
}

# Function to load non-CUDA CVMFS release for CentOS 8
load_centos8_non_cuda_release() {
    echo "Loading non-CUDA CVMFS release for CentOS 8..."
    source /cvmfs/sft.cern.ch/lcg/views/LCG_104a/x86_64-centos8-gcc11-opt/setup.sh
}

# Function to load non-CUDA CVMFS release for Alma Linux 9
load_alma_linux9_non_cuda_release() {
    echo "Loading non-CUDA CVMFS release for Alma Linux 9..."
    source /cvmfs/sft.cern.ch/lcg/views/LCG_104a/x86_64-el9-gcc11-opt/setup.sh
}

# Check for the presence of an NVIDIA GPU
if lspci | grep -i "NVIDIA Corporation" &> /dev/null; then
    echo "NVIDIA GPU detected."
    # If NVIDIA GPU is present, load the CUDA-flavored CVMFS release
    if [[ -f /etc/os-release ]]; then
        source /etc/os-release
        if [[ "$ID" == "centos" && "$VERSION_ID" =~ ^7 ]]; then
            load_centos7_cuda_release
        elif [[ "$ID" == "centos" && "$VERSION_ID" =~ ^8 ]]; then
            load_centos8_cuda_release
        elif [[ "$ID" == "almalinux" && "$VERSION_ID" =~ ^9 ]]; then
            load_alma_linux9_cuda_release
        else
            echo "Unsupported OS: $ID $VERSION_ID"
            exit 1
        fi
    else
        echo "Unable to detect the operating system."
        exit 1
    fi
else
    echo "No NVIDIA GPU detected."
    # If no NVIDIA GPU is detected, load the non-CUDA CVMFS release
    if [[ -f /etc/os-release ]]; then
        source /etc/os-release
        if [[ "$ID" == "centos" && "$VERSION_ID" =~ ^7 ]]; then
            load_centos7_non_cuda_release
        elif [[ "$ID" == "centos" && "$VERSION_ID" =~ ^8 ]]; then
            load_centos8_non_cuda_release
        elif [[ "$ID" == "almalinux" && "$VERSION_ID" =~ ^9 ]]; then
            load_alma_linux9_non_cuda_release
        else
            echo "Unsupported OS: $ID $VERSION_ID"
            exit 1
        fi
    else
        echo "Unable to detect the operating system."
        exit 1
    fi
fi

# Load my personal Python virtual environment
source /afs/cern.ch/work/c/camontan/public/venv/bin/activate

# Set home directory alias
alias home='cd /afs/cern.ch/work/c/camontan/public'
export PATH="$PATH:/afs/cern.ch/user/m/mad/bin"

cd /afs/cern.ch/work/c/camontan/public