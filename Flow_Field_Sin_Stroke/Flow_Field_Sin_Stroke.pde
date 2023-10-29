import processing.pdf.*;

ArrayList<Particle> particles;
final float noiseRes = 800;
float colorNoiseRes = noiseRes;
final float cellRes = 15;

int screenOffset = 0;

float[][] worleyGrid;
final int closeNum = 0;

PImage colorTexture;
PImage noiseTexture;

void setup() {
  size(1100, 1500);
  background(255);
  noStroke();
  colorMode(HSB);
  
  colorTexture = loadImage("space.png");
  noiseTexture = loadImage("selfie1.jpg");
  noiseTexture.resize(width, height);

  //worleyCellRes = 500;
  //numWorleyPointsInit = (int) (width/worleyCellRes * height/worleyCellRes);
  
  //worleyGrid = new float[width][height];
  //points = initializeWrappedPoints();
  //makeWorleyGrid();
  
  particles = new ArrayList<Particle>();
  makeParticles(5000);
  noLoop();
}

void draw() {
  background(0);
  for (Particle p : particles)
  {
    p.display();
  }
}

float worleyNoise(float x, float y)
{
  if (x < 0 || x >= width || y < 0 || y >= height) return -1;
  return worleyGrid[(int) x][(int) y];
}

float noiseFunct(float x, float y)
{
  //return(noise(x/noiseRes, y/noiseRes));
  float textureVar = map(brightness(noiseTexture.get((int)x, (int)y)), 0, 255, 0, 1);
  return textureVar;
}

void makeParticles(int num)
{
  for (int i = -screenOffset; i < width + screenOffset; i+= cellRes)
  {
    for (int j = -screenOffset; j < height + screenOffset; j+= cellRes)
    {
      Particle p = new Particle(i, j);
      p.drawPath();
      particles.add(p);
    }
    
  }
  
  //for (int i = 0; i < num; i++)
  //{
  //  Particle p = new Particle(random(-screenOffset, width + screenOffset), random(-screenOffset, height + screenOffset));
  //  p.drawPath();
  //  particles.add(p);
  //}
  
}
