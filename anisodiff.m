function [outimage] = anisodiff(image,iteration,k)

lambda = 0.10;

outimage = image;

[m,n] = size(image);

rowC = [1:m]; rowN = [1 1:m-1]; rowS = [2:m m];

colC = [1:n]; colE = [1 1:n-1]; colW = [2:n n];

for i = 1:iteration

deltaN = outimage(rowN,colC)-outimage(rowC,colC);

deltaE = outimage(rowC,colE)-outimage(rowC,colC);

fluxN = deltaN.*exp(-(1/k)*abs(deltaN));

fluxE = deltaE.*exp(-(1/k)*abs(deltaE));


outimage = outimage +lambda *(fluxN -fluxN(rowS,colC) + fluxE - fluxE(rowC,colW));

end;
