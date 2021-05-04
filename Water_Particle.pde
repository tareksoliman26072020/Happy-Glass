class Water_Particle extends Particle{

  // We need to keep track of a Body
  Body body;

  // water trail
  PVector[] trail;

  // Constructor
  Water_Particle(float x_, float y_) {
    float x = x_;
    float y = y_;
    trail = new PVector[6];
    for (int i = 0; i < trail.length; i++) {
      trail[i] = new PVector(x,y);
    }

    // Add the box to the box2d world
    // Here's a little trick, let's make a tiny tiny radius
    // This way we have collisions, but they don't overwhelm the system
    makeBody(new Vec2(x,y),1.5f);
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  // Is the particle ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height+20) {
      killBody();
      return true;
    }
    // the particle lands in the glass when the coordinates of the water particle matches the measures of the glass
    else if((pos.x >= width/2+120 && pos.x<= width/2+486) && (pos.y>=height/2+100 && pos.y<=height/2+380))
      won++;
    else if(pos.y >= height-87)
      lost++;
    return false;
  }

  // Drawing the box
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);

    // Keep track of a history of screen positions in an array
    for (int i = 0; i < trail.length-1; i++) {
      trail[i] = trail[i+1];
    }
    trail[trail.length-1] = new PVector(pos.x,pos.y);

    // Draw particle as a trail
    beginShape();
    noFill();
    strokeWeight(10);
    stroke(135,206,250);
    for (int i = 0; i < trail.length; i++) {
      vertex(trail[i].x,trail[i].y);
    }
    endShape();
  }

  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center, float r) {
    // Define and create the body
    BodyDef bd = new BodyDef();
        bd.type = BodyType.DYNAMIC;

    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);

    // Give it some initial random velocity
    body.setLinearVelocity(new Vec2(random(-1,1),random(-1,1)));

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
  
    fd.density = 1;
    fd.friction = 0;  // Slippery when wet!
    fd.restitution = 0.2;

    // We could use this if we want to turn collisions off
    //cd.filter.groupIndex = -10;

    // Attach fixture to body
    body.createFixture(fd);
  }
}
