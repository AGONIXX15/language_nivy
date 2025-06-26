const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const exe = b.addExecutable(.{
        .name = "language",
        .root_source_file =  b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(exe);

    const run_step = b.step("run", "Run the project");
    const run_exe = b.addRunArtifact(exe);
    run_step.dependOn(&run_exe.step);
}
