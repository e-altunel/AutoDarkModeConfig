import json
import sys


def main(config_path: str, force: bool, args: list[str]):
    if len(args) % 2 != 0:
        print("Invalid number of arguments")
        return

    try:
        with open(config_path, "r", encoding="utf-8") as file:
            data = json.load(file)
    except FileNotFoundError:
        data = {}

    for i in range(0, len(args), 2):
        key = args[i].split(".")
        value = args[i + 1]
        temp = data
        for j in range(len(key) - 1):
            if key[j] not in temp:
                if force:
                    temp[key[j]] = {}
                else:
                    print(f"Key {'.'.join(key)} does not exist")
                    break
            if not isinstance(temp[key[j]], dict):
                if force:
                    temp[key[j]] = {}
                else:
                    print(f"Key {'.'.join(key)} is not a dictionary")
                    break
            temp = temp[key[j]]

        if key[-1] not in temp and not force:
            print(f"Key {'.'.join(key)} does not exist")
            continue
        temp[key[-1]] = value
    with open(config_path, "w", encoding="utf-8") as file:
        json.dump(data, file, indent=4)


if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Usage: python terminal.py <config_path> <force> <key> <value>")
    main(sys.argv[1], sys.argv[2] == "true", sys.argv[3:])
