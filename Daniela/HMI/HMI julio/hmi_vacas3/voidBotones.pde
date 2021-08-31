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

void seronoser(boolean estado) { //abro puerto usb
    if (estado ==  true) {
        println("abro puerto" + puerta);
        Arduino = new Serial(this,puerta,baudrate);
        unicavez = 0;
        tiempo1 = millis();  
        Dato0 = "0";
        Dato1 = "0";
        Dato2 = "0";
        Dato3 = "0";
        Dato4 = "0";
        Dato5 = "0";
        Dato6 = "0";
        DatosW();
    }
    
    else{
        println("cierro puerto " + puerta);
        actualizar();
        Corre = false;
        Parada = true;
        unicavez = 0;
        variablecontrol1=0;
        TB12.setOff();
        TB1.setOff();
        TB13.setOff();//autofuuncion
        Dato0 = "0";
        Dato1 = "0";
        Dato2 = "0";
        Dato3 = "0";
        Dato4 = "0";
        Dato5 = "0";
        Dato6 = "0";
        DatosW();
        Arduino.clear();
        Arduino.stop();
        
    }
}

public void Run() {
    if (serono.isOn() ==  true) {
        Corre = true;
        Parada = false;
        Dato0 = "1";
        DatosW();
        println("RUN " + DatosWrite);
        
    }
}

public void Stop() {
    if (serono.isOn() ==  true) {  //solo tengo q mandar si esta ai1 o no?
        Corre = false;
        Parada = true;
        Dato0 = "0";
        DatosW();
        
        println("STOP"  + DatosWrite);
    }
}


void EnviarVel() {
    textV = cp5.get(Textfield.class, "Veloc").getText();
    textVV = float(textV);
    if (4.7 < textVV && textVV < 17.05) {
        //print("velocidad:"+ textVV);
        
        textVV = map(textVV,4.7,17,0,32767);
        textVVV = int(textVV);
        Dato1 = str(textVVV);
        DatosW();
        
        println("VELOCIDAD" + DatosWrite);
        
        TL18.setVisible(false);
    }
    else{
        println("ingrese un numero válido");
        TL18.setVisible(true);
    } 
    
    cp5.get(Textfield.class,"Veloc").clear();
}

void EnviarFrec() {
    textF = cp5.get(Textfield.class, "Frec").getText();
    textFF = float(textF);
    if (13.8 < textFF && textFF < 50.5) {
        println("FRECUENCIA:" + textFF);
        textFF = map(textFF,14,50,0,32767);
        textFFF = int(textFF);
        Dato1 = str(textFFF);
        TL18.setVisible(false);
        DatosW();
        println("ENVIAR FRECUENCIA" + DatosWrite);
    }
    else{
        println("ingrese un numero válido");
        TL18.setVisible(true);
    } 
    
    cp5.get(Textfield.class, "Frec").clear();
}


void Guardar() {
    println();
    print("El nombre del archivo es : ");
    text2 = cp5.get(Textfield.class, "Nombre archivo").getText();
    print(text2);
    saveTable(table, "data1/" + text2 + ".csv","csv");
    cp5.get(Textfield.class, "Nombre archivo").clear();
    table.clearRows();
    tiempo3 = tiempo;  
}

void ControlONOFF(boolean D2) { //si esta prendido el control


    if (D2 ==  true) {
        Dato2 = "1";
        DatosW();
        println("prendido" + DatosWrite);
        Stop();
    }
    else {
        Dato2 = "0";
        DatosW();
        println("apagado" + DatosWrite);
    }
}



void reset() { //
    
        DD4=true;
        Dato4 = "1";
        Dato5 = "0";
        //TB11.update();
        DatosW();
        println("reset en 1 " + DatosWrite);
        
    reinicioreset = true;
    tiempo2 = millis();
    println("reinicio");
}

void fallaext(boolean D5) { //
   println("algo");
   
    if (D5 ==  true) {
        Dato0 = "0";
        Dato2 = "0";
        Dato3 = "0";
        Dato5 = "1";
        DatosW();
        println("falla externa 1  " + DatosWrite);

    }
    else{
        Dato5 = "0";
        DatosW();
        println("falla externa 0  " + DatosWrite);
    }
}

void Habilitacion(boolean D6) {//habilitacion de ai1
    if (D6 ==  true) {
        Dato3 = "1";
        DatosW();
        println("ai1 en 1  " + DatosWrite);
        TB1.setVisible(true);  
        TL8.setVisible(true);
        
    }
    else{
        Dato3 = "0";
        Dato0 = "0";
        DatosW();
        TB1.setVisible(false);  
        TL8.setVisible(false);
        println("ai1 en 0  " + DatosWrite);
        TL99.setVisible(false);        TF11.setVisible(false);
        TB22.setVisible(false);        TL77.setVisible(true);    
        TL9.setVisible(false);        TF1.setVisible(false);
        TB2.setVisible(false);        TL7.setVisible(false);
        TB1.setOff();///////////////////
    }
    
}

//autofuncion
void Settings(int n) {   //lista donde elijo el archivo a leer
    fitem = cp5.get(ScrollableList.class, "Settings").getItem(n).get("name").toString();
    
}

void ICONO(){ //boton de enviar el archivo
table1 = loadTable("autofun/" +fitem, "header"); //leo el archivo donde estan los escalones

float [] yfun = new float [table1.getRowCount()];
float [] dTiem = new float [table1.getRowCount()];
for(int f= 0 ; f<table1.getRowCount(); f++){
    yfun [f] = table1.getFloat(f, 0); 
    dTiem [f] =  table1.getFloat(f, 1);
}   ///SI AL FINAL MARCA NULL O NaN ES PORQ EL ARCHIVO CSV TIENE LINEAS EN BLANCO
   for (int i = 0; i < yfun.length; i++) {
    Dato7 = Dato7 + "," + str(yfun[i]) + "," + str(dTiem[i]);
    }
  //Dato6= "1";//////////////////////////////////
  
  Dato6= str(yfun.length+dTiem.length);
  println("Dato6: "+Dato6);
    ddl1.setLabel("Elija archivo");
 

 DatosWrite2 = (Dato0 + "," + Dato1 + "," + Dato2 + "," + Dato3 + "," + Dato4 + "," + Dato5 + "," + Dato6  + Dato7+ ","+'\n');
 Arduino.write(DatosWrite2);
 println(DatosWrite2);
Dato6= "0";
Dato7="";

}

//fin autofuncion