classdef (Abstract) unit
  
  properties
    name = '';
    temp = 15;
    den = 1.225;    
##    mass_rate = 0;     
    area = 1;    
  endproperties
  
  properties (Dependent)
##    vol_rate;    
  endproperties  
  
  properties (Access = protected)    
    oper_curve = [];     
  endproperties      
  
  methods
##    add operational curve
    function obj = add_oper_curve(obj, oper_curve)
      assert(isa(oper_curve, 'operational_curve'), "input needs to be an operation_curve object");
      if obj.temp == oper_curve.temp 
        obj.oper_curve = oper_curve;
      else
        obj.oper_curve = oper_curve.correct_curve(obj.temp, obj.den);
      endif
    endfunction
    
##    resample oper_curve
    function obj = resample_oper_curve(obj, mass_rate_new)
      assert(~isempty(obj.oper_curve), "please add operational curve first");
      obj.oper_curve = obj.oper_curve.resample(mass_rate_new);
    endfunction  
    
##    output mass_rate and press_change
    function [mr, pc] = output_oper_curve(obj)
      mr = obj.oper_curve.mass_rate;
      pc = obj.oper_curve.press_change;
    endfunction  
    
##    display operational curve
    function plot_oper_curve_mass(obj)
      obj.oper_curve.plot_mass()         
    endfunction
    
    function plot_oper_curve_vol(obj)
      obj.oper_curve.plot_vol()         
    endfunction
    
  endmethods  

##  get methods
  methods       
    
##    function val = get.vol_rate(obj)
##      val = obj.mass_rate / obj.den;
##    endfunction   

##    function val = get.oper_curve(obj)
##      val = obj.oper_curve;
##    endfunction  
    
  endmethods
  
endclassdef
