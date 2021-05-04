import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

// A reference to our box2d world
Box2DProcessing box2d;

// A list we'll use to track fixed objects
ArrayList<Boundry> boundries;

// A list for all water-particle systems
ArrayList<ParticleSystem> water_systems;

// on is true, when water starts falling
boolean on;
// the time at which the water was turned on
float time_on;
// when should the water be turned off after it's turned on
float time_until_off;

// the line which the bridge will be drawn upon
ArrayList<PVector> line;
// whether the line is already drawn
boolean line_is_drawn;

// the bridge which the water will use to be re-directed
Bridge bridge;
// whether the bridge is already drawn
boolean bridge_drawn;

// counter for water particles which are not caught in the glass
int lost;
// counter for water particles which are caught in the glass
int won;
// counter for particles which are leaving the tap
int particles_num;

// whether the game is won or lost
boolean loss=false,win=false;
// win window
Win win2 = new Win();
// loss window
Loss loss2 = new Loss();

PImage background;

PImage happy;
PImage sad;
PImage wow;

PImage pen;

void setup() {
  size(1600,1000);
  background = loadImage("Background.jpg");
  happy = loadImage("Happy.png");
  sad = loadImage("Sad.png");
  wow = loadImage("Wow.png");
  pen = loadImage("Pen.png");
  noCursor();
  if(!loss && !win){
    smooth();
  
    // Initialize box2d physics and create the world
    box2d = new Box2DProcessing(this);
    box2d.createWorld();
  
    // We are setting a custom gravity
    box2d.setGravity(0, -20);
  
    water_systems = new ArrayList<ParticleSystem>();
    boundries = new ArrayList<Boundry>();
    line = new ArrayList<PVector>();
    
    time_until_off = 3000f;
    
    on = false;
    line_is_drawn = false;
    bridge_drawn = false;
    
    lost = 0;
    particles_num = 0;
    
    // Add two boundaries
    boundries.add(new Horizontal_Boundry(300,height/2-20,300,20,143,188,143));
    boundries.add(new Diagonal_Boundry(750,height/2-20+70,300,20,-0.3,143,188,143));
    
    // Add the glass
    boundries.add(new Horizontal_Boundry(1114,height-105,400,20,0,0,0));
    boundries.add(new Diagonal_Boundry(904,height-245,300,20,PI/2,0,0,0));
    boundries.add(new Diagonal_Boundry(1304,height-245,300,20,PI/2,0,0,0));
  }
}

void draw() {
  background(background);
  //println(String.format("particles_num:%d\twon:%d\tlost:%d",particles_num,won,lost));
  image(pen,mouseX-17,mouseY-92);
  if(!win && !loss){
    //circle(width/2+486,height-87,15);
    // We must always step through time!
    box2d.step();
  
    // Run all the particle systems
    for (ParticleSystem system: water_systems) {
      system.run();
  
      // as long the water 
      if(abs(millis()-time_on)<=time_until_off){
        int n = (int) random(0,2);
        system.addParticles(n);
        particles_num += n;
      }
    }
  
    stroke(0);
    strokeWeight(2);
    // Display all the boundaries
    for (Boundry wall: boundries) {
      wall.display();
    }
    
    PImage img = loadImage("fountain.png");
    image(img,450,0);
    
    // draw the line upon which the bridge will be built
    if(!line_is_drawn){
      beginShape();
      noFill();
      for(PVector p: line)
        vertex(p.x,p.y);
      endShape();
      if(mousePressed)
        line.add(new PVector(mouseX,mouseY));
    }
    // when the mouse is released then the line is drawn => line_is_drawn is true
    // and the bridge will be created according to the drawn line
    else if(line_is_drawn && !bridge_drawn){
           bridge = new Bridge(line);
           bridge_drawn = true;
         }
         // Draw the windmill
         else if(bridge_drawn){
           // Make the bridge
           bridge.display();
         }
    // faces on the glass will be drawn according to the coordinates of the water particles.
    // happy face will be drawn when the winning criteria is reached, and half the time of the game has passed
    if(abs(millis()-time_on) >= 10000f && won>0 && lost <= particles_num * 6)
      image(happy,width/2+220,width/2-100);
    // wow face will be drawn when at least one drop of water is in the glass
    else if(won>0)
      image(wow,width/2+240,width/2-100);
    // sad face will be drawn as long as the glass is empty
    else
      image(sad,width/2+220,width/2-100);
    // win/loss will be decided 20 seconds after the water started falling
    // the game is won when the number of lost water particles is bigger than the sixfold of the number of the complete water particles
    if(abs(millis()-time_on) >= 15000f){
      if(lost > particles_num * 6)
        loss = true;
      else if(lost <= particles_num * 6 && line_is_drawn && bridge_drawn)
        win = true;
    }
  }
  else if(loss) loss2.draw();
  else if(win) win2.draw();
}

// when the mouse is released, the bridge is drawn, and the water must start falling.
// the water comes out of six points spreading along the water tap
void mouseReleased(){
  if(!on){
    time_on = millis();
    on = true;
    float x = 460;
    float y = 96;
    // Add a new Particle System whenever the mouse is clicked
    water_systems.add(new ParticleSystem(0, new PVector(x+4,y)));
    water_systems.add(new ParticleSystem(0, new PVector(x+14,y)));
    water_systems.add(new ParticleSystem(0, new PVector(x+24,y)));
    water_systems.add(new ParticleSystem(0, new PVector(x+34,y)));
    water_systems.add(new ParticleSystem(0, new PVector(x+44,y)));
    water_systems.add(new ParticleSystem(0, new PVector(x+54,y)));
    line_is_drawn = true;
  }
}
