


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
    if (estado ==  true) {
        println("abro puerto" + puerta);
        Arduino = new Serial(this,puerta,baudrate);
      //  VERSERIE = true;
        unicavez = 0;
        tiempo1 = millis();  
    }
    
    else{
        println("cierro puerto " + puerta);
        actualizar();
       // VERSERIE = false;
        Corre = false;
        Parada = true;
        unicavez = 0;
        TB12.setOff();
        TB1.setOff();
        Dato0 = "0";
        Dato1 = "0";
        Dato2 = "0";
        Dato3 = "0";
        Dato4 = "0";
        Dato5 = "0";
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

void ControlONOFF(boolean D2) {

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


void reset(boolean D4) { //
    
  if (D4 ==  true) {
        Dato4 = "1";
        DatosW();
        println("reset en 1 " + DatosWrite);
    }
    else{
        Dato4 = "0";
        DatosW();
        println("reseten 0 " + DatosWrite);
    }
    reinicioreset = true;
    tiempo2 = millis();
    println("reinicio");
}

void fallaext(boolean D5) { //
   
    if (D5 ==  true) {
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

void Habilitacion(boolean D6) {//
    if (D6 ==  true) {
        // HabilitacionV = true;
        Dato3 = "1";
        DatosW();
        println("ai1 en 1  " + DatosWrite);
        TB1.setVisible(true);  
        TL8.setVisible(true);
        
    }
    else{
        Dato3 = "0";
        DatosW();
        TB1.setVisible(false);  
        TL8.setVisible(false);
        println("ai1 en 0  " + DatosWrite);
        TL99.setVisible(false);        TF11.setVisible(false);
        TB22.setVisible(false);        TL77.setVisible(true);    
        TL9.setVisible(false);        TF1.setVisible(false);
        TB2.setVisible(false);        TL7.setVisible(false);

    }
    
}

//autofuncion
void Settings(int n) {
    fitem = cp5.get(ScrollableList.class, "Settings").getItem(n).get("name").toString();
    
}

void ICONO(){
println("boton " + fitem);
table = loadTable("autofun/" +fitem, "header");
ddl1.setLabel("Elija archivo");
println(table.getRowCount() + " total rows in table");
  TableRow row = table.getRow(0);
    y1 = row.getFloat("y1");
    y2 = row.getFloat("y2");
    y3 = row.getFloat("y3");
    y4 = row.getFloat("y4");
    y5 = row.getFloat("y5");
    y6 = row.getFloat("y6");
    y7 = row.getFloat("y7");
    y8 = row.getFloat("y8");
    Dt1 = row.getInt("Dt1");
    Dt2 = row.getInt("Dt2");
    Dt3 = row.getInt("Dt3");
    Dt4 = row.getInt("Dt4");
    Dt5 = row.getInt("Dt5");
    Dt6 = row.getInt("Dt6");

colfun= #000088;
float j= y1+Dt1;
println(j);
DatoFun= str(y1)+","+str(Dt1)+","+str(y2)+","+str(Dt2)+","+str(y3)+","+str(Dt3)+","+str(y4)+","+str(Dt4)+","+str(y5)+","+str(Dt5)+","+str(y6)+","+str(Dt6)+","+str(y7)+","+str(Dt7)+","+str(y8)+","+str(Dt8);

DatosWrite = ("0,0,0,0,0,0," + DatoFun+ ","+'\n');
println(DatosWrite);

 //DatosWrite = (Dato0 + "," + Dato1 + "," + Dato2 + "," + Dato3 + "," + Dato4 + "," + Dato5 + "," + DatoFun+ ","+'\n');
  //  Arduino.write(DatosWrite);

}

//fin autofuncion