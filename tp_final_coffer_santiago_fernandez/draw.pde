

void draw() {
  if (fondo) back_noise(loc, loc2, acumXOff1);

//rotacion y movimiento de ruido //acumuladores
  if (randRot) {
    coff.updateAVel();
  } else {
    coff.setAngle(ang);
  }
  coff.setNoise(acumXOff);
  acumXOff += xOff  ;
  acumXOff1 += xOff1 ;
  ang += velAmg;


//control de la forma display
  if (!random&&!bouncing) {
    coff.display();
  } else {
    if (limites) {
      if (random)coff.rand();
      if (bouncing)coff.bouncing();
    } else {
      if (bouncing) coff.bouncingNoLim();
      if (random) coff.randNoLim();
    }
  }


  if (equis) {
    pushStyle();
    stroke(255);
    strokeWeight(2);
    for (int x=0; x<180; x+=90) { //fun que dibuja la x
      coord_inver(new PVector((loc2.x-loc.x)/2, (loc2.y-loc.y)/2).add(loc), 20, x+45);
    }
    popStyle();
  }


  if (recording) {
    saveFrame("output/secuencia/secuencia_####.png");
  }
  
  
  
//aumentar el contraste y blurear??
//https://processing.org/reference/blend_.html
//https://processing.org/reference/filter_.html
}
