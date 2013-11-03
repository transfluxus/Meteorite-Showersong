import ddf.minim.*;

Minim minim;
AudioPlayer player;

float maxDist = 1563.7855; // from 0,0 > width,height

// final int EUROPE=0, ASIA=1, AFRICA=2, AUSTRALIA=3, NORTH_AMERICA=4, SOUTH_AMERICA=5, SEA=6;

// WHY DOES MINIM SLOW DOWN AFTER A WHILE?

void playSound(PVector loc, float mass) {
  int continent = getContinent(loc);
  //  int tone =(int) map(mass, minMass, maxMass, 1, 9);
  int  tone = (int) random(1, 9);
  //printl-n(tone);
  switch(continent) {
  case EUROPE:
    play("meteorite sounds/europe"+tone+".aif", loc.dist(birthLocation)); 
    break; 
  case ASIA:
    play("meteorite sounds/asia"+tone+".aif", loc.dist(birthLocation)); 
    break; 
  case AFRICA:
    play("meteorite sounds/afrika"+tone+".aif", loc.dist(birthLocation)); 
    break; 
  case AUSTRALIA:
    play("meteorite sounds/australia"+tone+".aif", loc.dist(birthLocation)); 
    break; 
  case NORTH_AMERICA:
    play("meteorite sounds/usa"+tone+".aif", loc.dist(birthLocation)); 
    break; 
  case SOUTH_AMERICA:
    play("meteorite sounds/south_america"+tone+".aif", loc.dist(birthLocation)); 
    break;    
  case SEA:
    play("meteorite sounds/water"+tone+".aif", loc.dist(birthLocation)); 
    break;
  }
}

void play(String fileName, float distance) {
  player = minim.loadFile(fileName);
  float relative = 1-(distance / maxDist);
  player.setGain(-50+50*relative);
  player.play();
}

