ArrayList<Particle> particles;

void setup() {
  fullScreen();
  noCursor();  // Hide the cursor (optional)
  smooth();    // Smooth edges for better visual effects
  particles = new ArrayList<Particle>();
  
  // Create the first galaxy (star-like central particle and orbiting particles)
  particles.add(new Particle(width / 2, height / 2, 1000)); // Star-like heavy particle at center
  for (int i = 0; i < 1200; i++) {
    float angle = random(TWO_PI); // Random angle for orbit
    float distance = random(90, 300); // Random distance from the central particle
    float x = width / 2 + cos(angle) * distance;
    float y = height / 2 + sin(angle) * distance;
    float mass = random(5, 50);
    Particle p = new Particle(x, y, mass);
    
    // Set each particle to have an initial tangential velocity to make them orbit
    p.velocity = new PVector(0, 0); // Reset velocity, will be updated below
    float orbitalSpeed = sqrt((Particle.G * 1000) / distance) * 0.8; // Adjusted orbital speed
    p.velocity.x = -sin(angle) * orbitalSpeed; // Tangential velocity (perpendicular to the radial direction)
    p.velocity.y = cos(angle) * orbitalSpeed;
    
    particles.add(p);
  }
  
  // Create the second galaxy (different location and central particle)
  Particle centralParticle2 = new Particle(width * 0.25, height * 0.25, 1000); // New galaxy's central particle
  particles.add(centralParticle2); // Add the central particle for the second galaxy
  
  for (int i = 0; i < 1200; i++) {
    float angle = random(TWO_PI); // Random angle for orbit
    float distance = random(90, 300); // Random distance from the central particle
    float x = width * 0.25 + cos(angle) * distance; // Offset for second galaxy's position
    float y = height * 0.25 + sin(angle) * distance;
    float mass = random(5, 50);
    Particle p = new Particle(x, y, mass);
    
    // Set each particle to have an initial tangential velocity to make them orbit
    p.velocity = new PVector(0, 0); // Reset velocity, will be updated below
    float orbitalSpeed = sqrt((Particle.G * 1000) / distance) * 0.8; // Adjusted orbital speed
    p.velocity.x = -sin(angle) * orbitalSpeed; // Tangential velocity (perpendicular to the radial direction)
    p.velocity.y = cos(angle) * orbitalSpeed;
    
    particles.add(p);
  }
}

void draw() {
  background(0, 50);  // Slight fade effect for trails
  
  // Update and draw all particles
  for (Particle p : particles) {
    p.update(particles); // Update position and velocity based on gravitational forces
    p._draw(); // Draw particle with color based on mass
  }
  
  // Loop the animation continuously
  // Since it's running in a continuous loop, you may want to add other behaviors like particle resets or boundaries.
}
