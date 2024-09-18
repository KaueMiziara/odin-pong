package pong

import rl "vendor:raylib"

Score :: struct {
	player_l, player_r: int,
}

check_scored :: proc(score: ^Score, ball: ^Ball) {
	if (get_ball_right_side(ball) >= rl.GetScreenWidth()) {
		score.player_l += 1
        reset_ball(ball)
	}

	if (get_ball_left_side(ball) <= 0) {
		score.player_r += 1
        reset_ball(ball)
	}
}
