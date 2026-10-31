"""Modules for dependencies not included in the Bazel Central Registry"""

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

def _non_module_deps_impl(_module_ctx):
    # FMDB is used to access SQLite from Objective-C(++) code.
    git_repository(
        name = "FMDB",
        remote = "https://github.com/ccgus/fmdb.git",
        commit = "1227a3fa2b9916bfd75fe380eb45cd210e69e251",  # tag = 2.7.12
        build_file = Label("//deps:BUILD.fmdb"),
    )

    # OCMock is used in several tests.
    git_repository(
        name = "OCMock",
        commit = "2c0bfd373289f4a7716db5d6db471640f91a6507",  # tag = v3.9.4
        remote = "https://github.com/erikdoe/ocmock",
        build_file = Label("//deps:BUILD.ocmock"),
    )

    # NATS C client library
    git_repository(
        name = "nats_c",
        remote = "https://github.com/nats-io/nats.c.git",
        commit = "6cb096a7fd24a1927037fd2a2ca2c6fbc5d64e47",  # tag = v3.14.0
        build_file = Label("//deps:BUILD.nats"),
        patches = [Label("//deps/patches/nats_c:0001-natssock-read-no-progress-bound.patch")],
        patch_args = ["-p1"],
    )

    # libcbor is a dependency of libfido2.
    git_repository(
        name = "libcbor",
        remote = "https://github.com/PJK/libcbor.git",
        commit = "6730c20ab487c0b4dc5fb3fea918937085355bac",  # tag = v0.14.0
        build_file = Label("//deps:BUILD.libcbor"),
    )

    # libfido2 provides FIDO2/WebAuthn hardware security key support.
    git_repository(
        name = "libfido2",
        remote = "https://github.com/Yubico/libfido2.git",
        commit = "b974e7cf2ee7392134cc12c08b76a068cf250dd8",  # tag = 1.17.0
        build_file = Label("//deps:BUILD.libfido2"),
    )

non_module_deps = module_extension(implementation = _non_module_deps_impl)
