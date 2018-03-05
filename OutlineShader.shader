shader_type canvas_item;

uniform float outline_width=1.0;
uniform vec4 outline_color=vec4(0.4,0.56,0.35,1);
uniform bool active = false;

varying vec2 vert;

void vertex() {
	//VERTEX *= 2.0;
	vert = VERTEX;
}

void fragment() {
	
	/*float alpha = 4.0*texture(TEXTURE, UV).a;
	alpha -= texture(TEXTURE, UV + vec2(stepSizeX, 0.0)).a;
	alpha -= texture(TEXTURE, UV + vec2(-stepSizeX, 0.0)).a;
	alpha -= texture(TEXTURE, UV + vec2(0.0, stepSizeY)).a;
	alpha -= texture(TEXTURE, UV + vec2(0.0, -stepSizeY)).a;
	
	COLOR = vec4(0.8, 0.0, 0.4, alpha);*/
	
	
	//COLOR = texture(TEXTURE, SCREEN_UV);
	//COLOR.a = texture(TEXTURE, SCREEN_UV).a * texture(sText, UV).a;
	//COLOR.a = alpha;
	if (active) {
		vec4 col = texture(TEXTURE,UV);
		vec2 ps = TEXTURE_PIXEL_SIZE;
		float a;
		float maxa=col.a;
		float mina=col.a;
		a=texture(TEXTURE,UV+vec2(0,-outline_width)*ps).a;
		maxa=max(a,maxa); 
		mina=min(a,mina);
		a=texture(TEXTURE,UV+vec2(0,outline_width)*ps).a;
		maxa=max(a,maxa); 
		mina=min(a,mina);
		a=texture(TEXTURE,UV+vec2(-outline_width,0)*ps).a;
		maxa=max(a,maxa); 
		mina=min(a,mina);
		a=texture(TEXTURE,UV+vec2(outline_width,0)*ps).a;
		maxa=max(a,maxa); 
		mina=min(a,mina);
		
		  
		COLOR=mix(col,outline_color,maxa-mina);
	} else {
		COLOR = texture(TEXTURE, UV + vec2(0, sin(vert.x+TIME*10.0)/80.0));
		COLOR = texture(TEXTURE, UV);
	}
}