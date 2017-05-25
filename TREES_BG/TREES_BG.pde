/* @pjs preload="BUSH.png"; */

PImage _bush;

float _BASE_POSSIBILITY = 10.0;

float _secondsSinceStart;
float _bushAtQuarterPossibility;
float _randomVal;

float _appleAtQuarterPossibility;
float _minApple;
float _maxApple;

int _numBushes;
int _maxBushes;

PVector[] _bushes;
float[] _bushSeconds;

void setup(){
  //fullScreen();
  size(2500,2500);
  background(255);
  fill(255);
  
  _bush = loadImage("BUSH.png");
  _maxBushes = 25;
  
  _bushes = new PVector[_maxBushes];
  _bushSeconds = new float[_maxBushes];
  
  _secondsSinceStart = 0.0;
  _bushAtQuarterPossibility = 45.0;
  
  _appleAtQuarterPossibility = 15.0;
  _minApple = 64.0;
  _maxApple = 128.0;

  _numBushes = 0;
}

void draw(){
  _secondsSinceStart = millis() / 1000.0;
  _randomVal = random(0.0, 100.0);
  
  float _x = (_secondsSinceStart) / (_secondsSinceStart + _bushAtQuarterPossibility);
  
  if(_randomVal <= _x*_BASE_POSSIBILITY){
    newBush();
  }
  
  if(_numBushes > 0)
    parseBushes();
  
  delay(5);
}

void newBush(){
  int _w = _bush.width / 2;
  int _h = _bush.height / 2;
  float _xPos = random(0.0 - _w/2.0, width - _w/2.0);
  float _yPos = random(0.0 - _h/2.0, height - _h/2.0);
  
  fill(255);
  stroke(255);
  image(_bush, _xPos,  _yPos, _w, _h);
  _bushes[(_numBushes % _maxBushes)] = new PVector(_xPos + _w/2.0, _yPos + _h/2.0);
  _bushSeconds[(_numBushes % _maxBushes)] = _secondsSinceStart;
  
  ++_numBushes;
}

void parseBushes(){
  float _xx;
  float _sec;
  
  for(int i = 0; i < (_numBushes % _maxBushes); i++){
    _sec = (millis() / 1000.0) - _bushSeconds[i];
    _xx = (_sec) / (_sec + _appleAtQuarterPossibility);
    _randomVal = random(0.0, 100.0);
    
    if(_randomVal <= _xx*.5*_BASE_POSSIBILITY){
      newApple(_bushes[i]);
    }
    
  }
}

void newApple(PVector v){
  float _ax = v.x + random(-_bush.width / 6.0, _bush.width / 6.0);
  float _ay = v.y + random(-_bush.height / 6.0, _bush.height / 6.0);
  float _size = random(_minApple, _maxApple);
  
  fill(255,0,0);
  stroke(255,0,0);
  ellipse(_ax, _ay, _size, _size);
}