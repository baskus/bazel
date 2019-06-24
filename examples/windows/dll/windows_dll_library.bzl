# This is a simple windows_dll_library rule for builing a DLL Windows
# that can be depended on by other cc rules.
#
# Example useage:
#   windows_dll_library(
#       name = "hellolib",
#       srcs = [
#           "hello-library.cpp",
#       ],
#       hdrs = ["hello-library.h"],
#       # Define COMPILING_DLL to export symbols during compiling the DLL.
#       copts = ["/DCOMPILING_DLL"],
#   )
#

def windows_dll_library(
        name,
        srcs = [],
        hdrs = [],
        visibility = None,
        **kwargs):
    """A simple windows_dll_library rule for builing a DLL Windows."""
    dll_name = name + ".dll"
    import_lib_name = name + "_import_lib"
    only_dll_name = name + "_only_dll.dll"
    import_target_name = name + "_dll_import"

    # Build the shared library
    native.cc_binary(
        name = dll_name,
        srcs = srcs + hdrs,
        linkshared = 1,
        **kwargs
    )

    # Set this to true to use the new "first_artifact" output group of
    # cc_binary. This will only work when using a Bazel binary built from this
    # repository.
    useFix = False

    # Get the import library for the dll
    native.filegroup(
        name = import_lib_name,
        srcs = [":" + dll_name],
        output_group = "interface_library",
    )

    # Get the import library for the dll
    native.filegroup(
        name = only_dll_name,
        srcs = [":" + dll_name],
        output_group = "first_artifact",
    )

    # Because we cannot directly depend on cc_binary from other cc rules in deps attribute,
    # we use cc_import as a bridge to depend on the dll.
    native.cc_import(
        name = import_target_name,
        interface_library = ":" + import_lib_name,
        shared_library = ":" + (only_dll_name if useFix else dll_name),
    )

    # Create a new cc_library to also include the headers needed for the shared library
    native.cc_library(
        name = name,
        hdrs = hdrs,
        visibility = visibility,
        deps = [
            ":" + import_target_name,
        ],
    )
