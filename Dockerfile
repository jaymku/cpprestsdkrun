# Select base image
FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y tzdata

# Install necessary packages
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

# Copy main.cpp into Docker container
COPY main.cpp /main.cpp

# Compile the C++ program
RUN g++ -o main /main.cpp -lboost_system -lcrypto -lssl -lcpprest -lpthread

# Run the program
#CMD ["./main"]
CMD ["sleep", "2h"]

#docker-compose up --build  