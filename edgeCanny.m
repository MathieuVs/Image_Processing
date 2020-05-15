function edge = edgeCanny(image, filterSize, sigma)
    h = fspecial('log',filterSize,sigma);
    edge = filter2(h,image);
    edge = zerocros(edge);
    