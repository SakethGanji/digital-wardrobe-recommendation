# Use an official PyTorch runtime as a parent image
FROM pytorch/pytorch:latest

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# Create a group with the same ID as your host user group
RUN groupadd -g 1000 hostgroup

# Create a user with the same ID as your host user and add it to the group
RUN useradd -u 1000 -g 1000 -ms /bin/bash hostuser

# Set the working directory in the container
WORKDIR /workspace/digital-wardrobe-recommendation

# Set user
USER hostuser

# Install PyTorch and related packages with the specified version and CUDA compatibility
RUN pip install torch==1.13.1+cu116 torchvision==0.14.1+cu116 torchaudio==0.13.1 --extra-index-url https://download.pytorch.org/whl/cu116

# Expose the port
EXPOSE 8000