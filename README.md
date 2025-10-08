# How-to build and run

0. Make sure you have a correct `CMakeLists.txt` file to build the source code and tests.
```bash
cmake_minimum_required(VERSION 3.10)
project(pangram_test LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(my_exercise my_exercise.cpp)
add_executable(my_exercise_test my_exercise_test.cpp)
target_link_libraries(my_exercise_test my_exercise gtest pthread)
```

To build and run your pangram code and Google Test unit tests on Linux, follow these steps:

1. Install Google Test
If you use Ubuntu/Debian:
```bash
sudo apt-get install libgtest-dev
sudo apt-get install cmake # if not already installed
cd /usr/src/gtest
sudo cmake .
sudo make
sudo cp *.a /usr/lib
```

2. Build the target project
```bash
mkdir build
cd build
cmake ..
make
```

3. Run the test
```bash
./my_exercise_test
```
