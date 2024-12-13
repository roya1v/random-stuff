use macroquad::prelude::*;

const PIPE_WIDTH: f32 = 100.0;
const DEBUG: bool = true;
const G: f32 = 9.8 * 100.; // in px/sec^2
const BIRD_SIZE: f32 = 100.0;


#[macroquad::main("Flappy2")]
async fn main() {
    let pipes = vec![50.;35 ];
    let mut game_started = false;

    let bird_texture: Texture2D = load_texture("assets/bird.png").await.unwrap();

    let mut center_x = 0.0;
    let mut bird_y = 0.0;
    let mut bird_speed_y = 0.0;

    loop {
        let screen_h = screen_height();
        let screen_w = screen_width();
        let delta_t = get_frame_time();
        // Draw sky
        clear_background(BLUE);
        
        // Draw bird
        draw_texture_ex(
            &bird_texture,
            screen_w / 2.0,
            bird_y,
            WHITE,
            DrawTextureParams {
                dest_size: Some(vec2(BIRD_SIZE, BIRD_SIZE)),
                ..Default::default()
            },
        );

        if !game_started {
            let text = "To start game press space";
            draw_text(text, screen_w / 2., screen_h / 2., 30.0, DARKGRAY);
            if is_key_down(KeyCode::Space) {
                game_started = true;
            }
            next_frame().await;
            continue;
        }

        // Draw pipes
        for (index, pipe_height) in pipes.iter().enumerate() {
            draw_rectangle(2. * PIPE_WIDTH * index as f32  - center_x, screen_height() - pipe_height, PIPE_WIDTH, *pipe_height, GREEN);
        }

        // Handle buttons 
        if is_key_down(KeyCode::Space) && bird_speed_y >= 0.0 {
            bird_speed_y = -600.0;
        }

        // Handle time change
        if bird_y < screen_height() - 120.0 {
            bird_y += bird_speed_y * delta_t ;
            bird_speed_y += delta_t * G;
        }
        if bird_speed_y < 0. {
            bird_y += bird_speed_y * delta_t;
            bird_speed_y += delta_t * G;
        }
        center_x += 1.0;

        // Show debug values
        if DEBUG {
            draw_text(&format!("X: {center_x}"), 20.0, 20.0, 30.0, DARKGRAY);
        }
        next_frame().await
    }
}
