function edge = edgeCannyRGB(image, edgeRGBparam) 
    filterSize = edgeRGBparam(1); sigma = edgeRGBparam(2); treshold = edgeRGBparam(3);
%im = imread('totoro.jpg');
    %imagesc(image);
    red = image(:,:,1);
    blue = image(:,:,2);
    green = image(:,:,3);
    
    h = fspecial('log',filterSize,sigma);
    edgeR = filter2(h,red);
    gradR = EdgeSobelPrewitt(edgeR, 'prewitt');
    edgeR = zerocros(edgeR).*gradR;
    edgeR = double(edgeR>=treshold);
    
    edgeB = filter2(h,blue);
    gradB = EdgeSobelPrewitt(edgeB, 'prewitt');
    edgeB = zerocros(edgeB).*gradB;
    edgeB = double(edgeB>=treshold);
    
    edgeG = filter2(h,green);
    gradG = EdgeSobelPrewitt(edgeG, 'prewitt');
    edgeG = zerocros(edgeG).*gradG;
    edgeG = double(edgeG>=treshold);
    
    edge = not(edgeR | edgeB | edgeG);
%     edgeRGB(:,:,1)=edge(:,:);edgeRGB(:,:,2)=edge(:,:);edgeRGB(:,:,3)=edge(:,:);
%     figure;
%     imagesc(edgeRGB);