function edges = EdgeSobelPrewitt(image, method)
    edges = zeros(size(image));
    if strcmp(method, 'sobel')
        operator = [-1 0 1; -1 0 1; -1 0 1];
    elseif strcmp(method, 'prewitt')
        operator = [-1 0 1; -2 0 2; -1 0 1];
    else
        error('Wrong operator chosen')
    end
    edgeV = filter2(operator,image);
    edgeH = filter2(operator',image);
    edges = sqrt(edgeV.^2 + edgeH.^2);
    save("test",'edges');
end