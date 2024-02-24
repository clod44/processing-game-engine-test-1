

PVector _camPosOffset = new PVector(0,0);
PVector camPos0 = new PVector(0,0); //just to hold the previous value
PVector camPos = new PVector(0,0); //also includes the dragging. used in everywhere
float camZoom = 1;
PVector worldPos = new PVector(0,0);
Person[] people = new Person[200];


DebugBar db;
DebugBarGraph fpsGraph = new DebugBarGraph();
DebugBarGraph testGraph = new DebugBarGraph();

void setup(){
  size(800,800);
  surface.setTitle("Hello World!");
  surface.setResizable(true);
  noSmooth();
  background(0,255,0);
  generateWorld();
  
  //debug bar
  db = new DebugBar();
  db.setSize(150,height);
  fpsGraph.setSize(20,10);
  testGraph.setSize(20,10);
  testGraph.tickSpeed = 1;
  testGraph.maxVal = 100;
  
  
  
  //generate people
  for(int i = 0; i<people.length; i++){
    people[i] = new Person();
    people[i].spread(worldMapSize*16);
  }
}

void draw(){
  background(0);
  
  drawWorld();
  
  //update people
  push();
  translate(width*0.5, height*0.5);
  scale(camZoom);
  for(int i = 0; i<people.length; i++){
    people[i].update();
    people[i].show();
  }
  pop();
  
  
  updateCamAndWorldPos();
  
  
  isMousePressed = false;
  isMouseDragged = false;
  isMouseReleased = false;
  
  
  showDebugBar(true);
}
