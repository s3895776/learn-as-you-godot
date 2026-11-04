shader_type canvas_item;

uniform float radius : hint_range(0.0, 1.5) = 0.5;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	
	vec2 centered_uv = UV - 0.5;
	
	centered_uv.x *= SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x;
	
	float dist = length(centered_uv);
	
	float mask = step(radius, dist);
		mask = 1.0 - mask;
	
	COLOR.a *= mask;

}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
