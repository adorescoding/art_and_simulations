class Particle {
  PVector[] pos;
  int index;
  final float stokeLength = 200;
  final float step = 0.5;
  int lifespan = (int) random((stokeLength/step)*0.25, (stokeLength/step)*1);
  float maxRad = 2;
  
  color c;

  Particle(float x, float y) {
    pos = new PVector[lifespan];
    pos[0] = new PVector(x, y);
    //float noiseVal = noiseFunct(x/colorNoiseRes, y/colorNoiseRes);
    //float noiseVal = worleyNoise(x, y);
    //c = color(((noiseVal*255*10)+200)%255.0, 255, 255);
    c = colorTexture.get((int) random(colorTexture.width), (int) random(colorTexture.height));
    index = 0;
  }

  void drawPath() {
    for (int i = 1; i < lifespan; i++)
    {
      PVector prev = pos[i-1];
     float noiseVal = noiseFunct(prev.x, prev.y);
     // float noiseVal = worleyNoise(prev.x, prev.y);
      PVector toAdd = PVector.fromAngle(noiseVal*TWO_PI*2).setMag(step);
      pos[i] = PVector.add(prev, toAdd);
    }
  }

  void display() {
    fill(c);
    for (int i = 1; i < lifespan; i++) {
      if (pos[i] != null) {
        float radii = sin(map(i, 0, lifespan, 0, PI))*maxRad;
        circle(pos[i].x, pos[i].y, radii*2);
      }
    }
  }

  boolean isDead() {
    return index == 0;
  }
}
