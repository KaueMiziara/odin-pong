package pong

import rl "vendor:raylib"

main :: proc() {
    WINDOW_WIDTH  :: 800
    WINDOW_HEIGHT :: 450

    rl.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "!")

    for !rl.WindowShouldClose() {
        rl.BeginDrawing()

        rl.ClearBackground(rl.BLACK)
        rl.DrawText("!", 190, 200, 20, rl.LIGHTGRAY)

        rl.EndDrawing()
    }

    rl.CloseWindow()
}
