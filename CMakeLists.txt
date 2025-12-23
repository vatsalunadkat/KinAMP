cmake_minimum_required(VERSION 3.5)
project(KinAMP)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(PkgConfig REQUIRED)

pkg_check_modules(GTK IMPORTED_TARGET REQUIRED gtk+-2.0)
pkg_check_modules(XML IMPORTED_TARGET REQUIRED libxml-2.0)

find_package(Threads REQUIRED)

add_subdirectory(miniaudio)

add_executable(${PROJECT_NAME}
    music_player.cpp
    music_backend.cpp
    gtk_utils.cpp
)

target_link_libraries(${PROJECT_NAME} PRIVATE
    PkgConfig::GTK
    PkgConfig::XML
    Threads::Threads
    miniaudio
    gstreamer-0.10
    gthread-2.0
    lipc
    dl
)

target_compile_options(${PROJECT_NAME} PRIVATE -Wall -Wextra)