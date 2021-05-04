class ParticleSystem  {

  ArrayList<Water_Particle> particles;    // An ArrayList for all the particles
  PVector origin;         // An origin point for where particles are birthed

  ParticleSystem(int num, PVector v) {
    particles = new ArrayList<Water_Particle>();             // Initialize the ArrayList
    origin = v.get();                        // Store the origin point

      for (int i = 0; i < num; i++) {
      particles.add(new Water_Particle(origin.x,origin.y));    // Add "num" amount of particles to the ArrayList
    }
  }

  void run() {
    // Display all the particles
    for (Water_Particle p: particles) {
      p.display();
    }

    // Particles that leave the screen, we delete them
    // (note they have to be deleted from both the box2d world and our list
    for (int i = particles.size()-1; i >= 0; i--) {
      Water_Particle p = particles.get(i);
      if (p.done()) {
        particles.remove(i);
      }
    }
  }

  void addParticles(int n) {
    for (int i = 0; i < n; i++) {
      particles.add(new Water_Particle(origin.x,origin.y));
    }
  }

  // A method to test if the particle system still has particles
  boolean dead() {
    if (particles.isEmpty()) {
      return true;
    } 
    else {
      return false;
    }
  }

}
