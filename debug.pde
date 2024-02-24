

class DebugBar{
  int x,y = 0;
  int w,h = 200;
  PGraphics pg = createGraphics(this.w,this.h);
  int row = 10;
  DebugBar(){
    this.setSize(100,100);
  }
  
  void setSize(int _w, int _h){
    this.w = _w;
    this.h = _h;
    this.pg = createGraphics(this.w,this.h);
  }
  
  void clearCanvas(){
    this.row=10;
    //this.pg.beginDraw();
    this.pg.clear();
    this.pg.background(255);
    //this.pg.endDraw();
  }
  
  void show(){
    image(this.pg, this.x, this.y);
  }

  void addLabel(String label, String value){
    //this.pg.beginDraw();
    this.pg.fill(0);
    this.pg.noStroke();
    this.pg.text(label+" "+value,5,this.row);
    //this.pg.endDraw();
    this.row+=10;
  }


}

class DebugBarGraph{
  int tickSpeed = 60;
  int tick = 0;
  int x,y = 0;
  int w = 10;
  int h = 5;
  int maxVal = 60;
  char[][] graph = new char[w][h];
  float val = 0;
  
  DebugBarGraph(){
    this.resetGraph();
  }

  void setSize(int _w, int _h){
    this.w = _w;
    this.h = _h;
    this.graph = new char[w][h];
    this.resetGraph();
  }
  void resetGraph(){
    for(int y = 0; y<this.h; y++){
      for(int x = 0; x<this.w; x++){
        this.graph[x][y] = '_';      
      }
    }
  }

  void update(float _val){
    this.tick++;
    if(this.tick >= this.tickSpeed){
      this.tick = 0;
      this.val = _val;
      
      //clear the first left most rows
      for(int y = 0; y<this.h; y++){
        this.graph[0][y] = '_';
      }
      
      //move the graph left
      for(int y = 0; y<this.h; y++){
        for(int x = 0; x<this.w-1; x++){
          this.graph[x][y] = this.graph[x+1][y];      
        }
      }
      
      //add new values (clear that row first)
      for(int y = 0; y<this.h; y++){
        this.graph[this.w-1][y] = '_';
      }
      int charCount = (int)min(this.h, max(0, map(val, 0, this.maxVal, 0, this.h)));
      for(int y = 0; y<charCount; y++){
        this.graph[this.w-1][y] = '#';
      }
    }
  }
  
  String[] getLines(){
    String[] lines = new String[this.h];
    
    for(int y = 0; y<this.h; y++){
      String line = "";
      for(int x = 0; x<this.w; x++){
        line += this.graph[x][y];
      }
      lines[this.h-1-y] = line;
    }
  return lines;
  }
  
  void addToDb(DebugBar _db){
    String[] _lines = this.getLines();
    for(int i = 0; i<this.h; i++){
      _db.addLabel(_lines[i],"");
    }
  }
}


void showDebugBar(boolean _show){
  if(_show){
    db.pg.beginDraw();
    db.clearCanvas();
    db.addLabel("Project Amongus","");
    db.addLabel("","");
    
    db.addLabel("Test Graph: ", "");
    testGraph.addToDb(db);
    testGraph.update(map(sin(frameCount/5.0),-1,1,0,100));
    db.addLabel(map(sin(frameCount/5.0),-1,1,0,100)+"","");
    db.addLabel("","");
    
    db.addLabel("FPS: ", ""+int(frameRate));
    fpsGraph.addToDb(db);
    fpsGraph.update(frameRate);
  
    
    db.addLabel("","");
    
    db.pg.endDraw();
    db.show();
    
  }
}
