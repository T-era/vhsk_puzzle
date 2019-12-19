import std.stdio : File;
import std.algorithm : map;
import std.range : array;

import structs : WallMap, Cell, Wall;

WallMap readLines(File file) {
	WallMap ret = new WallMap();
	foreach (line; file.byLine()) {
		ret.cells ~= readLine(line);
	}
	ret.height = ret.cells.length;
	ret.width = ret.cells[0].length;
	
	return ret;
}

Cell[] readLine(char[] line) {
	return line.map!(readChar).array();
}

Cell readChar(dchar c) {
	Cell cell = new Cell();
	if (c == '\\') {
		cell.wall = Wall.LU;
	} else {
		cell.wall = Wall.RU;
	}
	return cell;
}
