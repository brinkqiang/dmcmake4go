package main

import (
    "fmt"
    "time"
)

func main() {

    now := time.Now()

    fmt.Println(now)
    
    // 必须使用这个时间才能返回正确的格式化后的时间，其他的都不行
    fmt.Println(now.Format("2006/1/2 15:04:05"))
    fmt.Println(now.Format("2006/01/02 15:04:05"))
    fmt.Println(now.Format("15:04:05 2006/1/2"))
	fmt.Println(now.Format("2006/1/2"))
	
    fmt.Printf("This is a golang project with cmake %d.", 2018)
}
