import java.util.*;

ArrayList<MeteoriteC> meteorites = new ArrayList<MeteoriteC>();
PImage earth;

PVector birthLocation= new PVector(602, 125); // Berlin
PImage birthImage;

// next meteorite
int index=0;
// meteorite circle size
int groesse= 100;
PGraphics pg;
PGraphics pg2;

float minMass=0, maxMass=0;
int numberOfMeteroids; // not used

final int EUROPE=0, ASIA=1, AFRICA=2, AUSTRALIA=3, NORTH_AMERICA=4, SOUTH_AMERICA=5, SEA=6;

int[] continentColors = {
  -4128768 // EUROPE
  , -836095 // ASIA
  , -76498 // AFRICA
  , -4177792 // AUSTRALIA
  , -16724992 // NORTH_AMERICA
  , -16744448 // SOUTH_AMERICA
  , -1 // SEA
};

void setup() {
  size(1420, 655);
  background(0);
  strokeWeight(3);
  noFill();
  stroke(0);
  frameRate(5);
  textSize(100);

  pg = createGraphics(width, height);
  pg2 = createGraphics(width, height);

  minim = new Minim(this);
  loadMeteorite();
  loadEarth();
  birthImage = loadImage("birth.png");

  //println(dist(0,0,width,height));
  //  imageMode(CORNER);
  //  image(earth, 0, 0);
}



void draw() {
  // bg image
  imageMode(CORNER);
  image(earth, 0, 0);
  meteorite();
  // birth start image
  imageMode(CENTER);
  image(birthImage, birthLocation.x, birthLocation.y, 10, 10);
}

void meteorite() {
  // get next meteorite and its location
  MeteoriteC met = meteorites.get(index++);
  PVector metLoc = met.mapLocation();

  // mass is not considered atm
  playSound(metLoc, met.mass);

  // big meteorite circle
  pg.beginDraw();
  pg.tint(255, 50);
  pg.image(earth, 0, 0);
  pg.ellipseMode(CENTER);
  pg.noStroke();
  pg.fill(0, 100);
  pg.ellipse(metLoc.x, metLoc.y, groesse, groesse);
  pg.endDraw();
  image(pg, 0, 0);

  // little meteorite dot
  pg2.beginDraw();
  pg2.noStroke();
  pg2.fill(0);
  pg2.ellipse(metLoc.x, metLoc.y, 2, 2);
  pg2.ellipseMode(CENTER);
  pg2.endDraw();
  image(pg2, 0, 0);

  // year 
  fill(0);
  text(met.year, 30, height-30);
}



void loadMeteorite() {
  Table table = loadTable("meteors2.csv", "header");

  for (TableRow row : table.rows()) {
    MeteoriteC met =   new MeteoriteC(row);
    meteorites.add(met);
    //    println(met.mass);
    minMass = min(met.mass, minMass);
    maxMass = max(met.mass, maxMass);

    //   println(met.year);
    //      addMass(met.mass);
    //    println(met);
  }
  numberOfMeteroids = meteorites.size();
  Collections.sort(meteorites, new YearComparator());

  //  println("minMass: ", minMass, "maxMass:", maxMass);
  //  println("meteroites loaded");
  //   getToneMasses();
  //  Collections.shuffle(meteorites);
  /*  for ( MeteoriteC met :meteorites)
   println(met); */

  // goto year 1
  for (MeteoriteC m : meteorites)
    if (m.year<=0)
      index++;
    else return;
}



void loadEarth() {
  earth = loadImage("worldmap.png");
  // earth.resize((int)(earth.width*0.6f),(int)(earth.height*0.6f)); // WHY does this not work?!?
  //  println(earth.width, earth.height);
}


class YearComparator implements Comparator<MeteoriteC> {

  int  compare(MeteoriteC o1, MeteoriteC o2) {
    return o1.year - o2.year;
  }
}



void mousePressed() {
  //  println(mouseX, mouseY);
  if (mouseButton==LEFT)
    birthLocation.set(mouseX, mouseY);
  else 
    playSound(new PVector(mouseX, mouseY), 60);
  //  println(get(mouseX, mouseY));
}

int getContinent(PVector p) {
  for (int i=0; i < continentColors.length;i++) {
    if (continentColors[i]==earth.get((int)p.x, (int) p.y)) {
      return i;
    }
  }
  return SEA;
}

void keyPressed() {
  if (key=='s')
    saveFrame("screen-###.png");
}

