group = [];
tic
for i = 1 : 100000
    inputSelection = randsample(n_uncon+1:172,50);
    group = [group obj2(T,Div,adjG,inputSelection,1e-12)];
end
min(group)
toc