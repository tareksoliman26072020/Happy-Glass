class Diagonal_Boundry extends Boundry {

  // But we also have to make a body for box2d to know about it
  Body b;

 Diagonal_Boundry(float x_,float y_, float w_, float h_, float a, int f1_, int f2_, int f3_) {
   super(x_,y_,w_,h_,f1_,f2_,f3_);

    // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    // We're just a box
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.angle = a;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    
    // Attached the shape to the body using a Fixture
    b.createFixture(sd,1);
  }

  // Draw the boundary
  void display() {
    fill(f1,f2,f3);
    stroke(0);
    strokeWeight(2);
    rectMode(CENTER);

    // degree of the rectangle
    float a = b.getAngle();

    pushMatrix();
    translate(x,y);
    rotate(-a);
    rect(0,0,w,h);
    stroke(0);
    strokeWeight(2);
    popMatrix();
  }

}
