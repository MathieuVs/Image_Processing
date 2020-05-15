function edge = edgeCannyHSV(image, edgeHSVparam) 
    filterSize = edgeHSVparam(1); sigma = edgeHSVparam(2); treshold = edgeHSVparam(3);
%im = imread('totoro.jpg');
    %imagesc(image);
    image = rgb2hsv(image);
    hue = image(:,:,1);
    saturation = image(:,:,2);
    value = image(:,:,3);
    
    h = fspecial('log',filterSize,sigma);
    edgeH = filter2(h,hue);
    gradH = EdgeSobelPrewitt(edgeH, 'prewitt');
    edgeH = zerocros(edgeH).*gradH;
    edgeH = double(edgeH>=treshold);
    
    edgeS = filter2(h,saturation);
    gradS = EdgeSobelPrewitt(edgeS, 'prewitt');
    edgeS = zerocros(edgeS).*gradS;
    edgeS = double(edgeS>=treshold);
    
    edgeV = filter2(h,value);
    gradV = EdgeSobelPrewitt(edgeV, 'prewitt');
    edgeV = zerocros(edgeV).*gradV;
    edgeV = double(edgeV>=treshold);
    
    edge = not(edgeH | edgeS | edgeV);
%     edgeRGB(:,:,1)=edge(:,:);edgeRGB(:,:,2)=edge(:,:);edgeRGB(:,:,3)=edge(:,:);
%     figure;
%     imagesc(edgeRGB);