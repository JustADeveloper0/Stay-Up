shader_type canvas_item;
render_mode unshaded;

uniform sampler2D noise_texture : hint_default_white, repeat_enable;

uniform float scroll_x = 0.;
uniform float scroll_y = 0.15;
uniform float noise_scale = 1.0;

uniform vec4 color_1 : source_color = vec4(1.0, 0.133, 0.0, 1.0); // dark red
uniform vec4 color_2 : source_color = vec4(1.0, 0.467, 0.0, 1.0); // orange
uniform vec4 color_3 : source_color = vec4(1.0 ,0.933, 0.0, 1.0); // yellow

uniform float oscillation_speed = 1.0;
uniform float oscillation_strength = 0.25;

void fragment() {
	vec2 noise_uv = UV * noise_scale + vec2(scroll_x, scroll_y) * TIME;
	
	float noise_value = texture(noise_texture, noise_uv).r;
	
	float oscillation = sin(TIME) * 0.125;
	float noise = clamp(noise_value + oscillation, 0.0, 1.0);
	
	vec4 lava_color;
	
	if (noise < 0.4) {
		lava_color = mix(color_1, color_2, noise / 0.4);
	} else {
		lava_color = mix(color_2, color_3, (noise - 0.4) / 0.6);
	}
	
	lava_color.rgb += lava_color.rgb * pow(noise_value, 2.5) * 1.2;
	
	float wave = sin(UV.x * 5.0 + TIME * 0.7) * 0.018;
	
	wave += sin(UV.x * 9.0 - TIME * 0.45) * 0.008;
	
	float surface_y = 0.1 + wave;
	
	float edge = smoothstep(surface_y - 0.003, surface_y + 0.003, UV.y);
	
	COLOR = vec4(lava_color.rgb, lava_color.a * edge);
}
