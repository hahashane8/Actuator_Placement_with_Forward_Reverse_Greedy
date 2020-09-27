load adjDegree.mat

%% Parameters
[n,m] = size(adjG);
K = 8;  % Maximum cardinality
inputSelection  = [3 9 13 12 19 21 1 18];  % Greedy result inserted here
cursor = 0;  % The position of a new candidate gamma
ep = 1e-9;              % Epsilon
T = 1;                  % Integration termination time
Div = 10000;              % Integration resolution (division of the total time)

%% Initialization 
gammaCandidate = []; % Possible gamma stored here



%% Gamma for Incomplete Selections
% for i = 1 : K
%     if i == 1
%         currentSelection = [];
%     else
%         currentSelection  = inputSelection(1:i-1);
%     end
%     for j = 1 : n
%         gainG = -obj2(T,Div,adjG,[inputSelection j],ep) + obj2(T,Div,adjG,inputSelection,ep);
%         gainS = -obj2(T,Div,adjG,[currentSelection j],ep) + obj2(T,Div,adjG,currentSelection,ep);
%         if gainG ~= 0 
%             gamma = gainS/gainG;
% %%            if gamma < 1
%                 gammaCandidate = [gamma gammaCandidate];
% %%            end
%         end
%     end
%     for k = i : K-1
%         gainLopt = -obj2(T,Div,adjG,inputSelection(1:k+1) ,ep) + obj2(T,Div,adjG,inputSelection(1:k),ep);
%         gainSopt = -obj2(T,Div,adjG,[currentSelection inputSelection(k+1)],ep) + obj2(T,Div,adjG,currentSelection,ep);
%         gamma = gainSopt/gainLopt;       
% %%            if gamma < 1
%                 gammaCandidate = [gamma gammaCandidate];
% %%            end
%     end
% end

%% Gamma for Complete Selections
gainG = zeros(1,23);
N = n-K;
newSet = [];
for i = 1 : n
    if ismember(i,inputSelection) == 0
        newSet  = [i newSet];
        gainG(i) = -obj2(T,Div,adjG, [inputSelection i],ep) + obj2(T,Div,adjG, inputSelection, ep);
    end
end

for i = 1 : min(N,K-1)
    M_row = nchoosek(N,i);
    M_cobo = nchoosek(1:N,i);
    
    for k = 1 : M_row
        totalSet = [inputSelection newSet(M_cobo(k,:))];
        pjSet = [];
        for j = 1 : n
            if ismember(j,totalSet) == 0
                gainGT = -obj2(T,Div,adjG, [totalSet j],ep) + obj2(T,Div,adjG, totalSet, ep);
                gainGPure = gainG(j);
                if gainGT ~= 0 
                    gamma = gainGPure/gainGT;
%%                if gamma < 1
                    gammaCandidate = [gamma gammaCandidate];
%%                  end
                end
            end
        end
        
    end
end
