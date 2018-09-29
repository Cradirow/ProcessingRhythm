//library settings
import ddf.minim.*;
import ddf.minim.analysis.*;

//extends class
ArrayList<Note> notes = new ArrayList<Note>();
ArrayList<Note> lane1 = new ArrayList<Note>();
ArrayList<Note> lane2 = new ArrayList<Note>();
ArrayList<Note> lane3 = new ArrayList<Note>();
ArrayList<Note> lane4 = new ArrayList<Note>();
GameController gameController = new GameController();

//lane counts
int[] laneCount = new int[] {0, 0, 0, 0};

//library instance
PImage musicImg;
Minim minim;
AudioPlayer song;
AudioPlayer beatSong;
BeatDetect beat;
//BeatDetect beats;
float eRadius;

//recources
PImage unityImg;
PImage go4itImg;
PImage firestoneImg;

//game manage
boolean isStart = false; //false before start
boolean mouseOver = false;
boolean isMusicOn = false;

//game settings
int hp = 100;
int score = 0;
int combo = 0;
int speed = 2; // speed x0.8, x1.0, x1.2 support
int music = 0;

int perfectScore = 20;
int goodScore = 10;

//hit effects
String hitText = "";

//delay
int startTime;
int wait = 4600;

int beatTime;
int beatWait = 200;

void setup(){
  size(550,700);
  background(0);
  
  switch(music){
    
  }
  
  //minim = new Minim(this);
  //song = minim.loadFile("go4it.mp3", 2048);
  //beatSong = minim.loadFile("go4it.mp3", 2048);
  //beat = new BeatDetect();
  
  unityImg = loadImage("unity.jpg");
  go4itImg = loadImage("go4it.jpg");
  firestoneImg = loadImage("firestone.jpg");
  musicImg = go4itImg;
  
  smooth();
  strokeWeight(3); 
}

void songSelect(int _music){
  minim = new Minim(this);
  switch(_music){
    case 0: 
      song = minim.loadFile("unity.mp3", 2048);
      beatSong = minim.loadFile("unity.mp3", 2048);
      break;
    case 1:
      song = minim.loadFile("go4it.mp3", 2048);
      beatSong = minim.loadFile("go4it.mp3", 2048);
      break;
    case 2:
      song = minim.loadFile("firestone.mp3", 2048);
      beatSong = minim.loadFile("firestone.mp3", 2048);
      break;
    default: break;
  }
  beat = new BeatDetect();
  //beats = new BeatDetect();
  ellipseMode(RADIUS);
  eRadius = 20;
}

void draw(){
    
  if(isStart){
    background(255);
    beatDetection();
    
    backgroundDraw();
    UIDraw();
    
    if(millis() - startTime >= wait){
      update();
      if(!isMusicOn){
        song.play();
        isMusicOn = true;
      }
    }
      
  }else{
    background(0);
    String title = "TheFatRat - Unity";
    switch(music){
      case 0:
      musicImg = unityImg;
      title = "TheFatRat - Unity";
      break;
      case 1:
      musicImg = go4itImg;
      title = "TheFatRat - Go4It";
      break;
      case 2:
      musicImg = firestoneImg;
      title = "Kygo - Firestone";
      break;
    }
    
    update();
    textSize(30);
    fill(200);
    text(title, 130,150);
    image(musicImg, 150, 200, 200, 200);
    fill(255);
    rect(150,450,200,50,10);
    fill(50);
    textSize(30);
    text("ENTER", 200, 485);
    
    textSize(30);
    fill(255);
    text("SPEED", 200, 550);
    
    triangle(232,590,242,570,252,590);
    triangle(232,670,242,690,252,670);
    
    textSize(60);
    fill(255);
    text(speed, 225, 650);
    
    if(mouseOver){
      fill(0,100,150);
      rect(150,450,200,50,10);
      fill(50);
      textSize(30);
      text("ENTER", 200, 485);
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
  
  //back to menu
  //fill(0);
  //textSize(20);
  //text("GO MENU",435, 600);
  //textSize(20);
  //text("backspace", 435, 640);
  
}

void beatDetection(){
  beatSong.play();
  beatSong.mute();
  beat.detect(beatSong.mix);
  //beats.detect(song.mix);
  
  if ( beat.isOnset() ){
    if(millis() - beatTime >= beatWait){
      int rand = (int)random(0,4);
      newNote(rand);
      beatTime = millis();
    }
  }
  
  eRadius *= 0.95;
  ellipse(455, 565, eRadius, eRadius);
  if ( eRadius < 20 ) eRadius = 20;
}

void keyHitImpact(int index){
  float a = map(eRadius, 20, 80, 60, 255);
  fill(random(255), random(255), random(255), a);
  eRadius = index;
}

void keyPressed(){
  if(key == CODED){
    if(keyCode == LEFT){
      if(music > 0){
        music --;
      }
    }else if(keyCode == RIGHT){
      if(music < 3){
        music ++;
      }
    }else if(keyCode == UP){
      if(speed < 3) speed++;
    }else if(keyCode == DOWN){
      if(speed > 2) speed--;
    }
  }
  
  if(keyCode == ENTER || keyCode == RETURN){
    if(!isStart){
      songSelect(music);
      wait = wait/(speed-1);
      isStart = true;  
      startTime = millis();
    }
  }
  
  //if(keyCode == BACKSPACE){
  //  setup();
  //  isStart = false;
  //}
  
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
    case -1: //above
      hitText = "   BAD";
      combo = 0;
      hp -= 5;
      break;
    case 0: //normal
      hitText = "";
      combo = 0;
      hp -= 5;
      break;
    case 1: //close
      hitText = "  GOOD";
      score += goodScore;
      combo++;
      lane.get(laneCount[index]).hit = true;
      laneCount[index]++;
      keyHitImpact(60);
      break;
    case 2: //exactly fit
      hitText = "PERFECT";
      score += perfectScore;
      combo++;
      lane.get(laneCount[index]).hit = true;
      laneCount[index]++;
      keyHitImpact(90);
      break;
    }
  }catch(IndexOutOfBoundsException e){
    //System.out.println(".");
  }
}

public void noteOut(int _note){
  laneCount[_note]++;
  hitText = "   BAD";
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
    //laneCount[_lane]++;
    Note newNote = new Note(_lane,speed,speed);
    lane.add(newNote);
    notes.add(newNote);
  }
}

void moveNote(int index){
  notes.get(index).update();
  notes.get(index).display();
}

void btnStart(){
  //isStart = true;
}
