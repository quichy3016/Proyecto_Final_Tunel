void THP(){
    ////////SHT31////////////////////////
  //t = sht31.readTemperature()-offsett;//t
  //h = sht31.readHumidity()-offseth;//h
  

  ////////SHT21/////////////////////////
  t1=sensor.readTemperature();
  T1=t1+273.15;
  h1=sensor.readHumidity();
  
  
  /////////BME280///////////////////////
  t2=bme.readTemperature();
  h2=bme.readHumidity();
  p2=bme.readPressure();  
  
}
