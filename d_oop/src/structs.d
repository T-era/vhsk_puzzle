import std.format : format;

enum Wall { LU, RU }

class Result {
	static Result open;
	static Result temp;
	static Result[] all = [];
	
	static this() {
		open = new Result(false, 0);
		temp = new Result(true, 0);
	}
	bool isClosed;
	int size;
	this(bool isClosed, int size) {
		this.isClosed = isClosed;
		this.size = size;
	}
	public static Result closed(int size) {
		Result ret = new Result(true, size);
		all ~= ret;
		return ret;
	}
	override string toString() {
		return format("Result[%s %d]", isClosed, size);
	}
}
class Cell {
	Wall wall;
	Result rightResult;
	Result leftResult;

	override string toString() {
		return format("%d%s%d",
			leftResult is null ? 0 : leftResult.size / 2,
			wall.toString(),
			rightResult is null ? 0 : rightResult.size / 2);
	}
	bool verticalToUp(bool left) {
		return left ^ (wall == Wall.LU);
	}
}
class WallMap {
	size_t width;
	size_t height;
	Cell[][] cells;
}

string toString(Wall wl) {
	if (wl == Wall.LU) {
		return "\\";
	} else {
		return "/";
	}
}
