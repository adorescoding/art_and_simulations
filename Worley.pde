PVector[] points;

int worleyCellRes;
int numWorleyPointsInit;
final boolean worleyRandomSwitch = true;

void makeWorleyGrid()
{
  loadPixels();
  for (int x = 0; x < width; x++)
  {
    for (int y = 0; y < height; y++)
    {
      
      //points[numPoints_widPoints-1] = new PVector(mouseX, mouseY);
      float [] distances = getDistances(x, y, points);
      float b = map(distances[closeNum], 0, 1+map(500, 0, width, 0, width*sqrt(2)), 1, 0);
      worleyGrid[x][y] = b;
    }
  }
}


float[] fixArray(PVector[] points)
{
  float[] fixedPoints = new float[points.length];
  for (int x = 0; x < width; x++)
  {
    for (int y = 0; y < height; y++)
    {
      int index = x + y*width;
      
      //points[numPoints_widPoints-1] = new PVector(mouseX, mouseY);
      float [] distances = getDistances(x, y, points);
      float b = map(distances[closeNum], 0, 1+map(500, 0, width, 0, width*sqrt(2)), 255, 0);
      fixedPoints[index] = b;
    }
  }
  return fixedPoints;
}

PVector[] initializePoints()
{
  PVector[] tempPoints = new PVector[numWorleyPointsInit];
  int count = 0;
  for (int i = 0; i < width; i+= worleyCellRes)
  {
    for (int j = 0; j < height; j += worleyCellRes)
    {
      if (worleyRandomSwitch) tempPoints[count] = new PVector(i + random(worleyCellRes), j + random(worleyCellRes));
      else tempPoints[count] = new PVector(i + worleyCellRes/2, j + worleyCellRes/2);
      count++;
    }
  }
  return tempPoints;
}

PVector[] initializeWrappedPoints()
{
  PVector[] tempPoints = new PVector[numWorleyPointsInit];
  int count = 0;
  for (int i = 0; i < width; i+= worleyCellRes)
  {
    for (int j = 0; j < height; j += worleyCellRes)
    {
      if (worleyRandomSwitch) tempPoints[count] = new PVector(i + random(worleyCellRes), j + random(worleyCellRes));
      else tempPoints[count] = new PVector(i + worleyCellRes/2, j + worleyCellRes/2);
      count++;
    }
  }
  
  PVector[] wrappedPoints = new PVector[tempPoints.length*9];
  count = 0;
  
  for (int i = -1; i <= 1; i++)
  {
    for (int j = -1; j <= 1; j++)
    {
      for (int p = 0; p < tempPoints.length; p++)
      {
        wrappedPoints[count] = tempPoints[p].copy().add(new PVector(width*i, height*j));
        count++;
      }
    }
  }
  
  return wrappedPoints;
}

float[] getDistances(int x, int y, PVector[] tempPoints)
{
  float[] distances = new float[tempPoints.length];
  for (int i = 0; i < tempPoints.length; i++)
  {
    distances[i] = dist(x, y, tempPoints[i].x, tempPoints[i].y);
  }
  return sort(distances);
}
