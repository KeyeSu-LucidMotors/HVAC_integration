classdef operational_curve
  
  properties
    name = '';
    temp = 15;  
    den = 1.225;  
    mass_rate = [0];   
    press_change = [0]; 
  endproperties  
  
  properties (Dependent)
    vol_rate;    
  endproperties    
    
## constructor
  methods
    
    function obj = operational_curve(name, t, d)
      obj.name = name;
      obj.temp = t;
      obj.den = d;
    endfunction  
    
  endmethods
  
  methods
    ##  correction methods using density ratio
    function corr_curve = correct_curve(obj, target_t, target_d)
      corr_curve = operational_curve("corr curve", target_t, target_d);          
      corr_curve.press_change = obj.press_change * target_d / obj.den;
      corr_curve.mass_rate = obj.vol_rate * target_d;      
    endfunction  
    
##    resample mass_rate 
    function obj = resample(obj, mass_rate_new)
      obj.press_change = interp1(obj.mass_rate, obj.press_change, mass_rate_new, 'extrap');
      obj.mass_rate = mass_rate_new;      
    endfunction  
      
##    show oper curve
    function show_table(obj)
      tab = [obj.mass_rate', obj.vol_rate', obj.press_change']
    endfunction
    
    function plot_mass(obj)           
      plot(obj.mass_rate, obj.press_change, 'linewidth', 2);
      xlabel 'mass rate'
      ylabel 'pressure'
    endfunction
    
    function plot_vol(obj)           
      plot(obj.vol_rate, obj.press_change, 'linewidth', 2);  
      xlabel 'vol rate'
      ylabel 'pressure'      
    endfunction    
    
  endmethods

##  get methods
  methods            
    
    function val = get.vol_rate(obj)
      val = obj.mass_rate / obj.den;
    endfunction         
    
  endmethods  
    
endclassdef
