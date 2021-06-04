import processing.serial.*;
Serial puertoArduino;

Table table;
Table table1;

String textbox_says = "0";
float [] algo;
float t,t1,t2,t3;
boolean a=true;
int i=0;
int long1;
void setup(){
  size(700, 600);
  background(255);
  println(Serial.list());//Cambia el indice [1] por el que indique la consola
  puertoArduino = new Serial(this, Serial.list()[2], 115200);
  
  table1 = loadTable("vector1.csv");
  long1=table1.getRowCount();
  
  //println(b);
 ////TABLA////
  table = new Table();
  table.addColumn("Muestra");
  table.addColumn("Filtro1");
  table.addColumn("Filtro2");
  table.addColumn("Filtro3");
}

void draw(){
  if (millis()>3000){
  fill(255,255,255);
       noStroke();
       rectMode(CORNERS);
      
      rect(130,560,190,610);//Borra lectura anterior
      rect(250,10,310,30);//Borra lectura anterior
      rect(340,10,390,30);//Borra lectura anterior
  
      fill(255,0,255);
      text(t, 270, 20);
      text(t1, 350, 20);
      //println(t1);
      text(textbox_says, 150, 580);
      //puertoArduino.write("1"); 
      if (i<long1){
      float b = table1.getFloat(i,0);
      //println(b);
      puertoArduino.write(str(b));
      puertoArduino.write(";");
      
      //delay(500);
  }
//      if(a== true){
//       fill(255,255,255);
//       noStroke();
//       rectMode(CORNERS);
      
//      rect(130,560,190,610);//Borra lectura anterior
//      rect(250,10,290,30);//Borra lectura anterior
//      a=!a;
//      //}
//}
//println(i);
i=i+1;


}}


void keyPressed() {//Presionar 'ESC' para salir

    if( key != CODED ){
      if(key != 'd' & key != 'D' & key != 'f' & key != 'F'){
      textbox_says += key;
     }}
    
    if (keyPressed) {
    if (key == 'b' || key == 'B') {
    saveTable(table, "data/Prueba_10_Casa1.csv","csv");
    //fill(0);
    }
    } else {
    //fill(255);
    }
    //rect(25, 25, 50, 50);
    
    if (key == 'd' || key == 'D') {
    puertoArduino.write((textbox_says)); 
    //puertoArduino.write("1"); 
    //puertoArduino.write(67); 
    //fill(0);
    }
    
    if (key == 'f' || key == 'F') {
    //puertoArduino.write(int(65));
    textbox_says="0";
    //fill(0);
    }
}



void tabla(){
  TableRow newRow = table.addRow();
  newRow.setFloat("Muestra", t);
  newRow.setFloat("Filtro1", t1);
  newRow.setFloat("Filtro2", t2);
  newRow.setFloat("Filtro3", t3);
}

void serialEvent(Serial puertoArduino) { 
  String inString = puertoArduino.readStringUntil('\n'); 
  
  //if (millis()>2200){
  if (inString != null){
      
      algo = float(split(inString,';'));
      fill (255,0,0);
      t=algo[0];
      t1=algo[1];
      t2=algo[2];
      t3=algo[3];
      //print(t);print("\t");
      //println(t1);
      tabla();}
}
