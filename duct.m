classdef duct < unit
  
  methods 
##    constructor
    function obj = duct(name, t, d)
      obj.name = name;
      obj.temp = t;
      obj.den = d;
    endfunction              
    
  endmethods  
  
endclassdef