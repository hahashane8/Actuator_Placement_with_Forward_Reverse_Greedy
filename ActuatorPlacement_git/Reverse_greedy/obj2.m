% Objective function%% INPUTS: Input selection% OUTPUTS: Objective function%% GB: last updated, Jan 20, 2019function objout = obj2(T,Div,adjG,inputSelection,ep)     [x_1,y_1] = size(adjG);  Wc = myIntegration(T,Div,adjG,inputSelection);  objout = trace(inv(Wc + ep * eye(x_1)));  
  return 
