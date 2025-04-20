shader_type canvas_item;

uniform sampler2D NOISE_TEX : repeat_enable;
uniform vec2 waves_size = vec2(0.01, 0.003);
uniform float time_scale_x = 8.0;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;
uniform float amp_mult = 0.4;

void fragment() {
    vec2 screen_uv = SCREEN_UV;   // Get the UV coordinates of the screen
    vec2 pixel = vec2(1.0) / 64.0;  // Define the pixel size for displacement
    vec2 noise_uv = UV;  // Use UV for noise texture sampling

    // Apply animation to the noise texture (for moving water effect)
    noise_uv.x += round(TIME * time_scale_x) * pixel.x;
    vec2 noise_value = texture(NOISE_TEX, noise_uv).rg;  // Get the light/dark values from the noise texture
    noise_value = noise_value * amp_mult - 1.0; // Clamp to (-1, 1) for displacement

    // Apply the noise displacement to screen UV coordinates
    screen_uv += noise_value * waves_size;

    // Sample the main screen texture
    vec3 screen_color = textureLod(SCREEN_TEXTURE, screen_uv, 0.0).rgb;

    // Average the red and green channels of the noise to get a "lightness" factor
    float light_value = (noise_value.r + noise_value.g) * 0.5;  // Average the light/darkness levels

    // Adjust the brightness of the screen color based on the noise (light/dark)
    screen_color *= (light_value * 0.2 + 0.6);  // Scale the brightness to keep it in the range [0, 1]

    // Combine the effects (screen color + noise influence)
    COLOR.rgb = screen_color;
	COLOR.rb += 0.04;
	COLOR.rgb -= 0.03;
}