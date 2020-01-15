classdef hvacSys
  
  properties    
    name = '';         
  endproperties  
  
  properties (Access = protected)
    units = {};  
    mass_rate = [0, 1];
    press_change = [0, 0];    
  endproperties  
  
  methods
    ## constructor
    function obj = hvacSys(name)
      obj.name = name;
    endfunction
    ## 
    function obj = add_unit(obj, unit)      
      assert(isa(unit, 'unit'), 'argument has to be an unit object');                         
      obj.units{end + 1} = unit;
      if numel(obj.units) == 1
        [mr, pc] = unit.output_oper_curve;
        obj.mass_rate = mr;
        obj.press_change = pc;
      else
        unit = unit.resample_oper_curve(obj.mass_rate);
        [~, pc] = unit.output_oper_curve;
        obj.press_change += pc;
      endif     
    endfunction
  
    function obj = remove_unit(obj, idx)
      assert(idx <= numel(obj.units), 'units index provided out of bound');
      unit = obj.units{idx};
      obj.units(idx) = [];
      unit = unit.resample_oper_curve(obj.mass_rate);     
      [~, pc] = unit.output_oper_curve; 
      obj.press_change -= pc;
    endfunction   

    function obj = resample(obj, mass_rate)          
      obj.press_change = interp1(obj.mass_rate, obj.press_change, mass_rate, 'extrap');
      obj.mass_rate = mass_rate;
    endfunction  
      
    function lst = list_units(obj)
        lst = obj.units;
    endfunction    
      
    function [mr, pc] = output_oper_curve(obj)
      mr = obj.mass_rate;
      pc = obj.press_change;           
    endfunction  
    
    function plot_oper_curve(obj)
      [mr, pc] = obj.output_oper_curve;
      plot(mr, pc, 'linewidth', 2)      
    endfunction  
    
  endmethods

endclassdef
