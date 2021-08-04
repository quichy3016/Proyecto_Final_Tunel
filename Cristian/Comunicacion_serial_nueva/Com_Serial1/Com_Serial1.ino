
const int led_1 = 13, led_2 = 10; // Variable asignada al pin led 1 y 2
String data;                      // Variable asignada al dato obtenido
float var=0;
     


void setup() {
  pinMode(led_1, OUTPUT); // Configuracion del pin led 1 como salida
  pinMode(led_2, OUTPUT); // Configuracion del pin led 2 como salida
  Serial.begin(9600);     // Comunicacion serial a 9600 bps

  // Mensaje inicial
  Serial.println("Ingresar el dato como: porcentaje_1,porcentaje_2");
  Serial.println("Formato: XXX,YYY");
  Serial.println("Ejemplo: 10,100 (10% y 100%)");
}

void loop() {
  
}

void serialEvent(){
  

if(Serial.available() > 0){ // Lectura del puerto mientras sigue abierto
     data = Serial.readStringUntil('\n');                   // Lectura del dato hasta el line feed 
     Serial.print("Dato original: "); Serial.println(data); // Muestra del dato original

     int n,n1=0,n2,n3,n4, pwm_1, pwm_2,pwm_3,pwm_4,pwm_5; // Variables de almacenamiento de pwm y para algoritmo de lectura
     int pwm22[6];

     for (int i = 0; i <= data.length(); i++){ // Lectura total del tamano del dato
       if (data.substring(i, i+1) == ","){     // Lectura del dato hasta encontrar el caracter ","
         if (n1==0){
          pwm22[n1] = data.substring(0, i).toInt();
          n1=n1+1;
          n = i + 1; 
         }
         else{
         pwm22[n1] = data.substring(n, i).toInt();
         Serial.println(pwm22[n1]);
         n1=n1+1;// Conversion del dato obtenido del porcentaje del pwm 1
         
         n = i + 1;                            // Posicion de la letra final leida + 1
       }}
     }


//    for (int i = n; i <= data.length(); i++){ // Lectura total del tamano del dato
//       if (data.substring(i, i+1) == ","){     // Lectura del dato hasta encontrar el caracter ","
//         pwm_2 = data.substring(n, i).toInt(); // Conversion del dato obtenido del porcentaje del pwm 1
//         n1 = i + 1;                            // Posicion de la letra final leida + 1
//       }
//     }
     // Lectura total del tamano del dato desde el ultimo punto
//     for (int i = n; i <= data.length(); i++){ 
//        pwm22[4] = data.substring(n, i).toInt();  
//        }
//      for (int i = n1; i <= data.length(); i++){ 
//        pwm_3 = data.substring(n1, i).toInt(); 
//        n2 = i + 1;  }

     // Muestra del dato del porcentaje de PWM 1 y 2
     Serial.print("Procentaje 1: "); Serial.print(pwm22[0]); Serial.println(" %");
     Serial.print("Procentaje 2: "); Serial.print(pwm22[1]); Serial.println(" %");
     Serial.print("Procentaje 3: "); Serial.print(pwm22[2]); Serial.println(" %");
     Serial.print("Procentaje 4: "); Serial.print(pwm22[3]); Serial.println(" %");
     Serial.print("Procentaje 5: "); Serial.print(pwm22[4]); Serial.println(" %");
     Serial.print("Procentaje 5: "); Serial.print(pwm22[5]); Serial.println(" %");
     
     pwm22[0] = map(pwm22[0], 0, 32767, 9059, 32767); // Cambio de formato del dato de 0 - 100%, a 0 - 255
     pwm22[1] = map(pwm22[1], 0, 100, 0, 255); // Cambio de formato del dato de 0 - 100%, a 0 - 255
     pwm22[2] = map(pwm22[2], 0, 100, 0, 255); // Cambio de formato del dato de 0 - 100%, a 0 - 255
     pwm22[3] = map(pwm22[3], 0, 100, 0, 255); // Cambio de formato del dato de 0 - 100%, a 0 - 255
     pwm22[4] = map(pwm22[4], 0, 100, 0, 255); // Cambio de formato del dato de 0 - 100%, a 0 - 255

     var=pwm22[0]/655.34;
     // Muestra del dato en pantalla
     Serial.print("PWM 1: "); Serial.println(var);
     Serial.print("PWM 2: "); Serial.println(pwm22[1]);
     Serial.print("PWM 3: "); Serial.println(pwm22[2]);
     Serial.print("PWM 4: "); Serial.println(pwm22[3]);
     Serial.print("PWM 5: "); Serial.println(pwm22[4]);
    
     analogWrite(13, pwm22[0]); // Salida PWM en el led de 0 a 255
     analogWrite(led_2, pwm22[1]); // Salida PWM en el led de 0 a 255
  }

  
}
