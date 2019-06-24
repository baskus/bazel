load("//examples/windows/dll:windows_dll_library.bzl", "windows_dll_library")

# Define the shared library
windows_dll_library(
    name = "some_library",
    srcs = ["some_library.cpp"],
    hdrs = ["some_library.h"],
    # Define COMPILING_DLL to export symbols during compiling the DLL.
    # See some_library.h
    copts = ["/DCOMPILING_DLL"],
    visibility = ["//visibility:public"],
)
