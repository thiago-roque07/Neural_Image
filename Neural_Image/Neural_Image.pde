final int NB_PARTICLES = 1000;
final float MAX_PARTICLE_SPEED = 0.5;

float noiseZ;
float noiseSpeedZ, stepNoiseXY;
final float TP = TWO_PI;
myVector tabParticles[];//array of particles
float c1, c2;

void setup()
{
  size(800, 500, P2D);
  background(255);
  colorMode(HSB, 255);
  initialize();
}

void initialize()
{
//  c1 = random(20, 110);
//  c2 = random(255 - c1);
  noiseZ = random(255);
  noiseSpeedZ = random(.005, .02) * (random(1) < .5 ? 1 : -1);
  stepNoiseXY = random(.001, .05);
  tabParticles = new myVector[NB_PARTICLES];
  for (int i = 0; i < NB_PARTICLES; i++) {
    tabParticles[i] = new myVector();
  }
  background(255);
}

void draw()
{
  fill(15, 8);
  noStroke(); 
  rect(0, 0, width, height);
  
  noiseZ += noiseSpeedZ;
  for (int i = 0; i < NB_PARTICLES; i++){
    tabParticles[i].update();
  }
}

void mousePressed() {
  initialize();
}

void keyPressed() {
  for (int i = 0; i < NB_PARTICLES; i++) {
    tabParticles[i] = new myVector();
  }
}

class myVector {
  float x, y;
  color myColor;

  myVector () {
    initPart();
  }

  void initPart_2(){
    x = random(width);
    y = random(height);

    float n = noise(x * stepNoiseXY, y * stepNoiseXY, noiseZ);
    myColor = color(34 + 220 * n, 255, 255);
  }

  void initPart(){
    x = random(width/4, 3*width/4);
    y = random(height/4, 3*height/4);

    
    float n = noise(x * stepNoiseXY, y * stepNoiseXY, noiseZ);
//    myColor = color(c2 + c1 * n, 255, 255);
    myColor = color(34 + 220 * n, 255, 255);
  }

  void update(){
    float n = (noise(x*stepNoiseXY, y*stepNoiseXY, noiseZ));
    n = map(n, .1, .9, 0, TP);

    x += n*cos(n * TP) * MAX_PARTICLE_SPEED;
    y += n*sin((1-n) * TP) * MAX_PARTICLE_SPEED;

    if ((x < 0) || (x > width) || 
      (y < 0) || (y > height)) {
      initPart_2();
    }
    stroke(myColor, 255);
    strokeWeight(2);
    point(x, y);
  }
}
