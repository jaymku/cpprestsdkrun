# cpprestsdkrun
Cpp app to validate a URI using cpprestsdk. 

## Build & Run
docker-compose up --build 

## Outcome

```sh
root@41482d144397:/skadoosh/build.release# g++ -o main /app/main.cpp -lboost_system -lcrypto -lssl -lcpprest -lpthread
root@41482d144397:/skadoosh/build.release# ./main 
Given URI is:¡http://localhost:3030/
URI is not valid.
root@41482d144397:/skadoosh/build.release# g++ -o main /app/main.cpp -lboost_system -lcrypto -lssl -lcpprest -lpthread
root@41482d144397:/skadoosh/build.release# ./main 
Given URI is:http://localhost:3030/
URI is valid.

```

