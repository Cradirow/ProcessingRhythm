class Note{
  float x,y;
  float r;
  float speed;
  int note;
  int noteLength;
  color noteColor;
  public boolean hit = false;
  
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
  }
  
  void display(){
    fill(noteColor);
    strokeWeight(1);
    rect(x,y,r*7.5,r*noteLength,7);
  }
  
  public float getY(){
    return y;
  }
  
  public int getLane(){
    return note;
  }
  
  public void hitBox(){
    noteColor = color(244,197,66);
    hit = true;
  }
  
  public void closeBox(){
    noteColor = color(0,0,0);
  }
  
  public void outBox(){
    noteColor = color(255,255,255);
    hit = false;
  }
  
}
