import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Grafico_Tunel extends PApplet {

// visual_dot.pde
// Representa puntos con los valores de Temperatura y Humedad
// recogidos de Arduino con DHT11.
// Jorge Muñoz, Manuel Hidalgo, Pablo Garcia, Jorge L. Loza
// Licencia: GPL v3
// Este es un programa ad-hoc para demostración.
// Necesita Graf.pde
// Modificalo a tu gusto.
// Tildes omitidas.



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

public void setup (){
 
  
  background(255);
  print(Serial.list());//Cambia el indice [1] por el que indique la consola
  puertoArduino = new Serial(this, Serial.list()[1], 115200);
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
  table.addColumn("Hum2");
  table.addColumn("Pres");
  table.addColumn("Den");
  table.addColumn("Vol");
  table.addColumn("DP");
  table.addColumn("DP1");
  table.addColumn("Vel1");
  table.addColumn("Vel2");
  table.addColumn("Tiempo");
  table.addColumn("PWM");
  table.addColumn("Paro");
  table.addColumn("VelRef");
  table.addColumn("Error");
}

public void draw(){
  //if (millis()>3000){

  Main();
    }
     
public void keyPressed() {//Presionar 'ESC' para salir

    if( key != CODED ){
      if(key != 'd' & key != 'D' & key != 'f' & key != 'F'){
      textbox_says += key;
     }}
    
    if (keyPressed) {
    if (key == 'b' || key == 'B') {
    saveTable(table, "data/0707/Prueba_9.csv","csv");
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


public void tabla(){
  TableRow newRow = table.addRow();
  newRow.setInt("Muestra", table.lastRowIndex());
  newRow.setFloat("Temp", t);
  newRow.setFloat("Hum", h);
  newRow.setFloat("Hum2", h2);
  newRow.setFloat("Pres", p);
  newRow.setFloat("Den", d);
  newRow.setFloat("Vol", v);
  newRow.setFloat("DP", dp);
  newRow.setFloat("DP1", dp1);
  newRow.setFloat("Vel1", v1);
  newRow.setFloat("Vel2", v2);
  newRow.setFloat("Tiempo", tiempo);
  newRow.setFloat("PWM", pwm);
  newRow.setFloat("Paro", paro);
  newRow.setFloat("VelRef", VelRef);
  newRow.setFloat("Error", error);

  
  //println(table.getRowCount());  // Prints 3
  
  //int d = Integer.parseInt(algo[1]);
   
  }
// Graf.pde
// Representa puntos con los valores de Temperatura y Humedad
// recogidos de Arduino con DHT11.
// Jorge Muñoz, Manuel Hidalgo, Pablo Garcia, Jorge L. Loza
// Licencia: GPL v3
// Este es un programa ad-hoc para demostración.
// Clase incorporada a visual_dot.pde
// Modificalo a tu gusto.
// Tildes omitidas.
class Graf {

  int nX, nY, colF;
  int anteriorXT , anteriorXH;
  float anteriorYT, anteriorYH;
  //boolean primeroT, primeroH;
  Graf (int x, int y, int cF){
    nX = x;
    nY = y; 
    colF  = cF;
  }
  public void cuadricula1(){// Temperatura
    fill(0, 0, 0);
    text("Diferencia de Presion [Pa] Y PWM", (nX / 2) - 50, 70);
    stroke(150);   
    for (int  j = 60 ; j <= nX - 60; j = j + 20){
      line (j, 80, j, (nY / 2) - 20);      } // Vert
    for (int  j = 80 ; j <= (nY / 2) - 20; j = j + 20){
      line (60, j, nX - 60, j);} // Horiz
    int i = 0;
    for (int n = (nY / 2) - 20; n >= (nY / 2) - 220; n = n - 20){
      fill(0, 0, 0);
      text(i, 35, n + 1);
      i = i + 100;
      
    }
    int k=0;
    for (int n = (nY / 2) - 20; n >= (nY / 2) - 220; n = n - 20){
      fill(0, 0, 0);
      text(k, 650, n + 1);
      k = k + 20;
      
    }
  }
  
  public void cuadricula2(){// Humedad
    fill(0, 0, 0);
    text("Velocidad (m/s)", (nX / 2) - 60, (nY / 2) + 10);
    stroke(150);   
    for (int  j = 60 ; j <= nX - 60; j = j + 20){
      line (j, (nY / 2) + 20 , j, nY - 80);} // Vert
    for (int  j = (nY / 2) + 20 ; j <= nY - 80; j = j + 20){
      line (60, j, nX - 60, j);} // Horiz
    int i = 0;  
    for (int n = nY - 80; n >= nY - 280; n = n - 20){
      fill(0, 0, 0);
      text(i, 35, n + 5);
      i = i + 3;
    }
 
  }
  
  public void borra(){
    fill(colF); // Color del fondo
    noStroke();
    rectMode(CORNERS);
    rect(50 , 65, nX , nY - 30 ); 
  }
  
  public void puntosT(int x, float tem, boolean primeroT){
      
      float vT = map(tem, 0, 200, (nY / 2) - 20 , 80);
      ellipse(x, vT, 5, 5);
      if (primeroT == false){
        stroke(50);
        line(anteriorXT, anteriorYT, x, vT);
        
      
      }
      anteriorXT = x;
      anteriorYT = vT;
        
  }
public void puntosH(int x, float hum, boolean primeroH){
            
      //float vH = map(hum, 0, 1023, nY - 80, (nY / 2) + 20);
      float vH = map(hum, 0, 1023, (nY / 2) - 20 , 80); 
      ellipse(x, vH, 5, 5);
      if (primeroH == false){
        stroke(50);
        //line(anteriorXH, anteriorYH, x, vH);
        
      
      }
        anteriorXH = x;
        anteriorYH = vH;   
  }
  
  public void puntosv1(int x, float hum){
            
      //float vH = map(hum, 0, 1023, nY - 80, (nY / 2) + 20);
      float vH = map(hum, 0, 30, nY - 80, (nY / 2) + 20); 
      ellipse(x, vH, 5, 5);
      //if (primeroH == false){
        stroke(50);
        //line(anteriorXH, anteriorYH, x, vH);
        
      
      //}
        anteriorXH = x;
        anteriorYH = vH;   
  }

}
public void Mostrar(){
    //background(200, 200, 0);
    //fill (255,255,155);
    //rect(270,10,40,40);
    fill (255,0,0);
    text(pwm, 270, 20);
    fill (255,0,0);
    text(paro, 140, 60);
    fill (255,0,0);
    text(v2, 580, 20);
    fill (255,0,0);
    text(dp1, 400, 20);
    fill (255,0,0);
    text(tiempo/1000, 400, 580);
    fill (255,0,0);
    text(VelRef, 580, 40);
    fill (255,0,0);
    text(error, 580, 60);
    text(textbox_says, 150, 580);
}
public void Main(){

  String inString = puertoArduino.readStringUntil('\n'); 
  
  if (millis()>2200){
  if (inString != null){
      
      algo = PApplet.parseFloat(split(inString,';'));
      t=algo[0];
      h=algo[1];
      h2=algo[2];
      
      p=algo[3];
      d=algo[4];
      
      v=algo[5];
      dp=algo[6];
      dp1=algo[7];
      
      v1=algo[8];
      v2=algo[9];
      
      tiempo=algo[10];
      pwm=algo[11];
      paro=algo[12];
      VelRef=algo[13];
      error=algo[14];
      
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
      rect(270,20,330,45);//Borra lectura anterior 
      rect(400,560,460,590);//Borra lectura anterior 
      rect(580,20,670,45);//Borra lectura anterior 
      rect(140,45,180,70);//Borra lectura anterior 
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
       rect(270,5,330,25);//Borra lectura anterior
       rect(400,5,460,25);//Borra lectura anterior
       rect(580,5,670,25);//Borra lectura anterior
       rect(580,45,670,70);//Borra lectura anterior
       rect(130,560,190,610);//Borra lectura anterior
       //t = float(inString);
       
       datos.println(t);
       flagTemp = false;
       fill (255,0,0);
       text(t, 140, 20);
       //println("Diferencia de Presion (PA) : ", dp);
      
       //if (dp >= 0.0 && dp <= 1023){
         if (dp <= 1023){
          
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
        Mostrar(); 
  
  
}}
  public void settings() {  size(700, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "Grafico_Tunel" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
