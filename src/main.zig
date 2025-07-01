//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.

const Lexer = @import("lexer/engine.zig");

pub fn main() !void {
    print("Hello, World!\n", .{});
}

const std = @import("std");
// print solo de debugging
const print = std.debug.print;
