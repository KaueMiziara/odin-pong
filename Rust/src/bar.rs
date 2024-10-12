use raylib::{
    color::Color,
    ffi::KeyboardKey,
    prelude::{RaylibDraw, RaylibDrawHandle},
};

pub struct Bar {
    pub x: i32,
    pub y: i32,
    pub width: i32,
    pub height: i32,
    pub speed: i32,
    pub keys: Vec<KeyboardKey>,
}

impl Bar {
    pub fn new(
        x: i32,
        y: i32,
        width: i32,
        height: i32,
        speed: i32,
        keys: Vec<KeyboardKey>,
    ) -> Self {
        Bar {
            x,
            y,
            width,
            height,
            speed,
            keys,
        }
    }

    pub fn draw(&self, d: &mut RaylibDrawHandle) {
        d.draw_rectangle(self.x, self.y, self.width, self.height, Color::WHITE);
    }

    pub fn update_pos(&mut self, d: &mut RaylibDrawHandle) {
        if d.is_key_down(self.keys[0]) {
            self.y -= self.speed;
        }

        if d.is_key_down(self.keys[1]) {
            self.y += self.speed;
        }

        if self.y <= 0 {
            self.y = 0
        }

        if self.y + self.height >= d.get_screen_height() {
            self.y = d.get_screen_height() - self.height;
        }
    }
}
