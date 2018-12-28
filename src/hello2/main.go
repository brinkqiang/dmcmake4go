package main

import (
    "fmt"
    "hello2/math"
)

func main() {
    a := 1
    b := 2
    c := math.Add(a, b)
    fmt.Printf("This is a %x golang %x project %x with cmake.", a, b , c)
}
