shader_type canvas_item;

// Define souce color and uniform will allow us to change this value from the editor
uniform vec3 s_color: source_color = vec3(1);
uniform float progress: hint_range(0.0, 1.0, 0.1) = 0.0;

void fragment() {
	// UV is the position of the pixel on the canvas item

	// Get current alpha value of the pixel
	vec4 current_color = texture(TEXTURE, UV);
	float current_a = current_color.a;
	vec4 hit_color = vec4(s_color, current_a);

	// Mix between current color and hit color based on progress
	vec4 target_color = mix(current_color, hit_color, progress);
	COLOR = target_color;
}
