import processing.serial.*;
Serial puertoArduino;

String textbox_says = "0";
float [] algo;
float t;
boolean a=true;
void setup(){
  size(700, 600);
  background(255);
  print(Serial.list());//Cambia el indice [1] por el que indique la consola
  puertoArduino = new Serial(this, Serial.list()[0], 115200);
}

void draw(){
  String inString = puertoArduino.readStringUntil('\n'); 
  
  if (millis()>2200){
  if (inString != null){
      
      algo = float(split(inString,';'));
      fill (255,0,0);
      t=algo[0];
      
      text(t, 270, 20);
      println(t);
      text(textbox_says, 150, 580);
      puertoArduino.write("1"); 
      
      if(a== true){
       fill(255,255,255);
       noStroke();
       rectMode(CORNERS);
      
      rect(130,560,190,610);//Borra lectura anterior
      a=!a;
      }
}}}


void keyPressed() {//Presionar 'ESC' para salir

    if( key != CODED ){
      if(key != 'd' & key != 'D' & key != 'f' & key != 'F'){
      textbox_says += key;
     }}
    
    if (keyPressed) {
    if (key == 'b' || key == 'B') {
    //saveTable(table, "data/Prueba_10_Casa.csv","csv");
    //fill(0);
    }
    } else {
    //fill(255);
    }
    //rect(25, 25, 50, 50);
    
    if (key == 'd' || key == 'D') {
    //puertoArduino.write((textbox_says)); 
    puertoArduino.write(1); 
    //puertoArduino.write(67); 
    //fill(0);
    }
    
    if (key == 'f' || key == 'F') {
    //puertoArduino.write(int(65));
    textbox_says="0";
    //fill(0);
    }
}
