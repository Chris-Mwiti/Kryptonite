//! By convention, root.zig is the root source file when making a package.
const std = @import("std");
const Io = std.Io;
const net = std.Io.net;
const posix = std.posix;

pub fn printAnotherMessage(writer: *std.Io.Writer) !void {
    var gpa = std.heap.DebugAllocator(.{}){};
    const allocator = gpa.allocator();

    const name: [] const u8 = "Chris";
    const output = try std.fmt.allocPrint(allocator, "Hello {s}!!!", .{name});

    try writer.print("{s}\n", .{output});
    try writer.flush();
}

