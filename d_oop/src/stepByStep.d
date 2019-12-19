import structs : WallMap, Cell, Result;
import directions : Direction, dx, dy, next, isLeft;

alias Proc(T) = T delegate(size_t x, size_t y, Cell cell, Result* rp, Direction d);

T stepByStep(T)(WallMap wm, size_t px, size_t py, Direction pd, T init, Proc!(T) proc) {
	size_t x = pd.dx(px);
	size_t y = pd.dy(py);
	if (x < 0 || wm.width <= x
		|| y < 0 || wm.height <= y) {
		return init;
	}
	Cell cell = wm.cells[y][x];
	bool left = pd.isLeft(cell.wall);
	Result* rp = left ? &cell.leftResult : &cell.rightResult;
	Direction d = pd.next(cell.wall);

	return proc(x, y, cell, rp, d);
}
bool setOpen(WallMap wm, size_t px, size_t py, Direction pd) {
	return stepByStep!(bool)(wm, px, py, pd, false, (size_t x, size_t y, Cell cell, Result* rp, Direction d) {
		return setOpen(wm, x, y, d);
	});
}

Result seek(WallMap wm, size_t px, size_t py, Direction pd, int size) {
	return stepByStep!(Result)(wm, px, py, pd, Result.open, (size_t x, size_t y, Cell cell, Result* rp, Direction d) {
		Result result = *rp;
		if (result == Result.temp) {
			// 仮置きに戻ってきた。閉路
			Result r = Result.closed(size + 1);
			*rp = r;
			return r;
		} else if (result is null) {
			// 未踏
			Result fromNext = seek(wm, x, y, d, size + 1);
			*rp = fromNext;
			return fromNext;
		} else {
			return result;
//			throw new Exception("ココには来ないはず");
		}
	});
}
