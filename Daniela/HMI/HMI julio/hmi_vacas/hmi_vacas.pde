// BIBLIOTECAS
import controlP5.*;
import grafica.*;
import processing.serial.*;
import java.util.Random;
import java.util.*;


// VARIABLES
boolean ONOFF = false;

CColor cc=new CColor((#5DD2EA),color(248,240,248),(#002D5A),color(248,240,248),color(0,0,255));
  //CColor cc=new CColor(color(250,0,0),color(0,250,0),color(0,0,0),color(120,17,90),color(0,0,255));
                 //pasas mouse     color fijo,       click,               letra,       int cvl) 


int ancho=0;
int alto=0;

String text;// ingresa numero
String text2;// puerto com

/*
Instancias de los objetos de las bibliotecas
*/
GPlot plot1;
GPlot  plot2;
ControlP5 cp5;
Serial Arduino;
String puerta;
List l; //serial
int baudrate = 9600; //serial

Random r = new Random();

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
     //.setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
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
  
  alto=height;
  ancho=width;
  
  textSize(25);
  fill(3,4,94);
  text("Automatización túnel de viento",300,30);

  fill(#002D5A);              
  textSize(20);
  text("Parametros actuales",690,180);                  
  text("T:           °C",602,230);       
  text("H:          %",743,230);       
  text("P:          hPa",863,230);       
  text("v:          m/s",643,270);       
  text("v(ref):           m/s",780,270);       
  fill(248,240,248);//cuadros con fondo
  stroke(#5DD2EA);
  rect(625,210,60,30);//T
  rect(765,210,60,30);//H
  rect(882,210,60,30);//P
  rect(660,250,60,30);//v
  rect(840,250,60,30);//vref
  
  fill(#002D5A);              
  textSize(20);
  text("Control",730,335); 
  text("Guardado",730,580);                 

  stroke(#5DD2EA); //cuadros que no se refrescan
  noFill();
  rect(590,155,400,145);//Parametros actuales
  rect(590,310,400,190);//control
  rect(590,560,400,80);//guardado
 
  fill(#002D5A);              
  textSize(20);
  text("Velocidad: ",640,370);    
  cp5.addTextfield("Veloc").setPosition(744,350).setSize(100, 30).setAutoClear(false).setColor(cc).setFont(font).setLabel("");
  cp5.addButton("Enviar").setPosition(744+100,350).setSize(85, 30).setFont(font2); //.toInt ver
  
  text("Archivo: ",640,615);  
  cp5.addTextfield("Nombre archivo").setPosition(720,595).setSize(160, 30).setAutoClear(false).setColor(cc).setFont(font).setLabel("");
  cp5.addButton("Guardar").setPosition(720+160,595).setSize(85, 30).setFont(font2); 
    
  cp5.addButton("Run").setPosition(690,405).setSize(85, 85).setFont(font2);

  cp5.addButton("Stop").setPosition(790,405).setSize(85, 85).setFont(font2);

}


void draw() {
  stroke(#5DD2EA);
  fill(248,240,248);
  rect(590,35,400,110);//serial
  fill(#002D5A);              
  textSize(20);
  text("Puerto: ",620,60);
  
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
    Arduino.bufferUntil(10);
  }
  else{
    println("cierro puerto "+puerta);
    actualizar();
    Arduino.clear();
    Arduino.stop();
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
  cp5.get(Textfield.class, "Nombre archivo").clear() ;
  }
