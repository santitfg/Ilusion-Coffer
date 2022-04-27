
/*
MAE UNTREF - Diseno digital (Andrés Rodríguez) - 2021
Trabajo final - ilusion Coffer
Santiago T. Fernandez G.
*/

/*
ilusion optica generada a partir de bandas de ruido verticales como fondo
y circulos equidistantes rellenos de bandas de ruido a 90° 


para q los circulos circulos tengan el mismo noise (fortalece la ilusion)
dentro de la clase coffer buscar el void display  y modificar el "nc.display(bool);"
//true circulos lo comparten horizontalmente y false verticalmente
*/

//27-4-22 corregir el random 

import controlP5.*;

Coffer coff;
ControlP5 cp5;

PFont aleo;

//vectores para contructor del coffer
PVector loc, loc2;

//variables de angulo, diversos offset del ruido, acumuladores de los mismos 
float ang, xOff=.0, xOff1=.0, acumXOff=.0, acumXOff1=.0, velAmg=0;

// el diametro y distancia entre circulos

int  diam , dist;  


//boleanos flujo del programa
boolean recording=false, equis=true, random=false, 
  bouncing=false, limites = true, fondo=true, 
  randRot=false;

//colores del cp5
color label=color(255), active=color(200), back=color(20), fore=color(170), valueLabel=color(255) ;


void setup() {
  size(900, 600);
  
//println(PVector.fromAngle(PI));
  surface.setTitle("ilusion coffer");
  surface.setLocation(100, 100);
  noiseSeed(2021); //semillas del noise y el rand para que sea reproducible la experiencia
  randomSeed(2021);
  background(70);


   aleo = createFont("Aleo-Regular.ttf",12);
   textFont(aleo);

  cp5 = new ControlP5(this);

  // coffer 
  loc = new PVector(350, 50); //esquina superior izq de inicio
  loc2 = new PVector(850, 550); //esquina inferior der de final
  text("coffer ilusion", loc.x+2, loc2.y+15); 

  //constructor de una instancia de coffer
  coff = new Coffer ( loc, loc2, diam, dist, ang);
  coff.calculo();
  coff.llenar();

  //cp5 


  //bangs, controlando save, reset y remover NCircles
  int bX=175, bY=240;

  cp5.addBang("remover")
    .setPosition(bX, 40+bY)
    .setSize(40, 40)
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    ;
  cp5.addBang("captura")
    .setPosition(bX, 120+bY)
    .setSize(40, 40)
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    ;
  cp5.addBang("nuevo")
    .setPosition(bX, 200+bY)
    .setSize(40, 40)
    .setColorActive(active) 
    .setColorBackground(back) 
    .setColorForeground(fore) 
    ;
  /*
  cp5.addBang("resituar")
   .setPosition(200, 280)
   .setSize(40, 40)
   .setColorActive(color(170)) 
   .setColorBackground(back) 
   .setColorActive(active) 
   .setColorForeground(fore) 
   ;
   */

  //toggles de recording, equis, random, bouncing, limites, fondo, randRot;
  int tX= 40, lY=100, yM=45;
//hay dos botones comentados, el de grabar (sigue funcinando la tecla "r" o "R" y el boton de rotaciones aleatorias

  /*
  cp5.addToggle("recording")
   .setPosition(tX, 50)
   .setSize(20, 20)
   .setColorActive(color(255, 0, 0))
   .setColorBackground(color(0, 250, 0)) 
   .setColorForeground(color(250, 50, 100)) 
   
   ;
   */
  cp5.addToggle("equis")
    .setPosition(tX, lY+4* yM)
    .setSize(20, 20)
    .setColorActive(active) 
    .setColorBackground(back) 
    .setColorForeground(fore) 

    ;
  cp5.addToggle("random")
    .setPosition(tX, lY+5* yM)
    .setSize(20, 20)
    .setColorActive(active)
    .setColorBackground(back) 
    .setColorForeground(fore) 

    ;
  cp5.addToggle("bouncing")
    .setPosition(tX, lY+6* yM)
    .setSize(20, 20)
    .setColorActive(active) 
    .setColorBackground(back) 
    .setColorForeground(fore) 

    ;
  cp5.addToggle("limites")
    .setPosition(tX, lY+7* yM)
    .setSize(20, 20)
    .setColorActive(active) 
    .setColorBackground(back) 
    .setColorForeground(fore) 

    ;

  cp5.addToggle("fondo")
    .setPosition(tX, lY+8* yM)
    .setSize(20, 20)
    .setColorActive(active) 
    .setColorBackground(back) 
    .setColorForeground(fore) 

    ;
  /*
  cp5.addToggle("randRot")
   .setPosition(tX, lY+9* yM)
   .setSize(20, 20)
   .setColorActive(active) 
   .setColorBackground(back) 
   .setColorForeground(fore) 
   ;
   */


  //sliders
int sX=20;
  cp5.addSlider("ang")
    .setPosition(sX, 40)
    .setSize(200, 20)
    .setRange(PI, -PI)
    .setValue(0)
    .setLabel("angulo")
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    //.setDecimalPrecision()
    ;
  cp5.addSlider("velAmg")
    .setPosition(sX, 70)
    .setSize(200, 20)
    .setRange(-1, 1)
    .setValue(0)
    .setLabel("vel_ang")
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    ;

  cp5.addSlider("xOff")
    .setPosition(sX, 110)
    .setSize(200, 20)
    .setRange(-1, 1)    .setValue(0)
    .setLabel("oXff_circulos")
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    ;
  cp5.addSlider("xOff1")
    .setPosition(sX, 140)
    .setSize(200, 20)
    .setRange(-1, 1)    .setValue(0)
    .setLabel("oXff_fondo")
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    ;


  cp5.addSlider("diametro")
    .setPosition(sX, 180)
    .setSize(200, 20)
    .setRange(1, 300)
    .setValue(75)
    .setLabel("diametro")
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    ;
  cp5.addSlider("distancia")
    .setPosition(sX, 210)
    .setSize(200, 20)
    .setRange(0, 100)
    .setValue(48)
    .setLabel("distancia")
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    ;
}
