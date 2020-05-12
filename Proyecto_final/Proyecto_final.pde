PImage img;
import oscP5.*;
import netP5.*;
OscP5 oscP5;
int puerto;
float xa; 
float ya;
float posx, posy;

void setup() {
  size(640, 360);
  frameRate(30); 
  img = loadImage("Arquitectura.jpg");
  img.loadPixels(); 
  loadPixels();
  
  puerto=12000;
  oscP5=new OscP5(this,puerto);
}

void draw() {
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++ ) { 
      int loc = x + y*img.width; 
      float r,g,b; 
      r = red (img.pixels[loc]);
      g = green (img.pixels[loc]);
      b = blue (img.pixels[loc]);
      
      float maxdist = 70; 
      float d = dist(x, y, posx, posy);
      float adjustbrightness = 255*(maxdist-d)/maxdist; 
      r += adjustbrightness;
      g += adjustbrightness;
      b += adjustbrightness;
      
      r = constrain(r, 0, 255); 
      color c = color(r,g, b); 
      pixels[y*width + x] = c;
    }
  }
  updatePixels();
}

void oscEvent(OscMessage theOscMessage)
{
  if (theOscMessage.checkAddrPattern("/xa")==true){
    
    if (theOscMessage.checkTypetag("f")){
      xa=theOscMessage.get(0).floatValue();
      println("pd--> posx: "+xa);
      posx=int (map(xa,0,1.0,0,width));
      return;
    }
      
    }
    
    if (theOscMessage.checkAddrPattern("/ya")==true){
    
    if (theOscMessage.checkTypetag("f")){
      ya=theOscMessage.get(0).floatValue();
      println("pd--> posy: "+ya);
      posy=int (map(ya,0,1.0,0,width));
      return;
    }
      
    }
}
