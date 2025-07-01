const std = @import("std");
const print = std.debug.print;

const Lexer = struct {
    source: []const u8, // source code to be tokenized
    position: usize, // current position in the source code
    

    pub fn toString(self: Lexer, allocator: std.mem.Allocator) ![]u8 {
        return std.fmt.allocPrint(allocator, "Lexer(source: '{s}', position: {})", .{
            self.source,
            self.position,
        });
    }
};

pub fn init(source: []const u8) Lexer {
    return Lexer{
        .source = source,
        .position = 0,
    };
}

test "lexer print" {
    const allocator = std.testing.allocator;

    const source = "let x = 10;";
    const lexer = init(source);

    const actual = try lexer.toString(allocator);
    defer allocator.free(actual);
    
    // Expected output format: Lexer(source: 'let x = 10;', position: 0)
    std.debug.print("DEBUG: {s}\n", .{actual});
    try std.testing.expectEqualStrings(actual, "Lexer(source: 'let x = 10;', position: 0)");
}
