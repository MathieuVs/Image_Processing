function mb = zerocros(x)

[szx, szy] = size(x);
mb=zeros(szx, szy);
for ii=2:szx
    for jj=2:szy
        if (x(ii, jj)*x(ii, jj-1) < 0)
            if abs(x(ii, jj)) < abs(x(ii, jj-1))
                mb(ii, jj) = 1;
            else
                mb(ii, jj-1) = 1;
            end
        end
        if  (x(ii-1, jj)*x(ii, jj) < 0)
            if abs(x(ii, jj)) < abs(x(ii-1, jj))
                mb(ii, jj) = 1;
            else
                mb(ii-1, jj) = 1;
            end
        end
    end
end