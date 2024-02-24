
PVector mPressedPos = new PVector(0,0);
PVector mPos = new PVector(0,0);
PVector mReleasedPos = new PVector(0,0);

boolean isMousePressed = false;
boolean isMouseDragged = false;
boolean isMouseReleased = false;
  
void mousePressed(){
  mPressedPos = new PVector(mouseX, mouseY);
  mPos = new PVector(mouseX, mouseY);
  isMousePressed = true;
  isMouseDragged = false;
  isMouseReleased = false;
}

void mouseDragged(){
  mPos = new PVector(mouseX, mouseY);
  isMousePressed = false;
  isMouseDragged = true;
  isMouseReleased = false;
  
  //part of updateCamAndWorldPos()
  _camPosOffset = new PVector(mPos.x - mPressedPos.x , mPos.y - mPressedPos.y);
  camPos = new PVector(camPos0.x - _camPosOffset.x/camZoom, camPos0.y - _camPosOffset.y/camZoom);
}

void mouseReleased(){
  mReleasedPos = new PVector(mouseX, mouseY);
  mPos = new PVector(mouseX, mouseY);
  isMousePressed = false;
  isMouseDragged = false;
  isMouseReleased = true;
  
  //part of updateCamAndWorldPos()
  camPos0 = new PVector(camPos.x, camPos.y);
}

void updateCamAndWorldPos(){  //<>//
  worldPos = new PVector(-camPos.x, -camPos.y);
}

void mouseWheel(MouseEvent event){
  float e = event.getCount();
  camZoom = min(10,max(0.1,camZoom + e*0.1));
}
