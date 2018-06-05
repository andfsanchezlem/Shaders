/**
 * Cad Camera.
 * by Jean Pierre Charalambos.
 * 
 * This example illustrates how to add a CAD Camera type to your your scene.
 * 
 * Press 'h' to display the key shortcuts and mouse bindings in the console.
 * Press 'u' to switch between right handed and left handed world frame.
 * Press the space bar to switch between camera profiles: CAD and CAD_CAM.
 * Press x, y or z to set the main rotation axis (defined in the world
 * coordinate system) used by the CAD Camera.
 */

import remixlab.proscene.*;
import java.util.*;

Scene scene;
PShader the_shader;
PShader lightShader;
PImage img;
float angle;


void setup() {
  size(640, 360, P3D);
  //Scene instantiation
  scene = new Scene(this);
  //Set right handed world frame (useful for architects...)
  scene.setRightHanded();
  scene.eyeFrame().setMotionBinding(LEFT, "rotateCAD");
  scene.camera().frame().setRotationSensitivity(1.5);
  //no spinning:
  scene.camera().frame().setSpinningSensitivity(100);
  //no damping:
  scene.camera().frame().setDamping(1);

  
  lightShader = loadShader("lightfrag.glsl", "lightvertSPEC.glsl"); 
 

}

void draw() {
  background(0);
  shader(lightShader);
  rotateZ(angle); 
  //noLights();
  pointLight(255, 255, 255, -width/2, -height, 200);
  
  
  
  fill(230,100, 100);
  box(20, 30, 50);
  fill(204,52, 230);
  noStroke();
  translate(58, 48, 0);
  fill(204,204, 230);
  sphere(15);
  
  translate(-98, -108, 0);
  fill(204,104, 230);
  box(50, 30, 20);
  angle += 0.01;
  
}

void keyPressed() {
  if (key == ' ')
    if ( scene.eyeFrame().isActionBound("rotateCAD") )
      scene.eyeFrame().setMotionBinding(LEFT, "rotate");
    else {
      scene.eyeFrame().setMotionBinding(LEFT, "rotateCAD");
      scene.camera().setUpVector(0, 1, 0);
    }
  if (key == 'u' || key == 'U')
    scene.flip();
  if(key == 'd' || key == 'D')
    lightShader = loadShader("lightfrag.glsl", "lightvert.glsl"); //fragmentshader, vertexshader difusa
  if(key == 'e' || key == 'E')
    lightShader = loadShader("lightfrag.glsl", "lightvertSPEC.glsl"); //fragmentshader, vertexshader especular
  
  else {
    if (key == 'x' || key == 'X')
      scene.camera().setUpVector(1, 0, 0);
    else if (key == 'y' || key == 'Y')
      scene.camera().setUpVector(0, 1, 0);
    else if (key == 'z' || key == 'Z')
      scene.camera().setUpVector(0, 0, 1);
    scene.camera().lookAt(scene.center());
  }
}