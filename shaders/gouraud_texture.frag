#version 300 es

precision mediump float;

in vec3 ambient;
in vec3 diffuse;
in vec3 specular;
in vec2 frag_texcoord;

uniform vec3 material_color;    // Ka and Kd
uniform vec3 material_specular; // Ks
uniform sampler2D image;        // use in conjunction with Ka and Kd

out vec4 FragColor;

void main() {
    vec3 amb = material_color * ambient;
    vec3 dif = material_color * diffuse;
    vec3 spec = material_specular * specular;

    vec4 light = vec4(amb + dif + spec, 1.0);

    //need to add lighting to the FragColor. addition did not work, multiplication seems to be fine.
    FragColor = texture(image, frag_texcoord) * light;
}
