use raylib::{
    color::Color,
    prelude::{RaylibDraw, RaylibDrawHandle},
};

use crate::ball::Ball;

pub struct Score {
    pub player_l: u8,
    pub player_r: u8,
}

impl Score {
    pub fn new() -> Self {
        Self {
            player_l: 0,
            player_r: 0,
        }
    }

    pub fn draw(&self, d: &mut RaylibDrawHandle) {
        d.draw_text(
            &self.player_l.to_string(),
            d.get_screen_width() / 4 - 20,
            20,
            80,
            Color::WHITE,
        );

        d.draw_text(
            &self.player_r.to_string(),
            3 * d.get_screen_width() / 4 - 20,
            20,
            80,
            Color::WHITE,
        );
    }

    pub fn check_scored(&mut self, ball: &mut Ball, d: &mut RaylibDrawHandle) {
        if ball.get_right() >= d.get_screen_width() {
            self.player_l += 1;
            ball.reset(d);
        }

        if ball.get_left() <= 0 {
            self.player_r += 1;
            ball.reset(d);
        }
    }
}
