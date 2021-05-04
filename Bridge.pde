class Bridge {

  // Bridge properties
  // length of the bridge is calculated using the distance between the first and last points of the bridge
  float totalLength;  // How long
  // number of the circles of which the bridge consists
  // it's the number of the points of which the drawn line consists
  int numPoints;

  // Our chain is a list of particles
  ArrayList<Bridge_Particle> particles;

  // Chain constructor
  Bridge(ArrayList<PVector> line) {

    totalLength = pow(pow(line.get(0).x-line.get(line.size()-1).x,2) + pow(line.get(0).y-line.get(line.size()-1).y,2),0.5);
    numPoints = line.size();

    particles = new ArrayList();

    // length of the bridge
    float len = totalLength / numPoints;

    // Here is the real work, go through and add particles to the chain itself
    for(int i=0; i < numPoints; i++) {
      // Make a new particle
      Bridge_Particle p = null;
      
      // First and last particles are made with density of zero
      if(i == 0 || i == numPoints-1)
        p = new Bridge_Particle(line.get(i).x,line.get(i).y,4,true);
      else p = new Bridge_Particle(line.get(i).x,line.get(i).y,4,false);
      particles.add(p);

      // Connect the particles with a distance joint
      if (i > 0) {
         DistanceJointDef djd = new DistanceJointDef();
         Bridge_Particle previous = particles.get(i-1);
         // Connection between previous particle and this one
         djd.bodyA = previous.body;
         djd.bodyB = p.body;
         // Equilibrium length
         djd.length = box2d.scalarPixelsToWorld(len);
         // These properties affect how springy the joint is 
         djd.frequencyHz = 0;
         djd.dampingRatio = 0;
         
         // Make the joint.  Note we aren't storing a reference to the joint ourselves anywhere!
         // We might need to someday, but for now it's ok
         DistanceJoint dj = (DistanceJoint) box2d.world.createJoint(djd);
      }
    }
  }

  // Draw the bridge
  void display() {
    for (Bridge_Particle p: particles) {
      p.display();
    }
  }

}
