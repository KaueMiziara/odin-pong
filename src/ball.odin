package pong

import rl "vendor:raylib"

Ball :: struct {
	x, y:             i32,
	speed_x, speed_y: i32,
	radius:           f32,
}

draw_ball :: proc(ball: ^Ball) {
	rl.DrawCircle(ball.x, ball.y, ball.radius, rl.WHITE)
}

update_ball_position :: proc(ball: ^Ball) {
	ball.x += ball.speed_x
	ball.y += ball.speed_y

	if (ball.x + (i32)(ball.radius) >= rl.GetScreenWidth() || ball.x - (i32)(ball.radius) <= 0) {
		ball.speed_x *= -1
	}

	if (ball.y + (i32)(ball.radius) >= rl.GetScreenHeight() || ball.y - (i32)(ball.radius) <= 0) {
		ball.speed_y *= -1
	}
}
