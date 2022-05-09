#version 300 es

precision highp float;

in vec3 vertex_position;
in vec3 vertex_normal;
in vec2 vertex_texcoord;

uniform vec3 light_ambient;
uniform vec3 light_position;
uniform vec3 light_color;
uniform vec3 camera_position;
uniform float material_shininess;
uniform vec2 texture_scale;
uniform mat4 model_matrix;
uniform mat4 view_matrix;
uniform mat4 projection_matrix;

out vec3 ambient;
out vec3 diffuse;
out vec3 specular;
out vec2 frag_texcoord;

void main() {

    //transformations of the vector position and surface normal from model space into world space.
    vec3 world_v_position = vec3(model_matrix*vec4(vertex_position, 1.0)); //transformed vertex position in world space.
    vec3 world_v_normal = normalize(inverse(transpose(mat3(model_matrix)))*vertex_normal);  //transformed normalized surface normal (N)

    //calculate vectors used in lighing equations
    vec3 light_direction = normalize(light_position - world_v_position);  // normalized light direction (L)
    vec3 view_direction = normalize(camera_position - world_v_position); // normalized view direction (V)
    vec3 reflected = 2.0*dot(world_v_normal, light_direction)*world_v_normal; // 2*(dot(N,L)*N to be subtracted from light direction
    vec3 reflected_direction = normalize(reflected - light_direction);  //normalized reflected light direction (R)

    //lighting equations
    ambient = light_ambient; // I=Ia*Ka
    diffuse = light_color * dot(world_v_normal, light_direction);  // I=Ip*Kd(N dot L)
    specular = light_color * pow(dot(reflected_direction, view_direction), material_shininess);  // I=Ip*Ks(R dot V)^n

    //constrain each value so that it is between 0.0 and 1.0
    diffuse = clamp(diffuse, 0.0, 1.0);
    specular = clamp(specular, 0.0, 1.0);
    
    gl_Position = projection_matrix * view_matrix * model_matrix * vec4(vertex_position, 1.0);
    frag_texcoord = vertex_texcoord * texture_scale;
}
