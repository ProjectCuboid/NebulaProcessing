class Particle {
  PVector position, velocity;
  float mass;
  
  // Gravitational constant (simplified for this simulation)
  static final float G = 0.1; // Reduced value to slow things down

  Particle(float x, float y, float m) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0); // Initial velocity set later
    mass = m;
  }

  void update(ArrayList<Particle> particles) {
    PVector totalForce = new PVector(0, 0);
    
    // Only apply gravitational force from the central star (first particle) on others
    for (Particle other : particles) {
      if (other != this && other.mass > 100) { // Apply gravitational force only from the central star
        PVector force = calculateGravitationalForce(other);
        totalForce.add(force);
      }
    }
    
    // Now apply the total force to update velocity using mass
    PVector acceleration = totalForce.copy().div(mass);  // a = F / m
    velocity.add(acceleration); // Update velocity with acceleration
    
    // Update position based on the velocity
    position.add(velocity);
  }

  PVector calculateGravitationalForce(Particle other) {
    // Calculate the vector from this particle to the other particle (the central star)
    PVector direction = PVector.sub(other.position, position);
    float distance = direction.mag();  // Get the distance between particles
    
    if (distance == 0) return new PVector(0, 0);  // Avoid division by zero
    
    // Apply gravitational force formula (simplified by a constant)
    float forceMagnitude = (G * mass * other.mass) / (distance * distance);
    
    // Normalize direction and scale by the force magnitude
    direction.normalize();
    direction.mult(forceMagnitude);
    
    return direction;
  }

  void _draw() {
    strokeWeight(mass / 10);
    
    // Map mass to a color gradient (1 = red, 50 = blue/white)
    float normMass = constrain(map(mass, 5, 50, 0, 1), 0, 1);
    int r = int(255 * (1 - normMass)); // More red for light mass
    int g = 0;
    int b = int(255 * normMass); // More blue for heavy mass

    stroke(r, g, b);
    point(position.x, position.y);
  }
}
