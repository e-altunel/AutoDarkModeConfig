import sys
import shutil


def main(src: str, dst: str):
    shutil.copyfile(src, dst)


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
