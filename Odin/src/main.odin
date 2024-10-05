package pong

import rl "vendor:raylib"

main :: proc() {
	WINDOW_WIDTH :: 1280
	WINDOW_HEIGHT :: 800

	BARS_WIDTH :: 25
	BARS_HEIGHT :: 120

	score := Score{0, 0}

	ball := Ball{WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2, 7, 7, 20}

	player_r := Bar {
		WINDOW_WIDTH - BARS_WIDTH - 10,
		WINDOW_HEIGHT / 2 - BARS_HEIGHT / 2,
		BARS_WIDTH,
		BARS_HEIGHT,
		6,
		{rl.KeyboardKey.I, rl.KeyboardKey.K},
	}
	player_l := Bar {
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
		update_bar_position(&player_r)
		update_bar_position(&player_l)

		check_collision(&ball, &player_r)
		check_collision(&ball, &player_l)
        check_scored(&score, &ball)

		rl.ClearBackground(rl.BLACK)
		rl.DrawLine(WINDOW_WIDTH / 2, 0, WINDOW_WIDTH / 2, WINDOW_HEIGHT, rl.WHITE)
		draw_ball(&ball)
		draw_bar(&player_r)
		draw_bar(&player_l)

		rl.DrawText(rl.TextFormat("%i", score.player_l), WINDOW_WIDTH / 4 - 20, 20, 80, rl.WHITE)
		rl.DrawText(
			rl.TextFormat("%i", score.player_r),
			3 * WINDOW_WIDTH / 4 - 20,
			20,
			80,
			rl.WHITE,
		)

		rl.EndDrawing()
	}

	free(&ball)
	free(&player_r)
	free(&player_l)
	free(&score)

	rl.CloseWindow()
}

check_collision :: proc(ball: ^Ball, bar: ^Bar) {
	if (rl.CheckCollisionCircleRec(
			   rl.Vector2{f32(ball.x), f32(ball.y)},
			   ball.radius,
			   rl.Rectangle{f32(bar.x), f32(bar.y), f32(bar.width), f32(bar.height)},
		   )) {
		ball.speed_x *= -1
	}
}
