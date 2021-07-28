// BIBLIOTECAS
import controlP5.*;
import grafica.*;
import processing.serial.*;
import java.util.Random;
import java.util.*;

import java.awt.Frame;//gui
import java.awt.BorderLayout;//gui



// VARIABLES
boolean ONOFF = false;

CColor cc=new CColor((#5DD2EA),color(248,240,248),(#002D5A),color(248,240,248),color(0,0,255));
  //CColor cc=new CColor(color(250,0,0),color(0,250,0),color(0,0,0),color(120,17,90),color(0,0,255));
                 //pasas mouse     color fijo,       click,               letra,       int cvl) 


// int ancho=0;
// int alto=0;

String text;// ingresa numero
String text2;// puerto com

////////////////////inicio GUI
/* SETTINGS BEGIN */
// Serial port to connect to
//String serialPortName = "COM4";
// If you want to debug the plotter without using a real serial port set this to true
boolean mockupSerial = false;   //para que tome los valores de arduino tiene q estar en falso
/* SETTINGS END */

//Serial serialPort; // Serial port object

// interface stuff
ControlP5 cp5;

// Settings for the plotter are saved in this file
JSONObject plotterConfigJSON;

// plots
Graph LineGraph = new Graph(70,  115, 500, 400, color (20, 20, 200));
float[][] lineGraphValues = new float[6][100];
float[] lineGraphSampleNumbers = new float[100];
color[] graphColors = new color[6];

// helper for saving the executing path
String topSketchPath = "";
////////////////////FIN GUI

/*
Instancias de los objetos de las bibliotecas
*/

Serial Arduino;
String puerta;
List l; //serial
int baudrate = 115200; //serial


//info Serial
float [] algo;
float t,h,p,d,v,dp,dp1,dp2,dp3,v1,v2,v3,v4,tiempo,pwm,paro,h2,VelRef,error;
boolean VERSERIE=false;
Table table;




void setup() {
   //background(0);
  background(248,240,248);  //REFRESCOPANTALLA  // Configura color fondo
  
  surface.setTitle("Automatización Túnel UNPSJB");
    size(1000,650);           // Configura resolucion interfaz
    
   cp5 = new ControlP5(this);
  PFont font = createFont("arial",20);
  PFont font2 = createFont("arial",14);
  PFont font3 = createFont("arial",14);  
    //Serial
    l = Arrays.asList(Serial.list());
  cp5.addScrollableList("dropdown")
     .setPosition(690,40)
     .setSize(150, 120)
     .setBarHeight(20)
     .setFont(font3)
     .setItemHeight(20)
     .addItems(l)
     .setOpen(false)
     .setLabel("Elija puerto...")
     ;  
    cp5.get(ScrollableList.class, "dropdown").removeItem("COM1");
    
    cp5.addIcon("actualizar",10)
    .setPosition(850,30)
    .setSize(50,50)
    .setRoundedCorners(20)
    .setFont(createFont("fontawesome-webfont.ttf", 40))
    .setFontIcon(#00f021)
    .setColorBackground(color(255,100))
    .hideBackground()
    ;
    
  cp5.addIcon("seronoser",10)
    .setPosition(900,30)
    .setSize(70,50)
    .setRoundedCorners(20)
    .setFont(createFont("fontawesome-webfont.ttf", 40))
    .setFontIcons(#00f205,#00f204)
    .setSwitch(true)
    .setColorBackground(color(255,100))
    .hideBackground()
    ;
    ///fin serial
    
  
  cp5.addButton("buttonA").setPosition(10,10).setImage(loadImage("unpsjb.png"));
  
  // alto=height;
  // ancho=width;
  
  cp5.addTextlabel("label1").setText("Automatización túnel de viento").setPosition(70,30).setColorValue(#03045e).setFont(createFont("Arial",25));
  cp5.addTextlabel("label12").setText("Puerto:").setPosition(620,35).setColorValue(#002D5A).setFont(createFont("Arial",20));
  cp5.addTextlabel("label2").setText("Parametros actuales").setPosition(690,155).setColorValue(#002D5A).setFont(createFont("Arial",20));
  cp5.addTextlabel("label3").setText("T:           °C").setPosition(602,205).setColorValue(#002D5A).setFont(createFont("Arial",20));
  cp5.addTextlabel("label4").setText("H:          %").setPosition(743,205).setColorValue(#002D5A).setFont(createFont("Arial",20));
  cp5.addTextlabel("label5").setText("P:           hPa").setPosition(862,205).setColorValue(#002D5A).setFont(createFont("Arial",20));
  cp5.addTextlabel("label6").setText("v:           m/s").setPosition(642,245).setColorValue(#002D5A).setFont(createFont("Arial",20));
  cp5.addTextlabel("label7").setText("v(ref):           m/s").setPosition(780,245).setColorValue(#002D5A).setFont(createFont("Arial",20));
  cp5.addTextlabel("label8").setText("Control").setPosition(730,315).setColorValue(#002D5A).setFont(createFont("Arial",20));
  cp5.addTextlabel("label9").setText("Guardado").setPosition(730,560).setColorValue(#002D5A).setFont(createFont("Arial",20));
   
  cp5.addTextlabel("label10").setText("Velocidad: ").setPosition(640,350).setColorValue(#002D5A).setFont(createFont("Arial",20));
  cp5.addTextfield("Veloc").setPosition(744,350).setSize(100, 30).setAutoClear(false).setColor(cc).setFont(font).setLabel("");
  cp5.addButton("Enviar").setPosition(744+100,350).setSize(85, 30).setFont(font2); //.toInt ver
  
 
  cp5.addTextlabel("label11").setText("Archivo: ").setPosition(640,590).setColorValue(#002D5A).setFont(createFont("Arial",20));
  cp5.addTextfield("Nombre archivo").setPosition(720,590).setSize(160, 30).setAutoClear(false).setColor(cc).setFont(font).setLabel("");
  cp5.addButton("Guardar").setPosition(720+160,590).setSize(85, 30).setFont(font2); 
    
  cp5.addButton("Run").setPosition(690,405).setSize(85, 85).setFont(font2);

  cp5.addButton("Stop").setPosition(790,405).setSize(85, 85).setFont(font2);

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

grafica();


}


void draw() {
  
  graf_draw();

  fill(255);//cuadros con fondo
  stroke(#5DD2EA);
  rect(590,155,400,145);//Parametros actuales
  rect(626,206,53,30);//T
  rect(767,206,53,30);//H
  rect(885,206,53,30);//P
  rect(662,246,53,30);//v
  rect(841,246,53,30);//vref
  rect(590,35,400,110);//serial

  
  rect(590,310,400,190);//control
  rect(590,560,400,80);//guardado

  if (VERSERIE ==true) {
    //print("HOLA");
    
      String inString = Arduino.readStringUntil('\n'); 
    
    if (millis()>2200){  //2200
    if (inString != null){
      
      algo = float(split(inString,';'));
      t=algo[0];
      println(t);
      h=algo[1];
      h2=algo[2];
      // p=algo[3];
      // d=algo[4];
      // v=algo[5];
      // dp=algo[6];
      // dp1=algo[7];
      // v1=algo[8];
      // v2=algo[9];
      // tiempo=algo[10];
      // pwm=algo[11];
      // paro=algo[12];
      // VelRef=algo[13];
      // error=algo[14];

      TableRow newRow = table.addRow();
        newRow.setInt("Muestra", table.lastRowIndex());
        newRow.setFloat("Temp", t);
        newRow.setFloat("Hum", h);
        newRow.setFloat("Hum2", h2);
        // newRow.setFloat("Pres", p);
        // newRow.setFloat("Den", d);
        // newRow.setFloat("Vol", v);
        // newRow.setFloat("DP", dp);
        // newRow.setFloat("DP1", dp1);
        // newRow.setFloat("Vel1", v1);
        // newRow.setFloat("Vel2", v2);
        // newRow.setFloat("Tiempo", tiempo);
        // newRow.setFloat("PWM", pwm);
        // newRow.setFloat("Paro", paro);
        // newRow.setFloat("VelRef", VelRef);
        // newRow.setFloat("Error", error);

    }
   textSize(15);
    fill(255,0,0);
    text(nf(t,0,2), 671,226);
    text(nf(h,0,2), 812,226);
    text(nf(h2,0,2), 930,226);

    //print(t + "-"); 

  }
  
  }
  
}

///////SERIAL
void dropdown(int n){
  puerta = cp5.get(ScrollableList.class, "dropdown").getItem(n).get("name").toString();
  println(puerta);
}

void actualizar(){
  cp5.get(ScrollableList.class, "dropdown").clear();
  l = Arrays.asList(Serial.list());
  cp5.get(ScrollableList.class, "dropdown").setItems(l);
  cp5.get(ScrollableList.class, "dropdown").removeItem("COM1");
}

void seronoser(boolean estado) {
  // falta agregar checkeo de eleccion del puerto
  if (estado==true){
    println("abro puerto "+puerta);
    Arduino = new Serial(this,puerta,baudrate);
    //Arduino.bufferUntil('\n');//'\n' 
    //https://stackoverflow.com/questions/59024009/processing-bufferuntil-method-only-works-with-n
    VERSERIE=true;
  
  }
  else{
    println("cierro puerto "+puerta);
    actualizar();
    Arduino.clear();
    Arduino.stop();
    VERSERIE=false;
  }
}
///////FINSERIAL


void Enviar() {
  println();
  print("this is the text you typed :");
  text=cp5.get(Textfield.class, "Veloc").getText();
  fill(3,4,94);
  text(text, 850,270);
  print(text);
    
  cp5.get(Textfield.class, "Veloc").clear() ;
}

void Guardar() {
  println();
  print("El nombre del archivo es:");
  text2=cp5.get(Textfield.class, "Nombre archivo").getText();
  print(text2);
  saveTable(table, "data/"+text2+".csv","csv");
  cp5.get(Textfield.class, "Nombre archivo").clear() ;
  
  }
