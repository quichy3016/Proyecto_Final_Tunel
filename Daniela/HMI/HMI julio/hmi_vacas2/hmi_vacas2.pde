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


String textV, textF;// ingresa numero
String text2;// puerto com
Float textVV, textFF;
int textVVV, textFFF;
int unicavez;
boolean unicavez2 = false;
int variablecontrol1;
long tiempo1,tiempo2;
float tiempo3;
// interface stuff
ControlP5 cp5;

// Settings for the plotter are saved in this file
JSONObject plotterConfigJSON;

Graph LineGraph = new Graph(70,  115, 500, 400, color(20, 20, 200));
float[][] lineGraphValues = new float[6][100];
float[] lineGraphSampleNumbers = new float[100];
color[] graphColors = new color[6];

String topSketchPath = "";

Serial Arduino;
String puerta;
List l; //serial
int baudrate = 115200; //serial

float[] algo;
Table table;
String val,val1;
byte[] inBuffer = new byte[500]; // holds serial message

String myString = "";
//String inString="";
float tiempo,t,h,p,d,dp,VelRef,v1,pwm,controlSINO, error, Ev, ErrorVariador;
//boolean VERSERIE = false;

boolean ONOFF = false;
boolean Corre = false;
boolean Parada = true;
boolean ERROR = true;

boolean ControlONOFFnueva;
//boolean ControlTodoall;
Textlabel TL1,TL2,TL3,TL4,TL5,TL6,TL7,TL77,TL8,TL9,TL99,TL10,TL11,TL12,TL13,TL14,TL15,TL16,TL17, Tx3, Tx4,TL144,TL155,TL166,TL177, TL18, TL19, TL20;
Textfield TF1,TF11, TF2,TF3,TF4,TF5,TF6,TF7,TF8;
Button TB2, TB22, TB3,TB4,TB5,TB10, TB11;
Toggle TB6,TB7,TB8,TB9;
//String motorEstado="";

ScrollableList SL;   
Icon ser, serono, TODOonoff, TB1, TB12;
int colorONOFF;
boolean Run = false;
boolean Stop = true;
boolean DD4 = false;
boolean DD5 = false;
boolean DD6 = false;
boolean reinicioreset = false;
boolean HabilitacionV;
int contgraf=0;
int a = 0;




//envío de datos a Arduino
String Dato0 = "0",Dato1 = "0", Dato2 = "0", Dato3 = "0", Dato4 = "0", Dato5 = "0", DatosWrite;



void setup() {
    
    //background(0);
    background(248,240,248);  //REFRESCOPANTALLA  // Configura color fondo
    
    surface.setTitle("Automatización Túnel UNPSJB");
    size(1000,650);           // Configura resolucion interfaz
    ControlONOFFnueva = false;
    // ControlTodoall = false;
    unicavez = 0;
    variablecontrol1 = 0;
    println(unicavez);
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
    // TODOonoff = cp5.addIcon("ControlTodo",10).setPosition(440,30).setSize(60, 30).setRoundedCorners(20).setFont(createFont("fontawesome-webfont.ttf", 40)).setFontIcons(#00f205,#00f204).setSwitch(true).setColorBackground(color(255,100)).hideBackground();
    
    TL1 = cp5.addTextlabel("label12").setText("Puerto:").setPosition(620,35).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TL2 = cp5.addTextlabel("label2").setText("Parametros actuales").setPosition(690,155).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TL3 = cp5.addTextlabel("label3").setText("T:           °C").setPosition(602,205).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TL4 = cp5.addTextlabel("label4").setText("H:          %").setPosition(743,205).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TL5 = cp5.addTextlabel("label5").setText("P:           hPa").setPosition(862,205).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TL6 = cp5.addTextlabel("label6").setText("v:           m/s").setPosition(642,245).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TL7 = cp5.addTextlabel("label7").setText("v(ref):           m/s").setPosition(790,245).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TL77 = cp5.addTextlabel("label77").setText("f(aprox):           Hz").setPosition(770,245).setColorValue(#002D5A).setFont(createFont("Arial",20));
    
    TL8 = cp5.addTextlabel("label8").setText("Control").setPosition(610,460).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TB1 = cp5.addIcon("ControlONOFF",10).setPosition(705,465).setSize(25, 15).setRoundedCorners(20).setFont(createFont("fontawesome-webfont.ttf", 40)).setFontIcons(#00f205,#00f204).setSwitch(true).setColorBackground(color(255,100)).hideBackground();
    
    TL9 = cp5.addTextlabel("label10").setText("Velocidad: ").setPosition(640,495).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TF1 = cp5.addTextfield("Veloc").setPosition(744,495).setSize(100, 30).setAutoClear(false).setColor(cc).setFont(font).setLabel("");
    TB2 = cp5.addButton("EnviarVel").setPosition(744 + 100,495).setSize(85, 30).setLabel("Enviar").setFont(font2); //.toInt ver
    
    
    TL99 = cp5.addTextlabel("label110").setText("Frecuencia: ").setPosition(635,495).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TF11 = cp5.addTextfield("Frec").setPosition(744,495).setSize(100, 30).setAutoClear(false).setColor(cc).setFont(font).setLabel("");
    TB22 = cp5.addButton("EnviarFrec").setPosition(744 + 100,495).setSize(85, 30).setLabel("Enviar").setFont(font2); //.toInt ver
    
    TL10 = cp5.addTextlabel("label9").setText("Guardado").setPosition(730,560).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TL11 = cp5.addTextlabel("label11").setText("Archivo: ").setPosition(640,590).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TF2 = cp5.addTextfield("Nombre archivo").setPosition(720,590).setSize(160, 30).setAutoClear(false).setColor(cc).setFont(font).setLabel("");
    TB3 = cp5.addButton("Guardar").setPosition(720 + 160,590).setSize(85, 30).setFont(font2); 
    
    TB4 = cp5.addButton("Run").setPosition(660,310).setSize(85, 85).setLabel("RUN").setFont(font2).setColorActive(#009900);
    TB5 = cp5.addButton("Stop").setPosition(773,310).setSize(85, 85).setLabel("STOP").setFont(font2).setColorActive(#990000);
    
    TB10 = cp5.addButton("reset").setPosition(910,100).setSize(60, 15).setLabel("RESET").setFont(createFont("Arial",14)).setColorActive(#990000);
    TB11 = cp5.addButton("fallaext").setPosition(910,120).setSize(60, 15).setLabel("STOP EMERGENCIA").setFont(createFont("Arial",14)).setColorActive(#990000);
    
    TL18 = cp5.addTextlabel("valiTL18").setText("ingrese un numero valido").setPosition(725,525).setColorValue(#770000).setFont(createFont("Arial",15));
    
    TB12 = cp5.addIcon("Habilitacion",10).setPosition(900,400).setSize(25, 15).setRoundedCorners(20).setFont(createFont("fontawesome-webfont.ttf", 40)).setFontIcons(#00f205,#00f204).setSwitch(true).setColorBackground(color(255,100)).hideBackground();
    TL19 = cp5.addTextlabel("Habili").setText("Ai1").setPosition(900,370).setColorValue(#002D5A).setFont(createFont("Arial",20));
    TL20 = cp5.addTextlabel("estado de motor").setText("").setPosition(680,410).setColorValue(#002D5A).setFont(createFont("Arial",20));
    
    
    
    table = new Table();
    table.addColumn("Muestra");
    table.addColumn("Tiempo");
    table.addColumn("Temp");
    table.addColumn("Hum");
    table.addColumn("Pres");
    table.addColumn("Den");
    table.addColumn("DP");
    table.addColumn("Ref");
    table.addColumn("VelFrec");
    table.addColumn("PWM");
    table.addColumn("Control");
    table.addColumn("Error");
    table.addColumn("ESTADOvariador"); //motor funcionando
    table.addColumn("ERRORvariador");
    table.addColumn("TiempoRel");
    
    grafica();
    
    
}


void draw() {
    // if (contgraf==2){
    graf_draw();
// contgraf=0;
//     }
    // contgraf++;
    
    fill(255);//cuadros con fondo
    stroke(#5DD2EA);
    rect(590,35,400,110);//serial
    if (serono.isOn() == true) {
        
        fill(colorONOFF);//cuadros con fondo
        noStroke();
        rect(660,400,200,50);//P
        
        fill(255);//cuadros con fondo
        stroke(#5DD2EA);
        rect(590,155,400,145);//Parametros actuales
        rect(626,206,53,30);//T
        rect(767,206,53,30);//H
        rect(885,206,53,30);//P
        rect(668,246,53,30);//v
        rect(850,246,53,30);//vref
        rect(870,370,80,60);//habilita
        rect(590,455,400,90);//control
        rect(590,560,400,80);//guardado
        TL2.setVisible(true);
        TL3.setVisible(true);        TL4.setVisible(true);
        TL5.setVisible(true);        TL6.setVisible(true);
        TL77.setVisible(true);       
        TL10.setVisible(true);        TL11.setVisible(true);
        TF2.setVisible(true);        TB3.setVisible(true);
        TB4.setVisible(true);        TB5.setVisible(true);
        TB4.setVisible(true);
        TB5.setVisible(true);     
        TL12.setVisible(true);        TL13.setVisible(true);
        TL14.setVisible(true);        TL15.setVisible(true);
        TL16.setVisible(true);        TL17.setVisible(true);
        TL144.setVisible(true);        TL155.setVisible(true);
        TL166.setVisible(true);        TL177.setVisible(true);
        TF3.setVisible(true);        TF4.setVisible(true);
        TF5.setVisible(true);        TF6.setVisible(true);
        TF7.setVisible(true);        TF8.setVisible(true);
        TB6.setVisible(true);        TB7.setVisible(true);
        TB8.setVisible(true);        TB9.setVisible(true);
        Tx3.setVisible(true);        Tx4.setVisible(true);
        TB12.setVisible(true);        TL19.setVisible(true);
        textSize(15);
        fill(255,0,0);
        text(nf(error,0,2), 669,226);///////////////////
        text(nf(h,0,2), 813,226);
        text(nf(p,0, -1), 935,226);
        text(nf(v1,0,1), 715,266);
        
          textSize(15);
            fill(0,255,0);
            text(nf(VelRef,0,2), 900,266);
        
        
       if(TB12.isOn()==true){ //ai1
        if (TB1.isOn() ==  true) {
            TL9.setVisible(true);        TF1.setVisible(true);
            TB2.setVisible(true);        TL7.setVisible(true);
            TL99.setVisible(false);        TF11.setVisible(false);
            TB22.setVisible(false);        TL77.setVisible(false);            
            textSize(15);
            fill(255,0,0);
            text(nf(VelRef,0,2), 900,266);
        }
        else{
            textSize(15);
            fill(0,255,0);
            text(nf(VelRef,0,2), 900,266);
            TL9.setVisible(false);        TF1.setVisible(false);
            TB2.setVisible(false);        TL7.setVisible(false);
            TL99.setVisible(true);        TF11.setVisible(true);
            TB22.setVisible(true);        TL77.setVisible(true);
        }
       }    
        else{

           if (TB1.isOn() ==  true) {
            TL9.setVisible(false);        TF1.setVisible(false);
            TB2.setVisible(false);        TL7.setVisible(true);
            TL99.setVisible(false);        TF11.setVisible(false);
            TB22.setVisible(false);        TL77.setVisible(false);            
            textSize(15);
            fill(255,0,0);
            text(nf(VelRef,0,2), 900,266);
        }
        else{
            textSize(15);
            fill(0,255,0);
            text(nf(VelRef,0,2), 900,266);
            TL9.setVisible(false);        TF1.setVisible(false);
            TB2.setVisible(false);        TL7.setVisible(false);
            TL99.setVisible(false);        TF11.setVisible(false);
            TB22.setVisible(false);        TL77.setVisible(true);
        }
           
           
           
           
           
           
            }
        if (unicavez2 ==  false) {
            
            
            unicavez2 = true;
        }
        
        
        
        if (int(Ev) ==  1) {
            colorONOFF = #AA0000;
            TL20.setVisible(true);
            TL20.setText("Motor en Marcha").setColorValue(#FFFFFF);
            print(" en marcha ");//agregar el cartel y refrescar 
            
        }
        else{
            colorONOFF = #00AA00;
            TL20.setVisible(true);
            TL20.setText("  Motor Apagado");
            
        } 
        
        if (int(ErrorVariador) ==  1) {   //agregar la variable de reset del boton para que desaparezca el triangulo y boton
            TB10.setVisible(true);
            fill(255,0,0);
            noStroke();
            triangle(850, 90, 900, 90, 875, 135);
            DD4 = TB10.isPressed();
        }
        else{
            TB10.setVisible(false);
            fill(255);
            noStroke();
            triangle(850, 90, 900, 90, 875, 135);
            DD4 = DD4;
        }
        
         if ((millis() - tiempo1)>1000) {
             verificacion();    
         }
        // if (unicavez==0){
        //     verificacion();
        //HOLAAAAA
        // }
        if (TB10.isOn() ==  true) {
            if ((millis() - tiempo2)>3000) {
                
                DD4 = false;
                Dato4 = "0";
                DatosW();
                reinicioreset = false;
                println("HOLAAAAAAAAAAAAAAAAAAAAAAAA");
                TB10.setOff();
            }
            
            
        }
        
        }
    
    else{
        
        fill(255);//cuadros con fondo
        noStroke();
        rect(0,40,590,600);
        //TL1.setVisible(false);     
        TL2.setVisible(false);
        TL3.setVisible(false);        TL4.setVisible(false);
        TL5.setVisible(false);        TL6.setVisible(false);
        TL7.setVisible(false);       TL9.setVisible(false);
        TF1.setVisible(false);        TB2.setVisible(false);
        TL77.setVisible(false);       TL99.setVisible(false);
        TF11.setVisible(false);        TB22.setVisible(false);
        TL8.setVisible(false);        TL10.setVisible(false);
        TL11.setVisible(false);        TF2.setVisible(false);
        TB3.setVisible(false);        TB4.setVisible(false);
        TB5.setVisible(false);        TB1.setVisible(false);
        TL12.setVisible(false);      TL20.setVisible(false);
        TL13.setVisible(false);        TL14.setVisible(false);
        TL15.setVisible(false);        TL16.setVisible(false);
        TL17.setVisible(false);        TL144.setVisible(false);
        TL155.setVisible(false);        TL166.setVisible(false);
        TL177.setVisible(false);        TF3.setVisible(false);
        TF4.setVisible(false);        TF5.setVisible(false);
        TF6.setVisible(false);        TF7.setVisible(false);
        TF8.setVisible(false);        TB6.setVisible(false);
        TB7.setVisible(false);        TB8.setVisible(false);
        TB9.setVisible(false);        Tx3.setVisible(false);
        Tx4.setVisible(false);        TB10.setVisible(false);
        TL18.setVisible(false);
        TB12.setVisible(false);        TL19.setVisible(false);
    }
    
    
    
    
    
}


void DatosW() {
    DatosWrite = (Dato0 + "," + Dato1 + "," + Dato2 + "," + Dato3 + "," + Dato4 + "," + Dato5 + "," + '\n');
    Arduino.write(DatosWrite);
}

void verificacion() {
    if (unicavez == 0) {
        variablecontrol1 = int(controlSINO);
        println("HOLAAAAA" + variablecontrol1);
        tiempo3 = tiempo;
        if (variablecontrol1 == 1) {
            //a = a + 1;
            
            cp5.get(Textfield.class, "Veloc").setText(str(VelRef));
            EnviarVel();
            TB12.setOn();
            TB1.setOn();
            println("seton");
            } else {
            //a = a - 1;
            TB12.setOff();
            TB1.setOff();
            }
        unicavez =  1;
        } 
     }
    

    void serialEvent(Serial Arduino){
        try {
            val = Arduino.readStringUntil('\n'); //The newline separator separates each Arduino loop and so collection of data. 
            //println(val);
         //   Arduino.readBytesUntil('\n', inBuffer);
            //println(inBuffer);
            if (val!= null) { //Verifies reading
                val1=val;
                val = trim(val); //gets rid of any whitespace or Unicode nonbreakable space
                float algo[] = float(split(val, ';')); //parses the packet from Arduino and places the float values into the sensorVals array.
                
                tiempo = algo[4];
                t = algo[5];
                h = algo[6];
                p = algo[7] / 100;
                d = algo[8];
                dp = algo[2];
                VelRef = algo[1];
                v1 = algo[0];
                pwm = algo[3];
                controlSINO = algo[9];
                error = algo[10];
                Ev = algo[11];//estado del motor
                ErrorVariador = algo[12]; //indicacion de error en variador
                
                
                TableRow newRow = table.addRow(); //adds a row for new reading
                newRow.setInt("Muestra", table.lastRowIndex());
                newRow.setFloat("Tiempo", tiempo); //0
                newRow.setFloat("Temp", t); //1
                newRow.setFloat("Hum", h);//2
                newRow.setFloat("Pres", p);//3
                newRow.setFloat("Den", d);//4
                newRow.setFloat("DP", dp);//5
                newRow.setFloat("Ref", VelRef);//6
                newRow.setFloat("VelFrec", v1);//7
                newRow.setFloat("PWM", pwm);//8
                newRow.setFloat("Control", controlSINO);//9
                newRow.setFloat("Error", error);//10
                newRow.setFloat("ESTADOvariador", Ev);//11 //motor funcionando
                newRow.setFloat("ERRORvariador", ErrorVariador);//12
                newRow.setFloat("TiempoRel",tiempo - tiempo3);
                
            }
        }
        catch(RuntimeException e) {//catches errors
        }
    }
