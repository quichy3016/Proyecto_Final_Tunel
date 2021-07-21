#include "Filter.h"
#include "MegunoLink.h"
ExponentialFilter<float> ADCFilter(20, 0);
float valor=0.0;
float alpha=0.05;
float S=valor;

//Potenciometro A0

void setup() {
  Serial.begin(9600);
}
 
void loop() {
float valor = analogRead(0);

ADCFilter.Filter(valor);
S=(alpha*valor)+((1-alpha)*S);

Serial.print(valor);
Serial.print(",");
Serial.print(ADCFilter.Current());
Serial.print(",");
Serial.println(S);
delay(100);
}
