% n = 50
% M_cobo = nchoosek(1:(n-i),numberofPick);

load Combinations.mat
load adjDegree.mat

N = 490314;
K = 1000;
r = randi([1 N],1,1000);
ep = 1e-9;              % Epsilon
T = 1;                  % Integration termination time
Div = 1000;

ener = zeros(1,K)
for i = 1 : K
    ener(i) = obj2(T,Div,adjG, M_cobo(i,:), ep);
end