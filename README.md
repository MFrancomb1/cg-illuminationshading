# 3D Illumination and Shading
This project uses the WebGL2 API to demonstrate techniques for illumination and shading in computer graphics. WebGL allows us to work directly in GLSL, the OPENGL Shading Language, to write vertex and fragment shaders to render our lights efficiently and quickly. We have implemented several types of shading that have been used in computer graphics; Gouraud Shading, a less intensive shading that intepolates colors in polygons, and Phong Shading, which interpolates normal vectors to produce a smoother lighting effect at a higher processing cost. This project also utilizes shaders to texture objects with images.

---

### Installation:
None! This app is running right now in GitHub Pages. You can visit the app <a href="https://mfrancomb1.github.io/cg-illuminationshading/">here.</a>

Use the "wsad" keys to move the camera forward, backward, left, and right. Use the left and right arrow keys to rotate the camera. Light position and color, as well as the type of shading can be changed using the interface below the canvas. YOu can even import your own scene in json format.
