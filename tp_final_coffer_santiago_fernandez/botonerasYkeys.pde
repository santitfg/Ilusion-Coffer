void keyPressed() {
//keys desactualizadas pero lo dejo para ciertos testeos
  if (key  =='r'||key =='R') {
    recording= !recording;
  }

  if (key  =='f'||key =='F') {
    diam--;
    coff.newDiam(diam);
  }

  if (key  =='g'||key =='G') {

    diam ++;
    coff.newDiam(diam);
  }

  if (key  =='p'||key =='P') {
    bouncing=!bouncing;
  }
  if (key  =='o'||key =='O') {
    //bouncing=false;
    random=!random;
  }
  if (key  =='b'||key =='B') {
    fondo=!fondo;
  }
  if (key  =='m'||key =='M') {//y hacer un reboot
    coff.reSet();
  }
  if (key  =='n'||key =='N') {//y hacer un reboot
    coff.newSet(diam, dist);
    random=false;
    fondo=true;
    bouncing=false;
  }
}

//////////////////////////////////voids para el cp5
void diametro(int diam_) {
  diam = diam_;
  
  if(random||bouncing){
  coff.newDiam(diam);
  }else{
     coff.newDiamReset(diam);
  }
}
void distancia(int dist_) {
  dist = dist_;
  coff.newDistReset(dist);
}

void nuevo() {
  background(70);
  xOff=.0; 
  xOff1=.0;
  velAmg=0;
  ang=0;
  acumXOff=0;
  acumXOff1=0;
  coff.newSet(diam, dist);
  random=false;
  randRot=false;
    text("coffer ilusion", loc.x+2, loc2.y+15); 

}

void remover() {
  coff.remo();
}

void captura() {
  saveFrame("output/capturas/####.png");
}

void resituar() {
  xOff=.0; 
  xOff1=.0;
  velAmg=0;
  ang=0;
  acumXOff=0;
  acumXOff1=0;
  velAmg=0;
  coff.reSet();
}
