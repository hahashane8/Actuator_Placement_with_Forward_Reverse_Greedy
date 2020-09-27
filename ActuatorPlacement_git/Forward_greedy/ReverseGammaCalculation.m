load adjDegree.mat

%% Parameters
[n,m] = size(adjG);
N = 15;  % Maximum cardinality
excludedSelection  = [18 4 11 12 6 15 21 23 14 13 9 8 16 20 7];  % Greedy result inserted here
cursor = 0;  % The position of a new candidate gamma
ep = 1e-9;              % Epsilon
T = 1;                  % Integration termination time
Div = 1000;              % Integration resolution (division of the total time)
V= 1:23;

%% Initialization 
gammaCandidate = []; % Possible gamma stored here
currentExSelection = [];


for i = 0 : N-1
    prExSelection = currentExSelection
    currentExSelection  = union(currentExSelection, excludedSelection(i+1));
    currentSelection = setdiff(V,currentExSelection);
    prSelection = setdiff(V,prExSelection);
    gainCurrent = obj2(T,Div,adjG, currentSelection, ep) - obj2(T,Div,adjG, prSelection, ep);
    
    numberofPick  = min(n-i,N);
    M_row = nchoosek(n-i,numberofPick);
    M_cobo = nchoosek(1:(n-i),numberofPick);
    
    for k = 1: M_row
        totalSet  = union(prExSelection, M_cobo(k,:));
        totalSet = totalSet';
        if ismember(excludedSelection(i+1),totalSet) == 0
            totalSetLeftp1 = setdiff(V,[totalSet excludedSelection(i+1)]);
            totalSetLeft = setdiff(V,totalSet);
            gain_star = obj2(T,Div,adjG, totalSetLeftp1 ,ep) - obj2(T,Div,adjG, totalSetLeft ,ep);
            if gain_star ~= 0 
                gammaCandidate  = [gammaCandidate gainCurrent/gain_star];
            end
        end
        
    end
    
end
