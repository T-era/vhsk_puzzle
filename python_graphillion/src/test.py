from graphillion import GraphSet

from reader import readFile

def test(file):
    pathList = readFile(file)
    GraphSet.set_universe(pathList)
    cycles = GraphSet.cycles()
    sizeList = sorted([
        len(cycle) / 2
        for cycle in cycles])

    sizeList.reverse()
    print(sizeList)


if __name__ == '__main__':
    import sys
    test(sys.stdin)
