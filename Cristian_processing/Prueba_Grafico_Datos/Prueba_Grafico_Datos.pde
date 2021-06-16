// visual_dot.pde
// Representa puntos con los valores de Temperatura y Humedad
// recogidos de Arduino con DHT11.
// Jorge Muñoz, Manuel Hidalgo, Pablo Garcia, Jorge L. Loza
// Licencia: GPL v3
// Este es un programa ad-hoc para demostración.
// Necesita Graf.pde
// Modificalo a tu gusto.
// Tildes omitidas.

import processing.serial.*;

int x = 65, ancho = 700, alto = 600;
int cFondo = 255; //Color fondo
boolean flagTemp = false; 
boolean pH = true;
boolean pT = true;
float t = 0, h = 0 ;
PrintWriter datos;
Serial puertoArduino;
Graf g = new Graf(ancho, alto, cFondo);

/////variables*//
float [] algo;
float p,d,v,dp,dp1,dp2,dp3,v1,v2,v3,v4,tiempo,pwm,paro,h2,VelRef,error;

/////tabla////
Table table;

////text/////
String textbox_says = "0";

void setup (){
 
  size(700, 600);
  background(255);
  print(Serial.list());//Cambia el indice [1] por el que indique la consola
  puertoArduino = new Serial(this, Serial.list()[2], 115200);
  datos = createWriter("medidasT_HR.txt");
  fill(255, 0, 0);
  text("TEMPERATURA [ºC] : ", 20, 20);
  fill(255, 0, 0);
  text("Control : ", 20, 60);
  fill(255, 0, 0);
  text("PWM : ", 200, 20);
  fill(255, 0, 0);
  text("DP [Pa]: ", 330, 20);
  fill(0, 0, 255);
  text("Vel (m/s) : ", 480, 20);
  fill(0, 0, 255);
  text("HR (%) : ", 20, 40);
  fill(0, 0, 255);
  text("Tiempo (s) : ", 330, 580);
  fill(0, 0, 255);
  text("Vel Ref (m/s) : ", 480, 40);
  fill(0, 0, 255);
  text("Error (m/s) : ", 480, 60);
  //text("DHT11 - Rango de temperaturas (0ºC < T < 50ºC)", (ancho / 2) - 100, 20);
  //text("DHT11 - Rango de humedad relativa (20 % < H < 90 %)", (ancho / 2) - 100, 40);
  pT = true;
  pH = true;
  g.cuadricula1();
  g.cuadricula2();
  /////////////table/////////
  table = new Table();
  table.addColumn("Muestra");
  table.addColumn("Temp");
  table.addColumn("Hum");
  table.addColumn("Pres");
  table.addColumn("Den");
  table.addColumn("Vol");
  table.addColumn("DP");
  table.addColumn("DP1");
  table.addColumn("DP2");
  table.addColumn("DP3");
  table.addColumn("Vel1");
  table.addColumn("Vel2");
  table.addColumn("Vel3");
  table.addColumn("Vel4");
  table.addColumn("Tiempo");
  table.addColumn("PWM");
  table.addColumn("Paro");
  table.addColumn("Hum2");
  table.addColumn("VelRef");
  table.addColumn("Error");
}

void draw(){
  //if (millis()>3000){

  Main();
    }
     
void keyPressed() {//Presionar 'ESC' para salir

    if( key != CODED ){
      if(key != 'd' & key != 'D' & key != 'f' & key != 'F'){
      textbox_says += key;
     }}
    
    if (keyPressed) {
    if (key == 'b' || key == 'B') {
    saveTable(table, "data/1606/Prueba_10_Casa.csv","csv");
    //fill(0);
    }
    } else {
    //fill(255);
    }
    //rect(25, 25, 50, 50);
    
    if (key == 'd' || key == 'D') {
    puertoArduino.write((textbox_says));
    //puertoArduino.write("5.5"); 
    //puertoArduino.write(67); 
    //fill(0);
    }
    
    if (key == 'f' || key == 'F') {
    //puertoArduino.write(int(65));
    textbox_says="0";
    //fill(0);
    }
    //datos.flush();  
    //datos.close();  
    //exit();  
}


void tabla(){
  TableRow newRow = table.addRow();
  newRow.setInt("Muestra", table.lastRowIndex());
  newRow.setFloat("Temp", t);
  newRow.setFloat("Hum", h);
  newRow.setFloat("Pres", p);
  newRow.setFloat("Den", d);
  newRow.setFloat("Vol", v);
  newRow.setFloat("DP", dp);
  newRow.setFloat("DP1", dp1);
  newRow.setFloat("DP2", dp2);
  newRow.setFloat("DP3", dp3);
  newRow.setFloat("Vel1", v1);
  newRow.setFloat("Vel2", v2);
  newRow.setFloat("Vel3", v3);
  newRow.setFloat("Vel4", v4);
  newRow.setFloat("Tiempo", tiempo);
  newRow.setFloat("PWM", pwm);
  newRow.setFloat("Paro", paro);
  newRow.setFloat("Hum2", h2);
  newRow.setFloat("VelRef", VelRef);
  newRow.setFloat("Error", error);

  
  //println(table.getRowCount());  // Prints 3
  
  //int d = Integer.parseInt(algo[1]);
   
  }
