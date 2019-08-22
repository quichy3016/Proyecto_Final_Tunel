#include <Arduino.h>
#include <Wire.h>
///FiltroA 
//https://www.megunolink.com/documentation/arduino-libraries/exponential-filter/
#include "Filter.h" 
#include "MegunoLink.h"
ExponentialFilter<float> ADCFilter(20, 0);
//FiltroB   
//https://www.youtube.com/watch?v=QGDG5v_UnIk
float Y=0.0;
float alpha=0.05;
float S=Y;
///Sensores e INA
#include "Adafruit_SHT31.h"
#include "Adafruit_Si7021.h"
#include <Adafruit_Sensor.h>
#include <Adafruit_BME280.h>
#include <Adafruit_INA219.h>

/////SHT31////////////////////////////
Adafruit_SHT31 sht31 = Adafruit_SHT31();
//////DHT21//////////////////////////
Adafruit_Si7021 sensor = Adafruit_Si7021();
//////BME280//////////////////////////
Adafruit_BME280 bme; // I2C
///////INA-219////////////////////////
Adafruit_INA219 ina219;
//////////////////////////////////////

long tiempo=0;

void setup() {
  Serial.begin(115200);
  //////SHT31////////
  if (! sht31.begin(0x44)) {   // Set to 0x45 for alternate i2c addr
    Serial.println("Couldn't find SHT31");
    while (1) delay(1);
  }
  /////SHT21/////////////////
  if (!sensor.begin()) {
    Serial.println("Did not find Si7021 sensor!");
    while (true);
  }
  /////BME280////////////////////
  if (!bme.begin()) {
    Serial.println("Could not find a valid BME280 sensor, check wiring!");
    while (1);
  }
  //////INA-219///////////////////////
  ina219.begin();
  ina219.setCalibration_16V_400mA();
  pinMode(7,INPUT_PULLUP);
}

void loop() {
  ////////SHT31////////////////////////
  float t = sht31.readTemperature()+0.77;//t
  float h = sht31.readHumidity()-3.35;//h
  Serial.print(t,3); Serial.print("\t");
  Serial.print(h,3); Serial.print("\t");

  ////////SHT21/////////////////////////
  float t1=sensor.readTemperature()+0.564;
  float h1=sensor.readHumidity()+4.07;
  Serial.print(t1,3); Serial.print("\t");
  Serial.print(h1,3);Serial.print("\t");
  
  /////////BME280///////////////////////
  float t2=bme.readTemperature()-0.56;
  float h2=bme.readHumidity()+3.49;
  float p2=bme.readPressure();  
  Serial.print(t2,3);Serial.print("\t");
  Serial.print(h2,3);Serial.print("\t");
  Serial.print(p2,3);Serial.print("\t");
  
  /////////INA-219////////////////////////
  float busvoltage = ina219.getBusVoltage_V();
  float presionSF = (busvoltage - 2.524) * (1000);
  ADCFilter.Filter(presionSF); //FiltroA
  Serial.print(busvoltage,3);Serial.print("\t"); 
  Serial.print(presionSF,3);Serial.print("\t");
  Serial.print(ADCFilter.Current(),3);Serial.print("\t"); //FiltroA
  S=(alpha*presionSF)+((1-alpha)*S); //FiltroB
  Serial.print(S,3);Serial.print("\t"); //FiltroB
 
  //////////Calculo velocidad////////////////
  float velocidadA = sqrt((2*abs(ADCFilter.Current()))/1.183);
  float velocidadB = sqrt(2*abs(S)/1.183);
  Serial.print(velocidadA,3);Serial.print("\t");  
  Serial.print(velocidadB,3);Serial.print("\t");

  
  /////////////////////////////////////////
  tiempo=millis();
  Serial.print(tiempo);Serial.print("\t");
  boolean paro = digitalRead(7);
  Serial.println(paro);
  delay(100);
}
