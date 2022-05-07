#version 300 es

precision mediump float;

in vec3 frag_pos;
in vec3 frag_normal;

uniform vec3 light_ambient;
uniform vec3 light_position;
uniform vec3 light_color;
uniform vec3 camera_position;
uniform vec3 material_color;      // Ka and Kd
uniform vec3 material_specular;   // Ks
uniform float material_shininess; // n

out vec4 FragColor;

void main() {

    //calculate vectorrs used in lighting equations
    vec3 light_direction = normalize(light_position - frag_pos);
    vec3 view_direction = normalize(camera_position - frag_pos);
    vec3 reflected = 2.0 * dot(frag_normal, light_direction) * frag_normal;
    vec3 reflected_direction = normalize(reflected - light_direction);

    //lighting equations
    vec3 ambient = light_ambient;
    vec3 diffuse = clamp(light_color * dot(frag_normal, light_direction), 0.0, 1.0);
    vec3 specular = clamp(light_color * pow(dot(reflected_direction, view_direction), material_shininess), 0.0, 1.0);

    vec3 amb = material_color * ambient;
    vec3 dif = material_color * diffuse;
    vec3 spec = material_specular * specular;

    FragColor = vec4(amb + dif + spec, 1.0);
}
