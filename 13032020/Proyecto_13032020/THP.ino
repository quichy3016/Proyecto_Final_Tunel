void THP(){
    ////////SHT31////////////////////////
  //t = sht31.readTemperature()-offsett;//t
  //h = sht31.readHumidity()-offseth;//h
  

  ////////SHT21/////////////////////////
  t1=sensor.readTemperature()-offsett1;
  h1=sensor.readHumidity()-offseth1;
  
  
  /////////BME280///////////////////////
  t2=bme.readTemperature()-offsett2;
  h2=bme.readHumidity()-offseth2;
  p2=bme.readPressure()-offsetp2;  
  
}
