

class Person{
  int x, y = 0;
  float xVel, yVel = 0;
  color col = color(255,0,0);
  
  Person(){
    this.col = color(random(255),random(255),random(255));
  }
  
  void spread(int area){
    this.x = round(random(area));
    this.y = round(random(area));
    this.xVel = random(2)-1;
    this.yVel = random(2)-1;
  }
  
  void update(){
    //movement
    this.x += this.xVel;
    this.y += this.yVel;
    
    //collision check
    PVector pos = this.getLocationOnMap();
    int collisionInfo = worldCollisionArray[int(pos.x)][int(pos.y)];
    if (collisionInfo == 1){
      this.col = color(random(255),random(255),random(255));
    }
  }
  
  PVector getLocationOnMap(){
    int _x = floor(this.x/16);
    int _y = floor(this.y/16);
    fill(0);
    
    rect( _x * 16 + worldPos.x,
          _y * 16 + worldPos.y, 
          16,16);
    return new PVector(_x, _y);
  }

  void show(){
    noStroke();
    fill(this.col);
    ellipse(this.x+worldPos.x,
            this.y+worldPos.y,
            20,20);
  }
}
