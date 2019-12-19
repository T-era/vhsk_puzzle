import std.algorithm : map, sort;
import std.range : array;

import structs : WallMap, Cell, Result;

void main() {
	import std.stdio : writef, writefln, writeln, stdin;
	import reader : readLines;
	import seeker : seekAll;

	WallMap wm = readLines(stdin);
	wm.seekAll();

	foreach (Cell[] line; wm.cells) {
		foreach (Cell cell; line) {
			writef("%s ", cell);
		}
		writeln();
	}
	writeln(
		Result.all
			.sort!((a,b)=>a.size > b.size)
			.map!(a=>a.size / 2)
			.array);
}
