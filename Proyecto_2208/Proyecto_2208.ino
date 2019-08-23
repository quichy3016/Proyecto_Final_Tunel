#include <Arduino.h>
#include <Wire.h>
///FiltroA 
//https://www.megunolink.com/documentation/arduino-libraries/exponential-filter/
#include "Filter.h" 
#include "MegunoLink.h"
ExponentialFilter<float> ADCFilter0(20,0);
ExponentialFilter<float> ADCFilter1(20,0);
//FiltroB   
//https://www.youtube.com/watch?v=QGDG5v_UnIk
float Y=0.0;
float alpha=0.05;
float S=Y,S1=Y;
///Sensores e INA
#include "Adafruit_SHT31.h"
#include "Adafruit_Si7021.h"
#include <Adafruit_Sensor.h>
#include <Adafruit_BME280.h>
#include <Adafruit_INA219.h>
#include <Adafruit_ADS1015.h>

/////SHT31////////////////////////////
Adafruit_SHT31 sht31 = Adafruit_SHT31();
//////DHT21//////////////////////////
Adafruit_Si7021 sensor = Adafruit_Si7021();
//////BME280//////////////////////////
Adafruit_BME280 bme; // I2C
///////INA-219////////////////////////
Adafruit_INA219 ina219;
////////ADS115////////////////////////
Adafruit_ADS1115 ads;
/////Variables THP ///////////////////
float t=0,t1=0,t2=0;
float h=0,h1=0,h2=0;
float p2=0;
/////Variables Dif - Presion//////////
float presionSF=0,presionCF=0,presionSF2=0,presionCF2=0;
float busvoltage=0,adc0=0;
//////Variables velocidad/////////////
float velocidadA=0,velocidadB=0,velocidadA1=0,velocidadB1=0;
/////////variables-offset/////////////
int contador=0,cancelcontador=0;
float tempref=17.4;
float humref=55.5;
float presionref=101312;
float offsett=0,offsett1=0,offsett2=0;
float offseth=0,offseth1=0,offseth2=0;
float offsetp2=0,offsetdf=0,offsetdf1=0;
//////////////////////////////////////
long tiempo=0;

void setup() {
  Serial.begin(115200);
  //////SHT31////////
  if (! sht31.begin(0x44)) {   // Set to 0x45 for alternate i2c addr
    Serial.println("Problema sensor - SHT31");
    while (1) delay(1);
  }
  /////SHT21/////////////////
  if (!sensor.begin()) {
    Serial.println("Problema sensor - Si7021");
    while (true);
  }
  /////BME280////////////////////
  if (!bme.begin()) {
    Serial.println("Problema sensor - BME280");
    while (1);
  }
  //////INA-219///////////////////////
  ina219.begin();
  ina219.setCalibration_16V_400mA();
  /////ADS1115///////////////////////
  ads.setGain(GAIN_ONE);        // 1x gain   +/- 4.096V  1 bit = 2mV      0.125mV
  ads.begin();
  pinMode(7,INPUT_PULLUP);
}

void loop() {
  calculo_offset();
  THP(); 
  difPresion();
  vel_tiempo();
  boolean paro = digitalRead(7);
  Serial.println(paro);
  delay(100);
}
