// this stuff is not used and commented out in loadMeteorite

HashMap<Integer, Integer> massCounter = new HashMap<Integer, Integer>();

// count the appearance of all masses (works)
void addMass(int masse) {
  if (massCounter.containsKey(masse)) {
    massCounter.put(masse, massCounter.get(masse)+1);
  }
  else
    massCounter.put(masse, 1);
}

// assign each tone to a range of mass, equaly distributed over all masses ( DOES NOT WORK)
int[] getToneMasses() {
  int toneCounter[] = new int[8];
  ArrayList<Integer> masses = new ArrayList<Integer> ();
  masses.addAll(massCounter.keySet());
  Collections.sort( masses);
//  println("no of mets: "+numberOfMeteroids);
  int count=0;
  int toneCountSet = 1;
  int metsPerTone = numberOfMeteroids / 8;
  for (int mass : masses) {
    println("m "+mass+ "  "+massCounter.get(mass));
    count+= massCounter.get(mass);
    if (count> toneCountSet*metsPerTone)
      toneCounter[toneCountSet-1] = count;
  }
  for (int c : toneCounter)
    println(c);
    return toneCounter;
}

