const std = @import("std");

const Position = struct {
    line: usize,
    column: usize,
    position: usize, // position in the source code
};

const TokenKind = enum {
    Identifier,
    Keyword,
    String,
    Integer,
    Float,
    Literal,
    Plus,
    Dash,
    Slash,
    Star,
    Equals,
};

const Token = struct {
    kind: TokenKind,
    value: []const u8,
    start: Position,
    end: Position,

    pub fn toString(self: Token, allocator: std.mem.Allocator) ![]u8 {
        return std.fmt.allocPrint(allocator,
            "Token(kind: {s}, value: '{s}', start: {}, end: {})",
            .{
                @tagName(self.kind),
                self.value,
                self.start.position,
                self.end.position,
            }
        );
    }
};

pub fn init(kind: TokenKind, value: []const u8, start: Position, end: Position) Token {
    return Token{
        .kind = kind,
        .value = value,
        .start = start,
        .end = end,
    };
}

test "tokens print" {
    const allocator = std.testing.allocator;

    const start = Position{ .line = 1, .column = 1, .position = 0 };
    const end = Position{ .line = 1, .column = 5, .position = 4 };
    const token = init(TokenKind.Identifier, "test", start, end);

    const actual = try token.toString(allocator);
    defer allocator.free(actual);
    // Expected output format: Token(kind: Identifier, value: 'test', start: 0, end: 4)
    const expected = "Token(kind: Identifier, value: 'test', start: 0, end: 4)";
    try std.testing.expectEqualStrings(expected, actual);
}

