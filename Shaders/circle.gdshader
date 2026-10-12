
shader_type canvas_item;
render_mode unshaded;

uniform vec4 circle_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float radius = 0.48;
uniform float edge_softness = 0.005;

void fragment() {
	vec2 uv = UV - vec2(0.5);
	uv.x *= TEXTURE_PIXEL_SIZE.x / TEXTURE_PIXEL_SIZE.y;
	
	float dist = length(uv);
	float alpha = 1.0 - smoothstep(radius - edge_softness, radius + edge_softness, dist);
	
	COLOR = vec4(circle_color.rgb, circle_color.a * alpha);
}
