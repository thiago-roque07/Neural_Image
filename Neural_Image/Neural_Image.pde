final int NB_PARTICLES = 10000;
final float MAX_PARTICLE_SPEED = 0.4;

float noiseZ;
float noiseSpeedZ, stepNoiseXY;
final float TP = TWO_PI;
myVector tabParticles[];//array of particles
float c1, c2;
PImage img;

void setup()
{
  size(750, 500, P2D);
  img = loadImage("landscape.jpeg");
  imageMode(CENTER);
  background(255);
  colorMode(HSB, 255);
  initialize();
}

void initialize()
{
//  c1 = random(20, 110);
//  c2 = random(255 - c1);
  noiseZ = random(255);
  noiseSpeedZ = random(.002, .02) * (random(1) < .5 ? 1 : -1);
  stepNoiseXY = random(.002, .08);
  tabParticles = new myVector[NB_PARTICLES];
  for (int i = 0; i < NB_PARTICLES; i++) {
    tabParticles[i] = new myVector();
  }
}

void draw()
{

  fill(15, 20);
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

    //float n = noise(x * stepNoiseXY, y * stepNoiseXY, noiseZ);
    //myColor = color(34 + 220 * n, 255, 255);
  }

  void initPart(){
    x = random(width/5, 4*width/5);
    y = random(height/5, 4*height/5);

    
//    float n = noise(x * stepNoiseXY, y * stepNoiseXY, noiseZ);
////    myColor = color(c2 + c1 * n, 255, 255);
//    myColor = color(34 + 220 * n, 255, 255);
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
    color pix = img.get(int(x), int(y));
    stroke(pix, 255);
    strokeWeight(2);
    point(x, y);
  }
}
