// this stuff is not used and commented out in loadMeteorite

HashMap<Float, Integer> massCounter = new HashMap<Float, Integer>();

// count the appearance of all masses (works)
void addMass(float masse) {
  if(masse==Float.NaN)
  println("oho");
  if (massCounter.containsKey(masse)) {
    massCounter.put(masse, massCounter.get(masse)+1);
  }
  else
    massCounter.put(masse, 1);
}

// assign each tone to a range of mass, equaly distributed over all masses ( DOES NOT WORK)
float[] getToneMasses() {
  float toneCounter[] = new float[8];
  ArrayList<Float> masses = new ArrayList<Float> ();
  masses.addAll(massCounter.keySet());
  println("number of masses: "+massCounter.size());
  Collections.sort( masses);
  //
  String[] massC = new String[massCounter.size()];
  for (int i=0; i < massCounter.size();i++)
    massC[i] = ""+masses.get(i)+ " "+massCounter.get(masses.get(i));
  saveStrings("masses.txt", massC);
  //
  //  println("no of mets: "+numberOfMeteroids);
  int count=0;
  int toneCountSet = 1;
  int metsPerTone = numberOfMeteroids / 8;
  println(numberOfMeteroids+ "// "+metsPerTone);
  for (float mass : masses) {
    //  println("m "+mass+ "  "+massCounter.get(mass));
    count+= massCounter.get(mass);
    if (count> toneCountSet*metsPerTone) {
      println(count+" mass: "+mass);
      toneCounter[toneCountSet-1] = mass;
      toneCountSet++;
    }
  }
  println("******* masses for tone *******");
  int i=0;
  for (float c : toneCounter) 
    println((i++)+": "+c);
  return toneCounter;
}

