cmake_minimum_required(VERSION 3.16)

project(InertiaGamesGenerator VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)

if(CMAKE_BUILD_TYPE STREQUAL RELEASE)
    set(CMAKE_CXX_FLAGS_RELEASE "-Ofast")
endif()

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Widgets)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appInertiaGamesGenerator main.cpp)

qt_add_qml_module(appInertiaGamesGenerator
                  URI InertiaGamesGenerator

                  VERSION 1.0

                  QML_FILES
                  Main.qml

                  SOURCES
                  games-data-path.cpp
                  games-data-path.hpp)

set_target_properties(appInertiaGamesGenerator PROPERTIES
                      MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
                      MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
                      MACOSX_BUNDLE TRUE
                      WIN32_EXECUTABLE TRUE)

target_link_libraries(appInertiaGamesGenerator PRIVATE Qt6::Quick Qt6::Widgets)

include(GNUInstallDirs)

install(TARGETS appInertiaGamesGenerator
        BUNDLE DESTINATION .
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
