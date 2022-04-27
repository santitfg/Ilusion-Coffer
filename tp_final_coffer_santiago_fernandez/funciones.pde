

//funcion base para contruir la equis central
void coord_inver(PVector centro, float r, float a) {

  float midX, midY;  
  midX=centro.x;
  midY=centro.y;
  line(coord_polar(r, a).x+midX, coord_polar(r, a).y+midY, midX, midY);
  line(midX, +midY, coord_polar(r, a+180).x+midX, coord_polar(r, a+180).y+midY);
}


//calculo de coordenas polares
PVector coord_polar(float centerX, float centerY, float rad, float rot) {//funcion para optimizar las coordenadas polares con la suma del centro
  /*float x, y;
  x=centerX+rad*cos(radians(rot));
  y=centerY+rad*sin(radians(rot));*/
  //ya existia la variable que devolvia un angulo
  return new PVector(centerX,centerY).add(PVector.fromAngle(radians(rot)).setMag(rad));
}

//calculo de coordenas polares invirtiendo en espejo para trazar las paralelas en el circulo
PVector coord_polar_opuesta(float centerX, float centerY, float rad, float rot) {//funcion para optimizar las coordenadas polares opuesta con la suma del centro
  float x, y;
  rot=map(rot, 0, 180, 180, 0);
  x=centerX+rad*cos(radians(rot));
  y=centerY+rad*sin(radians(rot));
  return new PVector(x, y);
}


//funcion polar para usar en la esquis
PVector coord_polar(float rad, float rot) {
  float x, y;
  x=rad*cos(radians(rot));
  y=rad*sin(radians(rot));
  return new PVector(x, y);
}


//construcion de circulo y rotacion
void circle_noise_angle(float midX, float midY, float dia, float xOff, float a) {
  pushMatrix();
  translate(midX,midY);
  rotate(a);
  circle_noise( 0, 0, dia, xOff);
  popMatrix();
}


//construcion de circulo
void circle_noise(float midX, float midY, float dia, float xOff) {
  float rotA;
  float c= xOff;
  //float c=0;
  PVector tempA, tempB;
  float col;    
  float r;
  r=dia/2;

  for (int n=0; n<=dia*2; n++) {
    col = map(noise(c), 0, 1, 0, 255);
    stroke(col);
    rotA = map(n, 0, dia*2, 90, -90);
    //    rotB = map(rotA, 0, -90, -180, -90);
    tempA =coord_polar(midX, midY, r, rotA);
    tempB =coord_polar_opuesta(midX, midY, r, rotA);
    line(tempA.x, tempA.y, tempB.x, tempB.y);
    c+=.1;
  }
}


//fondo de ruido en modo rectangulo

void back_noise(PVector loc_, PVector loc2_,float xOff_) {
  float col, count=1000;
  float x= loc_.x;
  float y= loc_.y;
  float w= loc2_.x;
  float h= loc2_.y;

  for ( int p=(int(x)); p<=w; p++) {
    col = map(noise(count+xOff_), 0, 1, 0, 255);
    stroke(col);
    line(p, y, p, h);
    count+=.1;
  }
}
