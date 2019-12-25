enum Wall { LU, RU }

class Cell {
	bool counted = false;
	Cell joinedInBox;
	Cell joinedWith;
	void joinInBox(Cell c2) {
		this.joinedInBox = c2;
		c2.joinedInBox = this;
	}
	void joinWith(Cell c2) {
		this.joinedWith = c2;
		c2.joinedWith = this;
	}
}
class Box {
	Cell top;
	Cell bottom;
	Cell left;
	Cell right;

	this(Wall wall) {
		this.top = new Cell();
		this.bottom = new Cell();
		this.left = new Cell();
		this.right = new Cell();

		final switch (wall) {
			case Wall.LU:
				setLU();
				break;
			case Wall.RU:
				setRU();
				break;
		}
	}
	private void setLU() {
		top.joinInBox(right);
		bottom.joinInBox(left);
	}
	private void setRU() {
		top.joinInBox(left);
		bottom.joinInBox(right);
	}
	public void joinTop(Box upper) {
		this.top.joinWith(upper.bottom);
	}
	public void joinLeft(Box lefter) {
		this.left.joinWith(lefter.right);
	}
}
