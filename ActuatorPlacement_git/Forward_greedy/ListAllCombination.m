function A = ListAllCombination(m,n)  if m == 1    A = 1:n;    A = A';    return  end  B = ListAllCombination(m-1,n);  [RowL,ColumbL] = size(B);  cursor = 1;  A = [];   for i = 1 : RowL    for j = 1 : n      if ismember(j,B(i,:)) == 0 && j > B(i,1)        A(cursor, 1) = j;        A(cursor, 2 : m) = B(i,:);        cursor = cursor + 1;      end    end  end  

