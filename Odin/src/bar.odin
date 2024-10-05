package pong

import rl "vendor:raylib"

Bar :: struct {
	x, y:          i32,
	width, height: i32,
	speed:         i32,
	keys:          [2]rl.KeyboardKey,
}

draw_bar :: proc(bar: ^Bar) {
	rl.DrawRectangle(bar.x, bar.y, bar.width, bar.height, rl.WHITE)
}

update_bar_position :: proc(bar: ^Bar) {
	if (rl.IsKeyDown(bar.keys[0])) {
		bar.y -= bar.speed
	}

	if (rl.IsKeyDown(bar.keys[1])) {
		bar.y += bar.speed
	}

	if (bar.y <= 0) {
		bar.y = 0
	}

	if (bar.y + bar.height >= rl.GetScreenHeight()) {
		bar.y = rl.GetScreenHeight() - bar.height
	}
}
