// BIBLIOTECAS
import controlP5.*;
import grafica.*;
import processing.serial.*;
import java.util.Random;
import java.util.*;

import java.awt.Frame;//gui
import java.awt.BorderLayout;//gui


CColor cc = new CColor((#5DD2EA),color(248,240,248),(#002D5A),color(248,240,248),color(0,0,255));
CColor ccONOFF = new CColor((#5DD2EA),(#009900),(#000000),(#0000ff),(#000000));
//CColor cc=new CColor(color(250,0,0),color(0,250,0),color(0,0,0),color(120,17,90),color(0,0,255));
//pasas mouse     color fijo,       click,               letra,       int cvl) 


 String text;// ingresa numero
 String text2;// puerto com

////////////////////inicio GUI
/* SETTINGS BEGIN */
// Serial port to connect to
//String serialPortName = "COM4";
// If you want to debug the plotter without using a real serial port set this to true
boolean mockupSerial = false;   //para que tome los valores de arduino tiene q estar en falso
/* SETTINGS END */


// interface stuff
ControlP5 cp5;

// Settings for the plotter are saved in this file
JSONObject plotterConfigJSON;

// plots
Graph LineGraph = new Graph(70,  115, 500, 400, color(20, 20, 200));
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
float[] algo;
Table table;
String val;


String myString = "";
String inString="";
float t,h,p,d,v,dp,dp1,dp2,dp3,v1,v2,v3,v4,tiempo,pwm,paro,h2,VelRef,error;
boolean VERSERIE = false;


// VARIABLES
boolean ONOFF = false;
boolean Corre = false;
boolean Parada = true;

boolean ControlONOFF = false;
boolean ControlTodo = false;
Textlabel TL1,TL2,TL3,TL4,TL5,TL6,TL7,TL77,TL8,TL9,TL10,TL11,TL12,TL13,TL14,TL15,TL16,TL17, Tx3, Tx4;
Textfield TF1,TF2,TF3,TF4,TF5,TF6,TF7,TF8;
Button TB2, TB3,TB4,TB5;
Toggle TB1,TB6,TB7,TB8,TB9;
ScrollableList SL;   
Icon ser, serono;


void setup() {
    
    //background(0);
    background(248,240,248);  //REFRESCOPANTALLA  // Configura color fondo
    
    surface.setTitle("Automatización Túnel UNPSJB");
    size(1000,650);           // Configura resolucion interfaz
    
    ControlONOFF = false;
    ControlTodo = false;
    cp5 = new ControlP5(this);
    PFont font = createFont("arial",20);
    PFont font2 = createFont("arial",14);
    PFont font3 = createFont("arial",14);  
    //Serial
    l = Arrays.asList(Serial.list());
    SL = cp5.addScrollableList("dropdown")
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
    
    
    ser = cp5.addIcon("actualizar",10)
       .setPosition(850,30)
       .setSize(50,50)
       .setRoundedCorners(20)
       .setFont(createFont("fontawesome-webfont.ttf", 40))
       .setFontIcon(#00f021)
       .setColorBackground(color(255,100))
       .hideBackground()
       ;
    
    serono = cp5.addIcon("seronoser",10)
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
    
//Elementos texto, botones, etc
    cp5.addButton("buttonA").setPosition(10,10).setImage(loadImage("unpsjb.png"));
    
    cp5.addTextlabel("label1").setText("Automatización túnel de viento").setPosition(70,30).setColorValue(#03045e).setFont(createFont("Arial",25));
    cp5.addToggle("ControlTodo").setLabel("").setPosition(440,30).setSize(60, 30).setColorActive(#38b000);
    
    TL1 = cp5.addTextlabel("label12").setText("Puerto:").setPosition(620,35).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TL2 = cp5.addTextlabel("label2").setText("Parametros actuales").setPosition(690,155).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TL3 = cp5.addTextlabel("label3").setText("T:           °C").setPosition(602,205).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TL4 = cp5.addTextlabel("label4").setText("H:          %").setPosition(743,205).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TL5 = cp5.addTextlabel("label5").setText("P:           hPa").setPosition(862,205).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TL6 = cp5.addTextlabel("label6").setText("v:           m/s").setPosition(642,245).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TL7 = cp5.addTextlabel("label7").setText("v(ref):           m/s").setPosition(790,245).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TL77= cp5.addTextlabel("label77").setText("f(aporx):           Hz").setPosition(770,245).setColorValue(#002D5A).setFont(createFont("Arial",20));

    TL8 = cp5.addTextlabel("label8").setText("Control").setPosition(730,460).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TB1 = cp5.addToggle("ControlONOFF").setLabel("").setPosition(825,465).setSize(25, 15).setColorActive(#38b000);
    
    TL9 = cp5.addTextlabel("label10").setText("Velocidad: ").setPosition(640,495).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TF1 = cp5.addTextfield("Veloc").setPosition(744,495).setSize(100, 30).setAutoClear(false).setColor(cc).setFont(font).setLabel("");
    TB2 = cp5.addButton("Enviar").setPosition(744 + 100,495).setSize(85, 30).setFont(font2); //.toInt ver
    
    TL10 = cp5.addTextlabel("label9").setText("Guardado").setPosition(730,560).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TL11 = cp5.addTextlabel("label11").setText("Archivo: ").setPosition(640,590).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TF2 = cp5.addTextfield("Nombre archivo").setPosition(720,590).setSize(160, 30).setAutoClear(false).setColor(cc).setFont(font).setLabel("");
    TB3 = cp5.addButton("Guardar").setPosition(720 + 160,590).setSize(85, 30).setFont(font2); 
    
    TB4 = cp5.addButton("Run").setPosition(690,310).setSize(85, 85).setLabel("RUN").setFont(font2).setColor(ccONOFF);
    TB5 = cp5.addButton("Stop").setPosition(790,310).setSize(85, 85).setLabel("STOP").setFont(font2).setColorActive(#990000);
    





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
    
    if (ControlTodo == true) {
        fill(255);//cuadros con fondo
        stroke(#5DD2EA);
        rect(590,155,400,145);//Parametros actuales
        rect(626,206,53,30);//T
        rect(767,206,53,30);//H
        rect(885,206,53,30);//P
        rect(668,246,53,30);//v
        rect(850,246,53,30);//vref
        rect(590,35,400,110);//serial
        rect(590,455,400,90);//control
        rect(590,560,400,80);//guardado
        TL1.setVisible(true);
        TL2.setVisible(true);
        TL3.setVisible(true);
        TL4.setVisible(true);
        TL5.setVisible(true);
        TL6.setVisible(true);
        TL77.setVisible(true);
        TL8.setVisible(true);
        TL10.setVisible(true);
        TL11.setVisible(true);
        TF2.setVisible(true);
        TB3.setVisible(true);
        TB4.setVisible(true);
        TB5.setVisible(true);
        TB1.setVisible(true);
        TB4.setVisible(true);
        TB5.setVisible(true);
        SL.setVisible(true);
        ser.setVisible(true);
        serono.setVisible(true);
        TL12.setVisible(true);
        TL13.setVisible(true);
        TL14.setVisible(true);
        TL15.setVisible(true);
        TL16.setVisible(true);
        TL17.setVisible(true);
        TF3.setVisible(true);
        TF4.setVisible(true);
        TF5.setVisible(true);
        TF6.setVisible(true);
        TF7.setVisible(true);
        TF8.setVisible(true);
        TB6.setVisible(true);
        TB7.setVisible(true);
        TB8.setVisible(true);
        TB9.setVisible(true);
        Tx3.setVisible(true);
        Tx4.setVisible(true);
         textSize(15);
        fill(255,0,0);
        text(nf(t,0,2), 669,226);
        text(nf(h,0,2), 813,226);
        text(nf(h2,0,2), 930,226);
        text(nf(p,0,1), 715,266);
        // text(nf(d,0,2), 880,266);
        
        
    }
    
    else{
        fill(255);//cuadros con fondo
        noStroke();
        rect(0,40,590,600);
        TL1.setVisible(false);
        TL2.setVisible(false);
        TL3.setVisible(false);
        TL4.setVisible(false);
        TL5.setVisible(false);
        TL6.setVisible(false);
        TL7.setVisible(false);
        TL77.setVisible(false);
        TL8.setVisible(false);
        TL10.setVisible(false);
        TL11.setVisible(false);
        TF2.setVisible(false);
        TB3.setVisible(false);
        TB4.setVisible(false);
        TB5.setVisible(false);
        TB1.setVisible(false);
        SL.setVisible(false);
        ser.setVisible(false);
        serono.setVisible(false);
        TL12.setVisible(false);
        TL13.setVisible(false);
        TL14.setVisible(false);
        TL15.setVisible(false);
        TL16.setVisible(false);
        TL17.setVisible(false);
        TF3.setVisible(false);
        TF4.setVisible(false);
        TF5.setVisible(false);
        TF6.setVisible(false);
        TF7.setVisible(false);
        TF8.setVisible(false);
        TB6.setVisible(false);
        TB7.setVisible(false);
        TB8.setVisible(false);
        TB9.setVisible(false);
        Tx3.setVisible(false);
        Tx4.setVisible(false);
    }
    
    if (ControlTodo== true && ControlONOFF ==  true) {
        TL9.setVisible(true);
        TF1.setVisible(true);
        TB2.setVisible(true);
        TL7.setVisible(true);
        TL77.setVisible(false);
            textSize(15);
            fill(255,0,0);
            text(nf(h2,0,2), 890,266);

        
        
    } else {
        TL9.setVisible(false);
        TF1.setVisible(false);
        TB2.setVisible(false);
        TL7.setVisible(false);
        if (ControlTodo== true && ControlONOFF ==  false) {
            textSize(15);
            fill(0,0,255);
            text(nf(d,0,2), 890,266);
        }
        }
    
    
     if(VERSERIE ==  true) {
try {
  val = Arduino.readStringUntil('\n'); //The newline separator separates each Arduino loop and so collection of data. 
  if (val!= null) { //Verifies reading
    val = trim(val); //gets rid of any whitespace or Unicode nonbreakable space
    println("tomando datos"); //Shows received data
    float algo[] = float(split(val, ';')); //parses the packet from Arduino and places the float values into the sensorVals array.
    
    t=algo[0];
    h = algo[1];
    h2 = algo[2];
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

     TableRow newRow = table.addRow(); //adds a row for new reading
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
    }
  }
  catch(RuntimeException e) {//catches errors
//     e.printStackTrace();
   }


}

}


///////SERIAL
void dropdown(int n) {
puerta = cp5.get(ScrollableList.class, "dropdown").getItem(n).get("name").toString();
println(puerta);
}

void actualizar() {
cp5.get(ScrollableList.class, "dropdown").clear();
l = Arrays.asList(Serial.list());
cp5.get(ScrollableList.class, "dropdown").setItems(l);
cp5.get(ScrollableList.class, "dropdown").removeItem("COM1");
}

void seronoser(boolean estado) {
// falta agregar checkeo de eleccion del puerto
if (estado ==  true) {
println("abro puerto" + puerta);
Arduino = new Serial(this,puerta,baudrate);
VERSERIE = true;

}
else{
println("cierro puerto " + puerta);
actualizar();
Arduino.clear();
Arduino.stop();
VERSERIE = false;
}
}
///////FINSERIAL


void Enviar() {
println();
print("this is the text you typed :");
text = cp5.get(Textfield.class, "Veloc").getText();

cp5.get(Textfield.class, "Veloc").clear();
}

void Guardar() {
println();
print("El nombre del archivo es:");
text2 = cp5.get(Textfield.class, "Nombre archivo").getText();
print(text2);
saveTable(table, "data/" + text2 + ".csv","csv");
cp5.get(Textfield.class, "Nombre archivo").clear();
table.clearRows();

}
