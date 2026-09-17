//! By convention, root.zig is the root source file when making a package.
const std = @import("std");
const Io = std.Io;
const net = std.Io.net;
const posix = std.posix;

pub fn printAnotherMessage(writer: *std.Io.Writer) !void {
    var gpa = std.heap.DebugAllocator(.{}){};
    const allocator = gpa.allocator();

    const name: []const u8 = "Chris";
    const output = try std.fmt.allocPrint(allocator, "Hello {s}!!!", .{name});

    try writer.print("{s}\n", .{output});

    const random_number = try allocator.create(u32);
    defer allocator.destroy(random_number);

    random_number.* = @as(u32, 22);
    try writer.print("Number: {d}\n", .{random_number.*});

    try writer.flush();
}

pub fn fixedBufferAllocator() !void {
    var buffer: [10]u8 = undefined;

    for(0..buffer.len) |i| {
        buffer[i] = 0;
    }
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();
    const input = try allocator.alloc(u8, 5);
   
    defer allocator.free(input);

}

pub fn heapFixedBufferAllocator() !void {
    //creation of a heap page_allocator with a fixed size of 4KB
    const heap = std.heap.page_allocator;

    const memory_buffer = try heap.alloc(u8, 1024);
    defer heap.free(memory_buffer);
    var fba = std.heap.FixedBufferAllocator.init(memory_buffer);

    const allocator = fba.allocator();

    const input = try allocator.alloc(u8, 124);
    defer allocator.free(input);
}

