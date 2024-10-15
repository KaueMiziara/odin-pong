mod ball;
mod bar;
mod score;

use ball::Ball;
use bar::Bar;
use raylib::{
    color::Color,
    ffi::KeyboardKey,
    math::Vector2,
    prelude::{RaylibDraw, RaylibDrawHandle},
};
use score::Score;

fn main() {
    const WINDOW_WIDTH: i32 = 1280;
    const WINDOW_HEIGHT: i32 = 800;

    const BARS_WIDTH: i32 = 25;
    const BARS_HEIGHT: i32 = 120;

    let (mut rl, thread) = raylib::init()
        .size(WINDOW_WIDTH, WINDOW_HEIGHT)
        .title("Pong.rs")
        .build();

    rl.set_target_fps(60);

    let mut score = Score::new();

    let mut ball = Ball::new(
        WINDOW_WIDTH / 2,
        WINDOW_HEIGHT / 2,
        20.0,
        Vector2::new(7.0, 7.0),
    );

    let mut player_r = Bar::new(
        WINDOW_WIDTH - BARS_WIDTH - 10,
        (WINDOW_HEIGHT - BARS_HEIGHT) / 2,
        BARS_WIDTH,
        BARS_HEIGHT,
        6,
        vec![KeyboardKey::KEY_I, KeyboardKey::KEY_K],
    );

    let mut player_l = Bar::new(
        10,
        (WINDOW_HEIGHT - BARS_HEIGHT) / 2,
        BARS_WIDTH,
        BARS_HEIGHT,
        6,
        vec![KeyboardKey::KEY_W, KeyboardKey::KEY_S],
    );

    while !rl.window_should_close() {
        let mut d = rl.begin_drawing(&thread);

        ball.update_pos(&mut d);
        player_r.update_pos(&mut d);
        player_l.update_pos(&mut d);

        ball.check_collision(&player_l);
        ball.check_collision(&player_r);
        score.check_scored(&mut ball, &mut d);

        draw_game(&mut d, &ball, &player_r, &player_l, &score);
    }
}

fn draw_game(d: &mut RaylibDrawHandle, ball: &Ball, p1: &Bar, p2: &Bar, score: &Score) {
    d.clear_background(Color::BLACK);
    d.draw_line(
        d.get_screen_width() / 2,
        0,
        d.get_screen_width() / 2,
        d.get_screen_height(),
        Color::WHITE,
    );

    ball.draw(d);
    p1.draw(d);
    p2.draw(d);
    score.draw(d);
}
