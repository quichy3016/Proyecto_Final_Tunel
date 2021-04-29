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
float p,d,v,dp,dp1,dp2,dp3,v1,v2,v3,v4,tiempo,pwm,paro;

/////tabla////
Table table;
void setup (){
 
  size(700, 600);
  background(255);
  print(Serial.list());//Cambia el indice [1] por el que indique la consola
  puertoArduino = new Serial(this, Serial.list()[0], 115200);
  datos = createWriter("medidasT_HR.txt");
  fill(255, 0, 0);
  text("TEMPERATURA (ºC) : ", 20, 20);
  fill(0, 0, 255);
  text("HR (%) : ", 20, 40);
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
}

void draw(){

  String inString = puertoArduino.readStringUntil('\n'); 
  
  
  if (inString != null){
      
      algo = float(split(inString,';'));
      t=algo[0];
      h=algo[1];
      p=algo[2];
      d=algo[3];
      v=algo[4];
      dp=algo[5];
      dp1=algo[6];
      dp2=algo[7];
      dp3=algo[8];
      v1=algo[9];
      v2=algo[10];
      v3=algo[11];
      v4=algo[12];
      tiempo=algo[13];
      pwm=algo[14];
      paro=algo[15];
      tabla();
      fill (0,255,255);
      text(h, 140, 40);
      if (v1 >= 0 && v1 <= 100){
        
        g.puntosv1(x, v1);
        
        
       }
     //inString = trim(inString);
     if (flagTemp == false){
      fill(255,255,255);
      noStroke();
      rectMode(CORNERS); 
      rect(140,20,200,45);//Borra lectura anterior 
      //h = float(inString);
      datos.print(pwm +" "+ TAB); 
      flagTemp = true;
      fill (0,0,255);
      text(h, 140, 40);
      //println("PWM (%) :", pwm);
      if (pwm >= 0 && pwm <= 1023){
        
        g.puntosH(x, pwm, pH);
        
        
       }
       pH = false;
     }
     else{
       fill(255,255,255);
       noStroke();
       rectMode(CORNERS);
       rect(140,5,200,25); //borra lectura anterior 
       //t = float(inString);
       
       datos.println(t);
       flagTemp = false;
       fill (255,0,0);
       text(t, 140, 20);
       //println("Diferencia de Presion (PA) : ", dp);
      
       if (dp >= 0.0 && dp <= 1023){
          
         g.puntosT(x, dp, pT);
          
        }
         pT = false;  
     }
     
     x = x + 5;
     
     }
                
     if (x > ancho - 60) {
        x = 60;
        pT = true;
        pH = true;
        g.borra();
        g.cuadricula1();
        g.cuadricula2();
              
     }
         
    }
     
void keyPressed() {//Presionar 'ESC' para salir
    datos.flush();  
    datos.close();  
    exit();  
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

  
  //println(table.getRowCount());  // Prints 3
  saveTable(table, "data/prueba15.csv","csv");
  //int d = Integer.parseInt(algo[1]);
   
  }
