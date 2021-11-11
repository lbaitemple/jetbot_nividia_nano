# Install script for directory: /home/jetbot/librealsense-2.49.0/wrappers/python

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/python3.6/pyrealsense2/pybackend2.cpython-36m-aarch64-linux-gnu.so.2.49.0"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/python3.6/pyrealsense2/pybackend2.cpython-36m-aarch64-linux-gnu.so.2"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/python3.6/pyrealsense2/pybackend2.cpython-36m-aarch64-linux-gnu.so"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHECK
           FILE "${file}"
           RPATH "")
    endif()
  endforeach()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3.6/pyrealsense2" TYPE SHARED_LIBRARY FILES
    "/home/jetbot/librealsense-2.49.0/build/wrappers/python/pybackend2.cpython-36m-aarch64-linux-gnu.so.2.49.0"
    "/home/jetbot/librealsense-2.49.0/build/wrappers/python/pybackend2.cpython-36m-aarch64-linux-gnu.so.2"
    "/home/jetbot/librealsense-2.49.0/build/wrappers/python/pybackend2.cpython-36m-aarch64-linux-gnu.so"
    )
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/python3.6/pyrealsense2/pybackend2.cpython-36m-aarch64-linux-gnu.so.2.49.0"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/python3.6/pyrealsense2/pybackend2.cpython-36m-aarch64-linux-gnu.so.2"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/python3.6/pyrealsense2/pybackend2.cpython-36m-aarch64-linux-gnu.so"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/python3.6/pyrealsense2/pyrealsense2.cpython-36m-aarch64-linux-gnu.so.2.49.0"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/python3.6/pyrealsense2/pyrealsense2.cpython-36m-aarch64-linux-gnu.so.2.49"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/python3.6/pyrealsense2/pyrealsense2.cpython-36m-aarch64-linux-gnu.so"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHECK
           FILE "${file}"
           RPATH "")
    endif()
  endforeach()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3.6/pyrealsense2" TYPE SHARED_LIBRARY FILES
    "/home/jetbot/librealsense-2.49.0/build/wrappers/python/pyrealsense2.cpython-36m-aarch64-linux-gnu.so.2.49.0"
    "/home/jetbot/librealsense-2.49.0/build/wrappers/python/pyrealsense2.cpython-36m-aarch64-linux-gnu.so.2.49"
    "/home/jetbot/librealsense-2.49.0/build/wrappers/python/pyrealsense2.cpython-36m-aarch64-linux-gnu.so"
    )
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/python3.6/pyrealsense2/pyrealsense2.cpython-36m-aarch64-linux-gnu.so.2.49.0"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/python3.6/pyrealsense2/pyrealsense2.cpython-36m-aarch64-linux-gnu.so.2.49"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/python3.6/pyrealsense2/pyrealsense2.cpython-36m-aarch64-linux-gnu.so"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHANGE
           FILE "${file}"
           OLD_RPATH "/home/jetbot/librealsense-2.49.0/build:"
           NEW_RPATH "")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/pyrealsense2/pyrealsense2Targets.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/pyrealsense2/pyrealsense2Targets.cmake"
         "/home/jetbot/librealsense-2.49.0/build/wrappers/python/CMakeFiles/Export/lib/cmake/pyrealsense2/pyrealsense2Targets.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/pyrealsense2/pyrealsense2Targets-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/pyrealsense2/pyrealsense2Targets.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/pyrealsense2" TYPE FILE FILES "/home/jetbot/librealsense-2.49.0/build/wrappers/python/CMakeFiles/Export/lib/cmake/pyrealsense2/pyrealsense2Targets.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/pyrealsense2" TYPE FILE FILES "/home/jetbot/librealsense-2.49.0/build/wrappers/python/CMakeFiles/Export/lib/cmake/pyrealsense2/pyrealsense2Targets-release.cmake")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/pyrealsense2" TYPE FILE FILES "/home/jetbot/librealsense-2.49.0/build/wrappers/python/pyrealsense2Config.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/pyrealsense2" TYPE FILE FILES "/home/jetbot/librealsense-2.49.0/build/wrappers/python/pyrealsense2ConfigVersion.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.

endif()

