import structs : Wall;

enum Direction { ToUp, ToDown, ToLeft, ToRight };

size_t dx(Direction d, size_t x) {
	if (d == Direction.ToLeft) {
		return x - 1;
	} else if (d == Direction.ToRight) {
		return x + 1;
	}
	return x;
}
size_t dy(Direction d, size_t y) {
	if (d == Direction.ToUp) {
		return y - 1;
	} else if (d == Direction.ToDown) {
		return y + 1;
	}
	return y;
}
bool isLeft(Direction d, Wall wall) {
	final switch (d) {
	case Direction.ToUp:
		return wall == Wall.LU;
	case Direction.ToDown:
		return wall != Wall.LU;
	case Direction.ToLeft:
		return false;
	case Direction.ToRight:
		return true;
	}
}
Direction next(Direction d, Wall wall) {
	if (wall == Wall.LU) {
		final switch (d) {
		case Direction.ToUp:
			return Direction.ToLeft;
		case Direction.ToDown:
			return Direction.ToRight;
		case Direction.ToLeft:
			return Direction.ToUp;
		case Direction.ToRight:
			return Direction.ToDown;
		}
	} else {
		final switch (d) {
			case Direction.ToUp:
				return Direction.ToRight;
			case Direction.ToDown:
				return Direction.ToLeft;
			case Direction.ToLeft:
				return Direction.ToDown;
			case Direction.ToRight:
				return Direction.ToUp;
		}
	}
}
