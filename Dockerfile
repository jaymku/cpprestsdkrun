# Select base image
FROM ubuntu:20.04

# Skip the TZ prompt
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y tzdata

#ENV prepared
RUN apt-get update && apt-get install -y \
    g++ \
    cmake \
    git \
    libboost-all-dev \
    libssl-dev \
    libgtest-dev \
    build-essential \
    wget
# Clone websocketpp
RUN git clone https://github.com/zaphoyd/websocketpp.git
WORKDIR /websocketpp
RUN mkdir build
WORKDIR /websocketpp/build
RUN cmake ..
RUN make
RUN make install

# Go back to root directory
WORKDIR /

# Clone and build cpprestsdk
RUN git clone --recurse-submodules https://github.com/microsoft/cpprestsdk.git skadoosh
WORKDIR /skadoosh
RUN mkdir build.release
WORKDIR /skadoosh/build.release
RUN cmake .. -DCMAKE_BUILD_TYPE=Release
RUN make
RUN make install

WORKDIR /app
# Invalidate cache for the next command
ARG CACHEBUST=1
# Copy main.cpp into Docker container (should not be cached)
COPY main.cpp .

# Update LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}

# Invalidate cache for the next command, make sure the compilation happens each time we build image!
ARG CACHEBUST=1

# Compile the C++ program
RUN g++ -o main /app/main.cpp -lboost_system -lcrypto -lssl -lcpprest -lpthread

# Run the program
CMD ["./main"]  