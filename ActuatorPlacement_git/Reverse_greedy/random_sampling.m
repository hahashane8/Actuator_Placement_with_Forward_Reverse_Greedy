group = [];
tic
for i = 1 : 50000
    inputSelection = randsample(n_uncon+1:172,70);
    group = [group obj2(T,Div,adjG,inputSelection,10e-9)];
end
min(group)
toc