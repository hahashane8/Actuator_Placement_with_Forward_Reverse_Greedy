% Add necessary package
clear all
addpath('./NetworkAnalysisTool');

% Load the matrix
load A_118_1.mat
n_uncon = 54;


adjG = A;
% load adjDegree.mat
adjG = adjG - diag(diag(adjG));
adjG = adjG;
%adjGO = randomGraph(10,0.4);
%adjG = giantComponent(adjGO);
K = 50;                  % Cardinality constraints  
ep = 1e-18;              % Epsilon
T = 1;                  % Integration termination time
Div = 100;              % Integration resolution (division of the total time)
switchM = 1;


% Initialization
gainVector  = [];
deletedNode = [];
inputNodeOrder = [];

% Measure the graph 
[x_1,y_1] = size(adjG);
K_discard  =  x_1 - K;
adjG_topo = zeros(x_1,y_1);
if x_1 ~= y_1 
  error('Adj not square!');
end
if isConnected(abs(adjG)) == 0
  error(' The graph entered is not connected.');
end

% Give the topological information for the graph.
for i = 1 : x_1
  for j = 1 : y_1
    if adjG(i,j) ~= 0
      adjG_topo(i,j) = 1;
    end
  end
end

% Determine whether the cardinality constraint is adequate.
CardEnoicon = isCardEnough(adjG_topo,K,x_1);
if CardEnoicon == 0
  error(' The allowed cardinality is too small! ');
end
tic
% Assign actuators to every node and depict the full adjacency matrix
possibleDiscard = (n_uncon+1) : x_1;
inputNode = 1 : x_1;
auxGSTadj = zeros(3 * x_1 + 3,3 * x_1 + 3);  
auxGSTadj(3 : (x_1 + 2) , (2 * x_1+3):(3 * x_1 + 2)) = adjG_topo;  % V to V'
auxGSTadj(1 , 3 : (x_1 + 2) ) = ones(1, x_1); % s to V
auxGSTadj((2 * x_1 + 3) : (3 * x_1 + 2) , 3 * x_1 + 3) = ones(x_1,1); % V' to t
auxGSTadj(1,2) = K; % s to \tilde{s}
auxGSTadj( 2, ( x_1 + 3+ n_uncon) : (2 * x_1 + 2)) = ones(1,x_1-n_uncon); % \tilde{s} to \tilde{V}
auxGSTadj( (x_1 + 3 + n_uncon) : (2 * x_1 + 2), (2 * x_1 + 3 + n_uncon)  : (3 * x_1 + 2)) = eye(x_1-n_uncon); % \tilde{V} to V'

% Greedy algorithm
while numel(inputNode) > (K + n_uncon) && numel(possibleDiscard)> 0
  numel(inputNode)
  auxGSTadj_copy = auxGSTadj;
  d = numel(possibleDiscard);
  
  % find the least marginal gain element 
  if numel(gainVector) == 0
    for j = 1 : d
      inputNodeAfterDiscard = setdiff( inputNode, possibleDiscard(j) );
      mg = obj2(T,Div,adjG,setdiff(inputNodeAfterDiscard,1:n_uncon),ep) - obj2(T,Div,adjG,setdiff(inputNode,1:n_uncon),ep);
      gainVector = [gainVector mg];
    end
  end
  [~,discardIndex] = min(gainVector);
  gainVector(discardIndex) = [];
  
  % feasibility check
  deletedNode = [deletedNode possibleDiscard(discardIndex)];
  inputNode_trial  = setdiff(inputNode,possibleDiscard(discardIndex));
  dIinaux = x_1+2+possibleDiscard(discardIndex);
  auxGSTadj_copy(dIinaux, dIinaux+x_1) = 0;
  
  % run max-flow to feasibility check
  [valf,adjMf] = findMaxflow(auxGSTadj_copy);
  newComer = possibleDiscard(discardIndex);
  possibleDiscard(discardIndex) = [];
  if valf < x_1 
    continue; % do not pass the check, the inputNode stays unchanged
  else 
    gainVector  = [];
    inputNode = inputNode_trial; % pass the check, inputNode get rid of the deleted node.
    inputNodeOrder = [ inputNodeOrder newComer ];
    auxGSTadj = auxGSTadj_copy;
  end
end
toc
inputNode = setdiff(inputNode,1:n_uncon);
obj2(T,Div,adjG,inputNode,10e-18)

inputNodeOrder
inputNode_all = (n_uncon+1) : x_1;
inputNode = setdiff(inputNode_all,inputNodeOrder);





  