classdef util
  
  properties (Constant)
    air_temp = [-20 -10 0 5 10 15 20 25 30 35 40 45 50 60 70];
    air_den = [1.394 1.341 1.292 1.269 1.246 1.225 1.204 1.184 1.164 1.145 1.127 1.109 1.095 1.059 1.028];   
  endproperties

  methods
    
    function d = tempToDen(obj, t)
        d = interp1(obj.air_temp, obj.air_den, t, 'extrap');
    endfunction

    function t = denToTemp(obj, d)
        t = interp1(obj.air_den, obj.air_temp, d, 'extrap');
    endfunction
    
  endmethods

endclassdef