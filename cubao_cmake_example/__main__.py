from cubao_cmake_example import *  # noqa

if __name__ == "__main__":
    import fire

    fire.core.Display = lambda lines, out: print(*lines, file=out)  # no pager for fire
    fire.Fire()
