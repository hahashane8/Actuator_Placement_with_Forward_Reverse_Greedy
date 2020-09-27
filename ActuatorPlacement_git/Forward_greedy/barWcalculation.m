gam = 0.9
b = (1-gam)/gam;
alp = 0.1;
W = 1;
N = 100
b/(1-alp)
for i = 1 : N
    W = W * (1 + b / ((1 - alp)*(N + 1 - i)));
end
W = b^(-1) * W-b^(-1)

barW = b^(-1) * (2*N+1)^(b/(1-alp))-b^(-1)
