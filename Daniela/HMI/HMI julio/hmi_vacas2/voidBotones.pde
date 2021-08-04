public void Run(){
    if (VERSERIE ==  true){
    Corre= true;
    Parada = false;



    Dato0= "1";

            DatosW();

    println("RUN " +DatosWrite);

    }
}
    
public void Stop(){
    if (VERSERIE ==  true){
    Corre= false;
    Parada = true;
    Dato0= "0";
            DatosW();

    println("STOP"  +DatosWrite);
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
Corre= false;
Parada = true;
}
}
///////FINSERIAL


void EnviarVel() {
textV = cp5.get(Textfield.class, "Veloc").getText();
textVV = float(textV);
if (4.7<textVV && textVV<17.05){
//print("velocidad:" + textVV);

textVV=map(textVV,4.7,17,0,32767);
textVVV=int(textVV);
Dato1= str(textVVV);
    DatosW();

    println("VELOCIDAD" +DatosWrite);

TL18.setVisible(false);
}
else{
    println("ingrese un numero válido");
    TL18.setVisible(true);
} 

cp5.get(Textfield.class, "Veloc").clear();
}


void EnviarFrec() {
textF = cp5.get(Textfield.class, "Frec").getText();
textFF = float(textF);
if (13.8<textFF && textFF<50.5){
println("FRECUENCIA:" + textFF);
textFF=map(textFF,14,50,0,32767);
textFFF=int(textFF);
Dato1= str(textFFF);
TL18.setVisible(false);
    DatosW();

    println("ENVIAR FRECUENCIA" +DatosWrite);
}
else{
    println("ingrese un numero válido");
    TL18.setVisible(true);
} 

cp5.get(Textfield.class, "Frec").clear();
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


void ControlONOFF(boolean D2){
    
       
        ControlONOFFnueva=!ControlONOFFnueva;
       if (ControlONOFFnueva==true){
    Dato2= "1";
        DatosW();

    println("prendido" +DatosWrite);

    }
    else {
         Dato2= "0";
        DatosW();

println("apagado" + DatosWrite);
     }
}


void ControlTodo(boolean D3){
    ControlTodoall= !ControlTodoall;
// if (ControlTodoall==true){
//     Dato3= "1";
//     DatosWrite= (Dato0 +","+Dato1 +","+ Dato2 +","+ Dato3 +","+ Dato4 +","+ Dato5+"," +'\n');
//     Arduino.write(DatosWrite);

//     }
//     else {
//          Dato3= "0";
//     print("apagado");
//     DatosWrite= (Dato0 +","+Dato1 +","+ Dato2 +","+ Dato3 +","+ Dato4 +","+ Dato5+"," +'\n');
//     Arduino.write(DatosWrite);

//      }
}


void reset(boolean D4){

DD4=true;
println("DD4 " +DD4);
    if (DD4==true){

          Dato4= "1";
    DatosW();

    println("reset en 1 " + DatosWrite);
    }
    else{
        Dato4= "0";
        DatosW();

        println("reseten 0 " + DatosWrite);

    }
    reinicioreset=true;
    tiempo2=millis();
    println("reinicio");
}

void fallaext(boolean D5){
   
     DD5=!DD5;
    if (DD5==true){

          Dato5= "1";
       DatosW();

    println("falla externa 1  " + DatosWrite);


    }
    else{
        Dato5= "0";
        DatosW();

        println("falla externa 0  " + DatosWrite);

 
    }
}

void Habilitacion(boolean D6){
    
     DD6=!DD6;
    if (DD6==true){

          Dato3= "1";
        DatosW();

        println("ai1 en 1  " + DatosWrite);

    }
    else{
        Dato3= "0";
        DatosW();

            println("ai1 en 0  " + DatosWrite);

 
    }

}