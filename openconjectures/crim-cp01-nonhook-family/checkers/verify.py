from functools import lru_cache


def mex(values):
    value = 0
    while value in values:
        value += 1
    return value


@lru_cache(None)
def grundy(partition, misere):
    if not partition:
        return 1 if misere else 0
    options = set()
    for index in range(len(partition)):
        remainder = tuple(sorted(partition[:index] + partition[index + 1:], reverse=True))
        options.add(grundy(remainder, misere))
    return mex(options)


def main():
    for m in range(2, 33):
        partition = (m, 2)
        assert grundy(partition, False) == 0
        assert grundy(partition, True) == 1
    print({"family": "[m,2]", "m_range": [2, 32], "conway_pair": [0, 1]})


if __name__ == "__main__":
    main()
