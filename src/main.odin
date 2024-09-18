package pong

import rl "vendor:raylib"

main :: proc() {
	WINDOW_WIDTH :: 1280
	WINDOW_HEIGHT :: 800

	BARS_WIDTH :: 25
	BARS_HEIGHT :: 120

	ball := Ball{WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2, 7, 7, 20}

	player1 := Bar {
		WINDOW_WIDTH - BARS_WIDTH - 10,
		WINDOW_HEIGHT / 2 - BARS_HEIGHT / 2,
		BARS_WIDTH,
		BARS_HEIGHT,
		6,
		{rl.KeyboardKey.I, rl.KeyboardKey.K},
	}
	player2 := Bar {
		10,
		WINDOW_HEIGHT / 2 - BARS_HEIGHT / 2,
		BARS_WIDTH,
		BARS_HEIGHT,
		6,
		{rl.KeyboardKey.W, rl.KeyboardKey.S},
	}


	rl.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Pong")
	rl.SetTargetFPS(60)

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()

		update_ball_position(&ball)
		update_bar_position(&player1)
		update_bar_position(&player2)

		rl.ClearBackground(rl.BLACK)
		draw_ball(&ball)
		draw_bar(&player1)
		draw_bar(&player2)

		rl.EndDrawing()
	}

	free(&ball)
	free(&player1)
	free(&player2)

	rl.CloseWindow()
}
