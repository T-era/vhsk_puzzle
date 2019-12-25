import std.stdio : File;
import std.algorithm : map;
import std.range : array;

import structs : Box, Cell, Wall;

class World {
	Box[][] world = [];

	static World readFile(File file) {
		World ret = new World();
		size_t y = 0;
		foreach (line; file.byLine()) {
			ret.readLine(line, y);
			y ++;
		}
		return ret;
	}
	private void readLine(char[] line, size_t y) {
		size_t x = 0;
		this.world ~= line.map!(d => readChar(d, x ++, y)).array();
	}
	private Box readChar(dchar c, size_t x, size_t y) {
		if (c == '\\') {
			return new  Box(Wall.LU);
		} else {
			return new Box(Wall.RU);
		}
	}

	public void join() {
		foreach (y, line; world) {
			foreach (x, box; line) {
				if (x > 0) {
					box.joinLeft(world[y][x-1]);
				}
				if (y > 0) {
					box.joinTop(world[y-1][x]);
				}
			}
		}
	}

	public int[] countUp() {
		int[] ret = [];
		void add(int newCnt) {
			if (newCnt > 0) {
				ret ~= newCnt / 2;
			}
		}
		foreach (line; world) {
			foreach (box; line) {
				add(countStart(box.top));
				add(countStart(box.bottom));
			}
		}
		return ret;
	}
}

int countStart(Cell c) {
	c.counted = true;
	c.joinedInBox.counted = true;
	return count(c, c.joinedInBox.joinedWith, 1);
}
int count(Cell start, Cell temp, int tempCnt) {
	if (temp == start) {
		return tempCnt;
	} else if (temp is null) {
		return -1;
	} else if (temp.counted) {
		return -1;
	} else {
		temp.counted = true;
		temp.joinedInBox.counted = true;
		return count(start, temp.joinedInBox.joinedWith, tempCnt + 1);
	}
}
