//library settings
import ddf.minim.*;

//extends class
ArrayList<Note> notes = new ArrayList<Note>();
ArrayList<Note> lane1 = new ArrayList<Note>();
ArrayList<Note> lane2 = new ArrayList<Note>();
ArrayList<Note> lane3 = new ArrayList<Note>();
ArrayList<Note> lane4 = new ArrayList<Note>();
GameController gameController = new GameController();

//lane counts
int[] laneCount = new int[] {-1,-1,-1,-1};

//resources
PImage musicImg;
AudioPlayer player;
Minim minim;

//game manage
boolean isStart = true; //change to false
boolean mouseOver = false;
boolean isMusicOn = false;

//game settings
int hp = 100;
int score = 0;
int combo = 0;
float speed = 0.1; // speed x0.8, x1.0, x1.2 support
int melody = 0;

int perfectScore = 20;
int goodScore = 10;

//hit effects
String hitText = "";
int time;
int wait = 2000;

void setup(){
  size(550,700);
  background(0);
  
  musicImg = loadImage("unity.jpg");
  minim = new Minim(this);
  player = minim.loadFile("unity.mp3", 2048);
  time = millis();
  smooth();
  strokeWeight(3);
  
  //newNote(0);
  //newNote(1);
  //newNote(2);
  //newNote(3);
}

void draw(){
    
  if(isStart){
    background(255);
    backgroundDraw();
    UIDraw();
    
    if(millis() - time >= wait){
      update();
      if(!isMusicOn){
        //player.play();
        isMusicOn = true;
      }
    }
      
  }else{
    update();
    textSize(30);
    fill(200);
    text("TheFatRat - Unity", 130,150);
    image(musicImg, 150, 200, 200, 200);
    fill(255);
    rect(150,450,200,50,10);
    fill(50);
    textSize(30);
    text("START", 200, 485);
    
    if(mouseOver){
      fill(0,100,150);
      rect(150,450,200,50,10);
      fill(50);
      textSize(30);
      text("START", 200, 485);
    }
  }
}

void update(){
  
  if(isStart){
    //note moving
    for(int i=0; i<notes.size(); i++){
      moveNote(i);
    }
  }else{
    if(mouseX >= 200 && mouseX <= 400 
    && mouseY >= 450 && mouseY <= 500){
      mouseOver = true;
    }else{
      mouseOver = false;
    }
  }
}

void backgroundDraw()
{
    //out box rect
    strokeWeight(1.5);
    line(20,0,420,0);
    line(20,0,20,690);
    line(420,0,420,690);
    line(20,690,420,690);
    
    //lane backgrounds
    //lane1
    fill(255);
    rect(20,0,105,690);
    //lane2
    fill(255);
    rect(125,0,95,690);
    //lane3
    fill(255);
    rect(220,0,95,690);
    //lane4
    fill(255);
    rect(315,0,105,690);
    
    //hit box
    strokeWeight(2);
    fill(255,255,0);
    rect(10,550,420,30);  
    
    //lane lines
    strokeWeight(0.5);
    line(125,0,125,690);
    line(220,0,220,690);
    line(315,0,315,690);
    
    //keyboard rect 'S'
    strokeWeight(1.5);
    fill(100);
    rect(30,600,95,80);
    fill(255);
    textSize(50);
    text("S",65,660);
    
    //keyboard rect 'D'
    fill(100);
    rect(125,600,95,80);
    fill(255);
    textSize(50);
    text("D",155,660);
    
    //keyboard rect 'J'
    fill(100);
    rect(220,600,95,80);
    fill(255);
    textSize(50);
    text("J",260,660);
    
    //keyboard rect 'K'
    fill(100);
    rect(315,600,95,80);
    fill(255);
    textSize(50);
    text("K",350,660);
}

void UIDraw(){
  //hit
  fill(0);
  text(hitText, 125, 250);
  
  //HP
  fill(100);
  rect(440,40,100,20);
  
  //score
  fill(0);
  textSize(20);
  text("SCORE",450, 100);
  textSize(30);
  text(score, 450, 140);
  
  //combo
  fill(0);
  textSize(20);
  text("COMBO",450, 200);
  textSize(30);
  text(combo, 450, 240);
  
  //
  
}

void mousePressed(){
  if(mouseOver) btnStart();
}

void keyPressed(){
  ArrayList<Note> lane;
  int index = 0;
  
  if(key == 's'){
    lane = lane1;
    index = 0;
    //lane1
    fill(150);
    rect(20,0,105,690);
  }
  else if(key =='d'){
    lane = lane2;
    index = 1;
    //lane2
    fill(150);
    rect(125,0,95,690);
  }
  else if(key == 'j'){
    lane = lane3;
    index = 2;
    //lane3
    fill(150);
    rect(220,0,95,690);
  }
  else if(key == 'k'){
    lane = lane4;
    index = 3;
    //lane4
    fill(150);
    rect(315,0,105,690);
  }else{
    lane = null;
  }
  
  if(lane != null){
    chkHit(lane, index);
  }
  
}

void chkHit(ArrayList<Note> lane, int index){
  
  try{
    switch(lane.get(laneCount[index]).hitLocation){
    case -1:
      hitText = "BAD";
      combo = 0;
      hp -= 5;
      break;
    case 0:
      hitText = "";
      combo = 0;
      hp -= 5;
      break;
    case 1:
      hitText = "GOOD";
      score += goodScore;
      combo++;
      lane.get(laneCount[index]).hit = true;
      laneCount[index]++;
      break;
    case 2:
      hitText = "PERFECT";
      score += perfectScore;
      combo++;
      lane.get(laneCount[index]).hit = true;
      laneCount[index]++;
      break;
    }
  }catch(IndexOutOfBoundsException e){
    //System.out.println(".");
  }
}

public void noteOut(){
  hitText = "BAD";
  hp -= 5;
  combo = 0;
}

public void newNote(int _lane){
  ArrayList<Note> lane;
  switch(_lane){
    case 0: lane = lane1; break;
    case 1: lane = lane2; break;
    case 2: lane = lane3; break;
    case 3: lane = lane4; break;
    default: lane = null; break;
  }
  if(lane != null){
    laneCount[_lane]++;
    Note newNote = new Note(_lane,2,speed);
    lane.add(newNote);
    notes.add(newNote);
  }
}

void moveNote(int index){
  notes.get(index).update();
  notes.get(index).display();
}

void btnStart(){
  isStart = true;
}
