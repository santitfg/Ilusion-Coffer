
// para un futuro agregarle a NCircles una funcion que permita arrastralas con el mouse (y en coffer una q la invoque)

class Coffer {

  ArrayList<PVector> list;
  ArrayList<NCircle> NC;
  PVector loc, loc2;
  float modulo, moduloY, a;
  int diam, dist; //diametro y distancia entre circulos
  Coffer (PVector loc1_, PVector loc2_, int diam_, int dist_, float a_) {

    list= new ArrayList<PVector>();
    NC = new ArrayList<NCircle>();
    a= a_;
    diam = diam_;
    dist=dist_;
    loc = loc1_.copy();
    loc2 = loc2_.copy();


    //modulo es espacio q sobrga entre n circulos + su respectiva distancia y el el area a cubrir
    modulo= (loc2.x-loc.x) % (diam+dist); 
    moduloY= (loc2.y-loc.y) % (diam+dist);
  }

  //displays
  void display() { 
    for (NCircle  nc : NC) {
      nc.display(); //      nc.display(true); 
      //nc.display(bool); para generar que los circulos tengan el mismo noise
      //true circulos lo comparten horizontalmente y false verticalmente
    }
  }
  void rand() {
    for (NCircle  nc : NC) {
      nc.rand();
      nc.edges();
      nc.display();
    }
  }

  void randNoLim() {
    for (NCircle  nc : NC) {
      nc.rand();
      nc.display();
    }
  }
  void bouncingNoLim() {
    for (NCircle  nc : NC) {
      nc.bouncing();
      nc.display();
    }
  }
  void bouncing() {
    for (NCircle  nc : NC) {
      nc.bouncing();
      nc.edges();
      nc.display();
    }
  }

  //updates

  void updateAVel() {
    for (NCircle  nc : NC) {
      nc.updateAVel();
    }
  }
  void updateAVel(float aVel_) {
    for (NCircle  nc : NC) {
      nc.updateAVel(aVel_);
    }
  }

  void updateAVelRand(float min_, float max_) {
    for (NCircle  nc : NC) {
      nc.updateAVel(random(min_, max_));
    }
  }

  //procesos de creacion y manipulacion de instancias
  void remo() {

    for (int n = list.size()-1; n>-1; n--) {
      list.remove(n);
      NC.remove(n);
      //println("size: "+ lista_.size());
    }
  }

  void calculo() {

    //modulo es espacio q sobra entre n circulos + su respectiva distancia y el el area a cubrir
    modulo= (loc2.x-loc.x) % (diam+dist); 
    moduloY= (loc2.y-loc.y) % (diam+dist);
    /*sumo a loc q seria el borde izq sup arriba
     el diam /2 (=radio) es paara compensar q el circul oesta centrado
     el modulo/2 compensa  la division no entera de esferas y corrije centrando
     */
    for (float y = loc.y+diam/2+moduloY/2; y < loc2.y; y +=diam) {
      y+= dist/2;
      if (loc2.y<y+diam/2) { //este if evita al igual q el del X, que los circulos exedan
      } else {
        for (float x = loc.x+diam/2+modulo/2; x < loc2.x; x +=diam) {
          x+= dist/2;
          if (loc2.x<x+diam/2) {
          } else {
            list.add(new PVector(x, y));
          }
          x+= dist/2;
        }
      }
      y+= dist/2;
    }
  }

  void llenar() {
    for (PVector pv : list) {
      NC.add(new NCircle(pv, loc, loc2, diam, a));
    }
  }

  //seteos
  void reSet() {
    for (int i =0; i<NC.size(); i++) {
      NC.get(i).setLoc(list.get(i));
      println(list);
    }
  }

  void setAngle(float ang_) {
    for (int i =0; i<NC.size(); i++) {
      NC.get(i).a = ang_;
    }
  }

  void setAVel(float aVel_) {
    for (NCircle  nc : NC) {
      nc.aVel=aVel_;
    }
  }

  void newDiam(int diametro) {
    for (NCircle  nc : NC) {
      nc.diam=diametro;
    }
  }

  void newDiamReset(int diametro) {
    diam=diametro;
    remo();
    calculo();
    llenar();
  }
  void newDistReset(int distancia) {
    dist=distancia;
    remo();
    calculo();
    llenar();
  }
  void newSet(int diam_, int dist_) {
    diam=diam_;
    dist=dist_;
    remo();
    calculo();
    llenar();
  }


  void setNoise(float nOff_) {
    for (NCircle  nc : NC) {
      nc.nOff=nOff_;
    }
  }


  //fin del coffer
}



class NCircle { // o en vez de esta clase usar una funcion en coffer de generar una array list 
  PVector loc, lim1, lim2;
  PVector vel;
  float a, aVel, nOff, xOff;
  int diam;

  //boolean limiteX, limiteY;// si es true crece sino decrece;
  NCircle(PVector loc_, PVector loc1_, PVector loc2_, int diam_, float a_) {
    loc=loc_.copy();
    lim1 = loc1_.copy();
    lim2 = loc2_.copy();

    vel = new PVector (random(-5, 5), random(-5, 5));
    diam=diam_;
    a = a_;
    aVel=random(-PI, PI);
  }

  void setLoc(PVector newLoc_) {
    loc=newLoc_.copy();
  }

  void setNoise(float nOff_) {
    //nOff paso del noise, y mOff multiplicador 
    nOff=nOff_;
  }
  void display() { //display
    xOff=loc.x+loc.y+nOff;
    circle_noise_angle(loc.x, loc.y, diam, xOff, a);
  }

  void display(boolean alinear) { //display

    if (alinear) {
      xOff=loc.y+nOff;
    } else {
      xOff=loc.x+nOff;
    }
    circle_noise_angle(loc.x, loc.y, diam, xOff, a);
  }
  void bouncing() {
    loc.add(vel);
  }
  void rand() {
    loc.add(random(-5, 5), random(-5, 5));
  }
  void updateAVel() {
    a+=aVel;
  }

  void updateAVel(float aVel_) {
    a+=aVel_;
  }

  void edges() {
    if (loc.x>lim2.x-diam/2) { 
      loc.x =lim2.x-diam/2;
      vel.mult(-1);
      vel = new PVector (random(-5, 5), random(-5, 5));
    }
    if (loc.x<lim1.x+diam/2) {   
      loc.x =lim1.x+diam/2;
      vel.mult(-1);
      vel = new PVector (random(-5, 5), random(-5, 5));
    }
    if (loc.y>lim2.y-diam/2) { 
      loc.y = lim2.y-diam/2;
      vel.mult(-1);
      vel = new PVector (random(-5, 5), random(-5, 5));
    }
    if (loc.y<lim1.y+diam/2) {
      loc.y=lim1.y+diam/2;
      vel.mult(-1);
      vel = new PVector (random(-5, 5), random(-5, 5));
    }
  }
  //fin de NCircle
}
