package pong

import rl "vendor:raylib"

Bar :: struct {
	x, y:          i32,
	width, height: i32,
	speed:         i32,
}

new_bar :: proc(x: i32, y: i32, width: i32, height: i32, speed: i32) -> Bar {
	return Bar{x, y, width, height, speed}
}

draw_bar :: proc(bar: ^Bar) {
	rl.DrawRectangle(bar.x, bar.y, bar.width, bar.height, rl.WHITE)
}

update_bar_position :: proc(bar: ^Bar) {
	if (rl.IsKeyDown(rl.KeyboardKey.UP)) {
		bar.y -= bar.speed
	}

	if (rl.IsKeyDown(rl.KeyboardKey.DOWN)) {
		bar.y += bar.speed
	}

	if (bar.y <= 0) {
		bar.y = 0
	}

	if (bar.y + bar.height >= rl.GetScreenHeight()) {
		bar.y = rl.GetScreenHeight() - bar.height
	}
}
