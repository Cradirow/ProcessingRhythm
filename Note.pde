class Note{
  float x,y;
  float r;
  float speed;
  int note;
  int noteLength;
  color noteColor;
  
  Note(int _note, int _noteLength, float _speed){
    x = 40 + _note*95;
    y = -10;
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
  
}
