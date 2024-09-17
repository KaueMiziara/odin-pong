package pong

import rl "vendor:raylib"

main :: proc() {
	WINDOW_WIDTH :: 1280
	WINDOW_HEIGHT :: 800

	ball := Ball{WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2, 7, 7, 20}

	rl.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "!")
	rl.SetTargetFPS(60)

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()

		update_ball_position(&ball)

        rl.ClearBackground(rl.BLACK)
		draw_ball(&ball)

		rl.EndDrawing()
	}

	rl.CloseWindow()
}
