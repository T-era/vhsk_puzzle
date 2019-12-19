import structs : WallMap, Cell, Result;
import directions : Direction, dx, dy;
import stepByStep : setOpen, seek;

void seekAll(WallMap wm) {
	foreach (y, line; wm.cells) {
		foreach(x, c; line) {
			if (! wm.isDone(x, y, true)) {
				// サイズ0で仮置き。
				c.leftResult = Result.temp;
				wm.startLeft(x, y);
			}
			if (! wm.isDone(x, y, false)) {
				// サイズ0で仮置き。
				c.rightResult = Result.temp;
				wm.startRight(x, y);
			}
		}
	}
}

void startLeft(WallMap wm, size_t x, size_t y) {
	wm.startToLeft(x, y);
	if (! wm.isDone(x, y, true) && wm.isClosed(x, y, true)) {
		if (wm.verticalToUp(x, y, true)) {
			wm.setOpenToUp(x, y);
		} else {
			wm.setOpenToDown(x, y);
		}
	}
}
void startRight(WallMap wm, size_t x, size_t y) {
	wm.startToRight(x, y);
	if (! wm.isDone(x, y, false) && wm.isClosed(x, y, false)) {
		if (wm.verticalToUp(x, y, false)) {
			wm.setOpenToUp(x, y);
		} else {
			wm.setOpenToDown(x, y);
		}
	}
}
bool isDone(WallMap wm, size_t x, size_t y, bool left) {
	if (left) {
		return wm.cells[y][x].leftResult !is null;
	} else {
		return wm.cells[y][x].rightResult !is null;
	}
}
bool isClosed(WallMap wm, size_t x, size_t y, bool left) {
	if (left) {
		return wm.cells[y][x].leftResult.isClosed;
	} else {
		return wm.cells[y][x].rightResult.isClosed;
	}
}

bool verticalToUp(WallMap wm, size_t x, size_t y, bool left) {
	return wm.cells[y][x].verticalToUp(left);
}

void startToLeft(WallMap wm, size_t x, size_t y) {
	Result result = seek(wm, x, y, Direction.ToLeft, 0);
	wm.cells[y][x].leftResult = result;
}
void startToRight(WallMap wm, size_t x, size_t y) {
	Result result = seek(wm, x, y, Direction.ToRight, 0);
	wm.cells[y][x].rightResult = result;
}
void setOpenToUp(WallMap wm, size_t x, size_t y) {
	setOpen(wm, x, y, Direction.ToUp);
}

void setOpenToDown(WallMap wm, size_t x, size_t y) {
	setOpen(wm, x, y, Direction.ToDown);
}
