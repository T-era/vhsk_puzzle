LU = True
RU = False

def readFile(file):
    walls = [[
            toWall(char)
            for char in line.strip()]
                for line in file.readlines()]

    height = len(walls)
    width = 0 if height == 0 else len(walls[0])
    print(walls)
    return pathsFromWalls(width, height, walls)

def toWall(c):
    if c == '/':
        return RU
    elif c == '\\':
        return LU

def pathsFromWalls(width, height, walls):
    # ここでは、正方形を上下に分けて考えてindexを振り、index間の接続を考えます。
    # `／`であれば、上側は{左隣と上隣}に接続し、下側は{右隣と下隣}に接続します。
    # `＼`であれば、上側は{右隣と上隣}に接続し、下側は{左隣と下隣}に接続します。
    # 左右の隣との接続が、上側か下側かは、隣の壁を見ないと判別できません。
    # 双方向グラフとして扱うため、実装上は右隣りと下隣は扱いません(グラフが二重化してしまう)
    def toIndex(x, y, upper):
        return (y * 2 + (0 if upper else 1)) * width + x
    paths = []
    for y, line in enumerate(walls):
        for x, wall in enumerate(line):
            leftIsUpper = True if x == 0 else line[x-1] == LU
            rightIsUpper = True if x == width - 1 else line[x+1] == RU
            if wall == LU:
                if y > 0:
                    paths.append((toIndex(x,y-1,False), toIndex(x,y,True)))

                if x > 0:
                    paths.append((toIndex(x-1,y,leftIsUpper), toIndex(x,y,False)))
            else:
                if x > 0:
                    paths.append((toIndex(x-1,y,leftIsUpper), toIndex(x,y,True)))
                if y > 0:
                    paths.append((toIndex(x,y-1,False), toIndex(x,y,True)))

    return paths
