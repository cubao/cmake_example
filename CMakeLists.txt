cmake_minimum_required(VERSION 3.4...3.18)
project(cubao_cmake_example)

add_subdirectory(pybind11)
pybind11_add_module(pybind11_cubao_cmake_example src/main.cpp)

# EXAMPLE_VERSION_INFO is defined by setup.py and passed into the C++ code as a
# define (VERSION_INFO) here.
target_compile_definitions(pybind11_cubao_cmake_example
                           PRIVATE VERSION_INFO=${EXAMPLE_VERSION_INFO})
