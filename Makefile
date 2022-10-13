all:
	@echo nothing special

clean:
	rm -rf build dist cmake_example.egg-info
force_clean:
	docker run --rm -v `pwd`:`pwd` -w `pwd` -it alpine/make make clean
.PHONY: clean force_clean

build:
	mkdir -p build && cd build && \
	cmake .. && make
.PHONY: build

DOCKER_TAG_WINDOWS ?= ghcr.io/cubao/build-env-windows-x64:v0.0.1
DOCKER_TAG_LINUX ?= ghcr.io/cubao/build-env-manylinux2014-x64:v0.0.1
DOCKER_TAG_MACOS ?= ghcr.io/cubao/build-env-macos-arm64:v0.0.1 

test_in_win:
	docker run --rm -w `pwd` -v `pwd`:`pwd` -v `pwd`/build/win:`pwd`/build -it $(DOCKER_TAG_WINDOWS) bash
test_in_mac:
	docker run --rm -w `pwd` -v `pwd`:`pwd` -v `pwd`/build/mac:`pwd`/build -it $(DOCKER_TAG_MACOS) bash
test_in_linux:
	docker run --rm -w `pwd` -v `pwd`:`pwd` -v `pwd`/build/win:`pwd`/build -it $(DOCKER_TAG_LINUX) bash

python_install:
	python3 setup.py install
python_build:
	python3 setup.py bdist_wheel
python_test:
	python3 -c 'import cmake_example; print(cmake_example.add(1, 2))'

python_build_py36:
	PYTHON_EXECUTABLE=python BUILD_DIR=$(BUILD_DIR)/py36 conda run --no-capture-output -n py36 make python_build
python_build_py37:
	PYTHON_EXECUTABLE=python BUILD_DIR=$(BUILD_DIR)/py37 conda run --no-capture-output -n py37 make python_build
python_build_py38:
	PYTHON_EXECUTABLE=python BUILD_DIR=$(BUILD_DIR)/py38 conda run --no-capture-output -n py38 make python_build
python_build_py39:
	PYTHON_EXECUTABLE=python BUILD_DIR=$(BUILD_DIR)/py39 conda run --no-capture-output -n py39 make python_build
python_build_py310:
	PYTHON_EXECUTABLE=python BUILD_DIR=$(BUILD_DIR)/py310 conda run --no-capture-output -n py310 make python_build
python_build_all: python_build_py36 python_build_py37 python_build_py38 python_build_py39 python_build_py310
python_build_all_in_linux:
	docker run --rm -w `pwd` -v `pwd`:`pwd` -v `pwd`/build/win:`pwd`/build -it $(DOCKER_TAG_LINUX) make python_build_all

pypi_remote ?= local
upload_wheels:
	python3 -m pip install twine
	twine upload dist/* -r $(pypi_remote)