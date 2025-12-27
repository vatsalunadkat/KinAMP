# --- armhf-toolchain.cmake ---
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)   # armv7hf

# Compilers
set(TARGET arm-linux-gnueabihf)
set(TOOLCHAIN_PREFIX /usr/bin/${TARGET})

set(CMAKE_C_COMPILER   ${TOOLCHAIN_PREFIX}-gcc)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}-g++)
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_PREFIX}-gcc)

# Sysroot + search
# Since we installed libraries using multiarch, the sysroot is effectively root
set(CMAKE_SYSROOT /)

# Search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Help Curses find the wide library on Linux targets
set(CURSES_NEED_WIDE TRUE CACHE BOOL "")

# PKG_CONFIG configuration
set(PKG_CONFIG_EXECUTABLE "/usr/bin/pkg-config" CACHE FILEPATH "")
set(ENV{PKG_CONFIG_LIBDIR} "/usr/lib/arm-linux-gnueabihf/pkgconfig:/usr/share/pkgconfig")

