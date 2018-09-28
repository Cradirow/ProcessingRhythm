class Note{
  float x,y;
  float r;
  float speed;
  int note;
  int noteLength;
  color noteColor;
  public boolean hit = false;
  int hitLocation = 0;
  
  Note(int _note, int _noteLength, float _speed){
    x = 40 + _note*95;
    //y = -10;
    y=500;
    r = 10;
    speed = _speed;
    note = _note;
    noteLength = _noteLength;
    noteColor = color(random(255),random(255),random(255));
  }
  
  void update(){
    y = y + speed;
    chkNote();
  }
  
  void display(){
    if(!hit){
      fill(noteColor);
      strokeWeight(1);
      rect(x,y,r*7.5,r*noteLength,7);
    }
  }
  
  public float getY(){
    return y;
  }
  
  public int getLane(){
    return note;
  }
  
  public void normalBox(){
    hitLocation = 0;
  }
  
  public void hitBox(){
    noteColor = color(244,197,66);
    hitLocation = 2;
  }
  
  public void closeBox(){
    noteColor = color(0,0,0);
    hitLocation = 1;
  }
  
  public void outBox(){
    noteColor = color(255,255,255);
    hitLocation = -1;
  }
  
  //score in here.
  void chkNote(){
    //perfect
    if(y >= 550 && y <= 560){
      hitBox();
    }
    //good
    else if(y >= 530 && y <= 580){
      closeBox();
    }
    //bad
    else if(y > 580 || y < 530 && y > 510){
      outBox();
    }
    //normal
    else{
      normalBox();
    }
    //out boundary note
    if(y > 590){
      //delete note
      hit = true;
    }
  }
}
