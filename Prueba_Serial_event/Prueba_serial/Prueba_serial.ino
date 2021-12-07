String data;
float entrada2[30];
float entrada1[30];
float Inref1;
int entrada[7],len,inc=0,inc1=1;
bool cambio=0,cambio1=0,terminoautoma=0,ControlAutomatico=0,Control=0;
long vtiempoant, tiempoautomatico,tiemporetardo;
void setup() {
  // put your setup code here, to run once:
Serial.begin(115200);
}

void loop() {
  // put your main code here, to run repeatedly:
  if (terminoautoma==1 & (millis()-tiempoautomatico)>=3500){
  
  cambio_automatico();}
  //Serial.println(entrada[3]);
}



void serialEvent() {

  if(Serial.available() > 0){ // Lectura del puerto mientras sigue abierto
     data = Serial.readString();//('\n');                   // Lectura del dato hasta el line feed 
     //Serial.print("Dato original: "); Serial.println(data); // Muestra del dato original
     int largovector=sizeof(entrada)/sizeof(int);
     int n,n1=0,n2=0; // Variables para algoritmo de lectura
Serial.println(data.length());
     for (int i = 0; i < data.length(); i++){ // Lectura total del tamano del dato
       if (data.substring(i, i+1) == ","){     // Lectura del dato hasta encontrar el caracter ","
         if (n1==0){
          entrada[n1] = data.substring(0, i).toInt();
          n1=n1+1;
          n = i + 1; 
         }
         else{
          if (n1>=largovector){
            break;}
          else{
         entrada[n1] = data.substring(n, i).toInt();
         n1=n1+1;
         n = i + 1;                            // Posicion de la letra final leida + 1
       }}}
     }
     
     
//     for (int i = 0; i < largovector; i++){
//     Serial.println(entrada[i]);}
     n=0;
/////////////////STRING A FLOAT////////////
     for (int i = 16; i <= data.length(); i++){ // Lectura total del tamano del dato
       if (data.substring(i, i+1) == ","){     // Lectura del dato hasta encontrar el caracter ","
         if (n2==0){
          entrada2[n2] = data.substring(15, i).toFloat();
          Serial.println(entrada2[n2]);
          n2=n2+1;
          n = i + 1; 
          //Serial.println(entrada2[0]);
         }
         else{
         entrada2[n2] = data.substring(n, i).toFloat();
         Serial.println(entrada2[n2]);
         n2=n2+1;
         n = i + 1;                            // Posicion de la letra final leida + 1
       }}
     }
/////////////////////////////////////////
     if (entrada[6]!=0){
      int j = 0;
      for (int i = 0; i <= data.length();i++){
        if (i>=entrada[6]){
            break;}
        else{
        entrada1[j] = entrada2[i];
        //Serial.println(entrada1[j]);
        j++;
      }}
//      Serial.print(entrada1[0]);Serial.print(" ");
//      Serial.print(entrada1[1]);Serial.print(" ");
//      Serial.print(entrada1[2]);Serial.print(" ");
//      Serial.print(entrada1[3]);Serial.println(" ");

      tiempoautomatico=millis();
      cambio=1;
      terminoautoma=1;
      //len = data.length()-7;
      len = entrada[6];
      //Serial.println(len);
      ControlAutomatico = 1;
     }else {
      terminoautoma = 0;
      cambio = 0;
      ControlAutomatico = 0;
      }
  
}}
