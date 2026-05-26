package main

/*
#include <stdlib.h>
#include <stdint.h>
*/
import "C"

import (
	"unsafe"
)

// FreeBuffer releases allocated byte buffer
//
//export FreeBuffer
func FreeBuffer(ptr *C.uint8_t) {
	C.free(unsafe.Pointer(ptr))
}

func main() {}
