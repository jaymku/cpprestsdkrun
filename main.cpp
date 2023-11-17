#include <cpprest/http_client.h>
#include <iostream>

using namespace web;

int validateUrl(){
    utility::string_t url = U("ihttp://localhost:3030");
    std::cout << "Given URI is:" << url << std::endl;
    if(uri::validate(url))
        std::cout << "URI is valid." << std::endl;
    else
        std::cout << "URI is not valid." << std::endl;
    return 0;
}
int fetchUrl(){
    web::http::client::http_client client(U("http://jsonplaceholder.typicode.com"));

    client.request(web::http::methods::GET, U("/posts/1")).then([](web::http::http_response response) {
        // Extract and display the response body
        return response.extract_string();
    }).then([](std::string body){
        std::cout << "Response body:"<< body << std::endl;
    }).wait();

    return 0;
}

int main() {
    validateUrl();
    fetchUrl();
    return 0;
}

