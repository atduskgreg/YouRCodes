void enterMatch(){
      currentState = "matchMode";

}

void doMatch(){
  if(targetFace.match(candidateFace)){
    background(0,255,0);
  } else {
    background(255,0,0);
  }
  
  if(targetFace.img != null){
   image(targetFace.img, width/2, 0, 408, 544);
  }
}

void exitMatch(){

}
