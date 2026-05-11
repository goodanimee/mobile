package main

/*
#include <stdlib.h>
#include <stdint.h>
*/
import "C"

import (
	"unsafe"
)

// FreeBuffer releases a byte buffer previously allocated by one of the
// exported functions. Must be called after consuming the response bytes
// to avoid memory leaks.
//
//export FreeBuffer
func FreeBuffer(ptr *C.uint8_t) {
	C.free(unsafe.Pointer(ptr))
}

func main() {}
