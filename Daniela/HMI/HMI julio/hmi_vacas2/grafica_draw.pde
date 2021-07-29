byte[] inBuffer = new byte[500]; // holds serial message
int i = 0; // loop variable

void graf_draw(){
/* Read serial and update values */
  if (mockupSerial || VERSERIE ==true) {
    String myString = "";
    if (!mockupSerial) {
      try {
        Arduino.readBytesUntil('\n', inBuffer);
      }
      catch (Exception e) {
      }
      myString = new String(inBuffer);
    }
    else {
      myString = mockupSerialFunction();
    }


    // split the string at delimiter (space)
    String[] nums = split(myString, ';');
    
    for (i=0; i<nums.length; i++) {
      // update line graph
      try {
        if (i<lineGraphValues.length) {
          for (int k=0; k<lineGraphValues[i].length-1; k++) {
            ////////////t=lineGraphValues[0][k];
            ///////println(t);
            lineGraphValues[i][k] = lineGraphValues[i][k+1];

          }

          lineGraphValues[i][lineGraphValues[i].length-1] = float(nums[i])*float(getPlotterConfigString("lgMultiplier"+(i+1)));
        }
      }
      catch (Exception e) {
      }
    }
  }

  // draw the bar chart
  background(255); 
 
  // draw the line graphs
  LineGraph.DrawAxis();
  for (int i=0;i<lineGraphValues.length; i++) {
    LineGraph.GraphColor = graphColors[i];
    if (int(getPlotterConfigString("lgVisible"+(i+1))) == 1)
      LineGraph.LineGraph(lineGraphSampleNumbers, lineGraphValues[i]);
  }
  
}  
