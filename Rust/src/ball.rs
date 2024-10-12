use std::vec;

use rand::seq::SliceRandom;
use raylib::{
    color::Color,
    ffi::CheckCollisionCircleRec,
    math::Vector2,
    prelude::{RaylibDraw, RaylibDrawHandle},
};

use crate::bar::Bar;

pub struct Ball {
    pub x: i32,
    pub y: i32,
    pub radius: f32,
    pub speed: Vector2,
}

impl Ball {
    pub fn new(x: i32, y: i32, radius: f32, speed: Vector2) -> Ball {
        Ball {
            x,
            y,
            radius,
            speed,
        }
    }

    pub fn draw(&self, d: &mut RaylibDrawHandle) {
        d.draw_circle(self.x, self.y, self.radius, Color::WHITE);
    }

    pub fn update_pos(&mut self, d: &mut RaylibDrawHandle) {
        self.x += self.speed.x as i32;
        self.y += self.speed.y as i32;

        if self.get_right() >= d.get_screen_width() || self.get_left() <= 0 {
            self.speed.x *= -1.0;
        }

        if self.get_bottom() >= d.get_screen_height() || self.get_top() <= 0 {
            self.speed.y *= -1.0;
        }
    }

    // TODO: refactor to safe Rust
    pub fn check_collision(&mut self, player: &Bar) {
        unsafe {
            if CheckCollisionCircleRec(
                Vector2::new(self.x as f32, self.y as f32).into(),
                self.radius,
                raylib::ffi::Rectangle {
                    x: player.x as f32,
                    y: player.y as f32,
                    width: player.width as f32,
                    height: player.height as f32,
                },
            ) {
                self.speed.x *= -1.0;
            }
        }
    }

    pub fn reset(&mut self, d: &mut RaylibDrawHandle) {
        self.x = d.get_screen_width() / 2;
        self.y = d.get_screen_height() / 2;

        let speed_choices = vec![-1.0, 1.0];
        self.speed.x *= speed_choices.choose(&mut rand::thread_rng()).unwrap();
    }

    pub fn get_left(&self) -> i32 {
        self.x - self.radius as i32
    }

    pub fn get_right(&self) -> i32 {
        self.x + self.radius as i32
    }

    pub fn get_top(&self) -> i32 {
        self.y - self.radius as i32
    }

    pub fn get_bottom(&self) -> i32 {
        self.y + self.radius as i32
    }
}
