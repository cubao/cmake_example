# cmake-example

Online document: **[readthedocs](http://cmake-example.readthedocs.io/)**

<!--intro-start-->

## Usage

Install:

```bash
python3 -m pip install cubao_cmake_example # install from pypi
python3 -c 'import cubao_cmake_example; print(cubao_cmake_example.add(1, 2))'
```

CLI interface: (created with [python-fire](https://github.com/google/python-fire))

```bash
python3 -m cubao_cmake_example add 1 2
python3 -m cubao_cmake_example subtract 9 4
```

Help:

```bash
$ python3 -m cubao_cmake_example --help
INFO: Showing help with the command '__main__.py -- --help'.

NAME
    __main__.py

SYNOPSIS
    __main__.py GROUP | COMMAND

GROUPS
    GROUP is one of the following:

     fire
       The Python Fire module.

COMMANDS
    COMMAND is one of the following:

     add
       add(arg0: int, arg1: int) -> int

     subtract
       subtract(arg0: int, arg1: int) -> int

     pure_python_func
```

```bash
$ python3 -m cubao_cmake_example pure_python_func --help
INFO: Showing help with the command '__main__.py pure_python_func -- --help'.

NAME
    __main__.py pure_python_func

SYNOPSIS
    __main__.py pure_python_func <flags>

FLAGS
    --arg1=ARG1
        Type: int
        Default: 42
    --arg2=ARG2
        Type: float
        Default: 3.14
    --arg3=ARG3
        Type: str
        Default: 'you shall not pass'

$ python3 -m cubao_cmake_example pure_python_func --arg1=43234
int: 43234, float: 3.14, str: you shall not pass
```

<!--intro-end-->

---

# Make a release

(We now use Github Workflow to release to pypi. Skip the rest if you don't want to manually compile wheels.)

## On linux

Install docker then

```
make python_build_all_in_linux
make upload_wheels
```

## On macOS

Install c++ compiler and cmake.

Install conda and envs:

```
# conda create -y -n py36 python=3.6
# conda create -y -n py37 python=3.7
conda create -y -n py38 python=3.8
conda create -y -n py39 python=3.9
conda create -y -n py310 python=3.10
conda env list
```

Then

```
make python_build_all_in_macos
make upload_wheels
```

## On windows

Install visual studio and cmake, (also git for windows, maybe).

Install conda and envs same as on macOS, then:

```
make python_build_all_in_windows
make upload_wheels
```

---

# cmake_example for pybind11

[![Gitter][gitter-badge]][gitter-link]

|      CI              | status |
|----------------------|--------|
| MSVC 2015            | [![AppVeyor][appveyor-badge]][appveyor-link] |
| conda.recipe         | [![Conda Actions Status][actions-conda-badge]][actions-conda-link] |
| pip builds           | [![Pip Actions Status][actions-pip-badge]][actions-pip-link] |
| [`cibuildwheel`][]   | [![Wheels Actions Status][actions-wheels-badge]][actions-wheels-link] |

[gitter-badge]:            https://badges.gitter.im/pybind/Lobby.svg
[gitter-link]:             https://gitter.im/pybind/Lobby
[actions-badge]:           https://github.com/pybind/cmake_example/workflows/Tests/badge.svg
[actions-conda-link]:      https://github.com/pybind/cmake_example/actions?query=workflow%3A%22Conda
[actions-conda-badge]:     https://github.com/pybind/cmake_example/workflows/Conda/badge.svg
[actions-pip-link]:        https://github.com/pybind/cmake_example/actions?query=workflow%3A%22Pip
[actions-pip-badge]:       https://github.com/pybind/cmake_example/workflows/Pip/badge.svg
[actions-wheels-link]:     https://github.com/pybind/cmake_example/actions?query=workflow%3AWheels
[actions-wheels-badge]:    https://github.com/pybind/cmake_example/workflows/Wheels/badge.svg
[appveyor-link]:           https://ci.appveyor.com/project/dean0x7d/cmake-example/branch/master
[appveyor-badge]:          https://ci.appveyor.com/api/projects/status/57nnxfm4subeug43/branch/master?svg=true

An example [pybind11](https://github.com/pybind/pybind11) module built with a
CMake-based build system. This is useful for C++ codebases that have an
existing CMake project structure. This is in many cases superseded by
[`scikit_build_example`](https://github.com/pybind/scikit_build_example), which uses
[scikit-build][], a tool from the makers of CMake designed to allow Python
packages to be driven from CMake. However, there are still cases where you
might want full control over the CMake run; and both of these approaches have
some trade-offs not present in a pure setuptools build (see
[`python_example`](https://github.com/pybind/python_example)). Python 3.6+ required;
see the commit history for older versions of Python.

## Prerequisites

* A compiler with C++11 support
* Pip 10+ or CMake >= 3.4 (or 3.8+ on Windows, which was the first version to support VS 2015)
* Ninja or Pip 10+


## Installation

Just clone this repository and pip install. Note the `--recursive` option which is
needed for the pybind11 submodule:

```bash
git clone --recursive https://github.com/pybind/cmake_example.git
pip install ./cmake_example
```

With the `setup.py` file included in this example, the `pip install` command will
invoke CMake and build the pybind11 module as specified in `CMakeLists.txt`.



## Building the documentation

Documentation for the example project is generated using Sphinx. Sphinx has the
ability to automatically inspect the signatures and documentation strings in
the extension module to generate beautiful documentation in a variety formats.
The following command generates HTML-based reference documentation; for other
formats please refer to the Sphinx manual:

 - `cd cmake_example/docs`
 - `make html`


## License

Pybind11 is provided under a BSD-style license that can be found in the LICENSE
file. By using, distributing, or contributing to this project, you agree to the
terms and conditions of this license.


## Test call

```python
import cubao_cmake_example
cubao_cmake_example.add(1, 2)
```

[`cibuildwheel`]:          https://cibuildwheel.readthedocs.io
[FAQ]: http://pybind11.rtfd.io/en/latest/faq.html#working-with-ancient-visual-studio-2009-builds-on-windows
[vs2015_runtime]: https://www.microsoft.com/en-us/download/details.aspx?id=48145
[scikit-build]: https://scikit-build.readthedocs.io/en/latest/
