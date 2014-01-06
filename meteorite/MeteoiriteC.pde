class MeteoriteC {

  String name, rClass;
  int year, id ;
  float lati, longi,mass;

  MeteoriteC(TableRow row) {
    //    name = row.getString("name");
    //   rClass = row.getString("recclass");
    mass = row.getFloat("mass_g");
    year = row.getInt("year");
    //  id = row.getInt("id");
    String latS = row.getString("latitude").replace(",", ".");
    String longS = row.getString("longitude").replace(",", ".");
    //   println(lat);
    try {
      lati = Float.valueOf(latS);
      longi = Float.valueOf(longS);
      //    println(latF);
    }

    catch(Exception exc) {
    }
  }

  String toString() {
    return id+": "+name+": year:"+ year+ " mass: "+mass+ " ("+ lati+","+longi+")";
  }

  PVector mapLocation() {
    float latitude = map(lati, -90, 90, 0, height);
    float longitude = map(longi, -180, 180, 0, width);
    return new PVector(longitude, latitude);
  }
}

