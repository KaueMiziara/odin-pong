package pong

import rl "vendor:raylib"

main :: proc() {
    rl.InitWindow(800, 450, "Hello, world!")

    for !rl.WindowShouldClose() {
        rl.BeginDrawing()

        rl.ClearBackground(rl.RAYWHITE)
        rl.DrawText("Hellope!", 190, 200, 20, rl.LIGHTGRAY)

        rl.EndDrawing()
    }

    rl.CloseWindow()
}
