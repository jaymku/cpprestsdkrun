#include <cpprest/http_client.h>
#include <iostream>

using namespace web;

int main() {
    utility::string_t url = U("ihttp://localhost:7070/");
    std::cout << "Given URI is:" << url << std::endl;
    if(uri::validate(url))
        std::cout << "URI is valid." << std::endl;
    else
        std::cout << "URI is not valid." << std::endl;

    return 0;
}