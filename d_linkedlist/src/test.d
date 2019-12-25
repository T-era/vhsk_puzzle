import std.stdio;
import std.algorithm : sort;

import world : World;

void main() {
	World w = World.readFile(stdin);
	w.join();

	writeln(w.countUp().sort!("a>b"));
}
