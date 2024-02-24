

int spriteSize = 16;
PGraphics worldMapImage;

int worldMapSize = 256;
int[][] worldMapArray = new int[worldMapSize][worldMapSize];
int[][] worldCollisionArray = new int[worldMapSize][worldMapSize];

void generateWorld(){
  noiseDetail(6,0.5);
  float noiseFreq = 0.01;
  
  
  //fill the worldMapArray with random numbers for now. numbers represent the sprite index
  for (int y = 0; y < worldMapArray.length; y++){
    for (int x = 0; x < worldMapArray[0].length; x++){
      float noiseVal = noise(x*noiseFreq, y*noiseFreq);
      int val = int(round(noiseVal*10)%6);
      worldMapArray[x][y] = val;
      worldCollisionArray[x][y] = val == 5 ? 1 : 0;
      
    }
  }
  worldMapImage = renderWorld();
}

PGraphics renderWorld(){
  PGraphics pg = createGraphics(spriteSize * worldMapArray.length + 2, spriteSize * worldMapArray[0].length + 2);
  
  PImage[] sprites = new PImage[6];
  for(int i = 0; i<sprites.length; i++){
    sprites[i] = loadImage(i + ".png");
  }
  
  pg.beginDraw();
  pg.background(0,0,255);
  pg.stroke(255,0,0);
  pg.noFill();
  for (int y = 0; y < worldMapArray[0].length; y++){
    for (int x = 0; x < worldMapArray[1].length; x++){
      int spriteIndex = worldMapArray[x][y];
      pg.image(sprites[spriteIndex],x*16,y*16);
      
      
      if(worldCollisionArray[x][y] == 1){
        pg.rect(x*16,y*16,spriteSize,spriteSize);
      }
    }
  }
  pg.endDraw();
  return pg;
}


void drawWorld(){
  push();
  
  translate(width*0.5, height*0.5);
  scale(camZoom);
  
  image(
        worldMapImage, 
        worldPos.x, 
        worldPos.y
        );
  pop();
}
