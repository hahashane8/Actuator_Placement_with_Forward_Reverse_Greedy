function funcval = fun(adjG,B,t)     funcval = expm(adjG * t) * B * B' * (expm((adjG) * t))';
