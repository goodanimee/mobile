cmake_minimum_required(VERSION 3.10.2)
project(go_backend)

if(${ANDROID_ABI} STREQUAL "armeabi-v7a")
  file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/dummy.cpp "")
  file(GLOB_RECURSE BACKEND_SOURCE_FILES "${CMAKE_SOURCE_DIR}/../../backend/*.go" "${CMAKE_SOURCE_DIR}/../../backend/*.graphql")
  add_library(backend SHARED ${CMAKE_CURRENT_BINARY_DIR}/dummy.cpp ${BACKEND_SOURCE_FILES})
  set_source_files_properties(${BACKEND_SOURCE_FILES} PROPERTIES HEADER_FILE_ONLY TRUE)
  return()
elseif(${ANDROID_ABI} STREQUAL "arm64-v8a")
  set(GOARCH "arm64")
elseif(${ANDROID_ABI} STREQUAL "x86")
  set(GOARCH "386")
elseif(${ANDROID_ABI} STREQUAL "x86_64")
  set(GOARCH "amd64")
else()
  set(GOARCH "arm64")
endif()

file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/dummy.cpp "")
file(GLOB_RECURSE BACKEND_SOURCE_FILES "${CMAKE_SOURCE_DIR}/../../backend/*.go" "${CMAKE_SOURCE_DIR}/../../backend/*.graphql")
add_library(backend SHARED ${CMAKE_CURRENT_BINARY_DIR}/dummy.cpp ${BACKEND_SOURCE_FILES})
set_source_files_properties(${BACKEND_SOURCE_FILES} PROPERTIES HEADER_FILE_ONLY TRUE)
set(CGO_FLAGS "--target=${CMAKE_C_COMPILER_TARGET} --sysroot=${CMAKE_SYSROOT} ${CMAKE_C_FLAGS}")
set(CGO_LDFLAGS "--target=${CMAKE_C_COMPILER_TARGET} --sysroot=${CMAKE_SYSROOT} ${CMAKE_SHARED_LINKER_FLAGS}")

add_custom_command(
    TARGET backend POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E env
            "CGO_ENABLED=1"
            "GOOS=android"
            "GOARCH=${GOARCH}"
            "CC=${CMAKE_C_COMPILER}"
            "CGO_CFLAGS=${CGO_FLAGS}"
            "CGO_LDFLAGS=${CGO_LDFLAGS}"
            go build -buildmode=c-shared -buildvcs=false -o $<TARGET_FILE:backend> .
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/../../backend
)
