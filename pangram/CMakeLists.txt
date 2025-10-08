cmake_minimum_required(VERSION 3.10)
project(pangram_test LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(pangram pangram.cpp)
add_executable(pangram_test pangram_test.cpp)
target_link_libraries(pangram_test pangram gtest pthread)