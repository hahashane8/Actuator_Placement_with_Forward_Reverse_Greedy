x=0:0.001:1

y1 = x.^3./(1+x.^3);
y2 = x.^2./(1+x).^2;

plot(x,y1)
hold on
plot(x,y2)
plot(0.5,0.11,'*')