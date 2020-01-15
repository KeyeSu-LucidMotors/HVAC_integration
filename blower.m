classdef blower < unit
  
  properties
    rpm;
  endproperties  
  
  methods 
##    constructor
    function obj = blower(name, t, d, rpm)
      obj.name = name;
      obj.temp = t;
      obj.den = d;
      obj.rpm = rpm;
    endfunction              
    
  endmethods  
  
endclassdef