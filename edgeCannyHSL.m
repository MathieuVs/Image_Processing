function edge = edgeCannyHSL(image, filterSize, sigma, treshold) 
%im = imread('totoro.jpg');
    %imagesc(image);
    hue = image(:,:,1);
    saturation = image(:,:,2);
    lightness = image(:,:,3);
    
    h = fspecial('log',filterSize,sigma);
    edgeH = filter2(h,hue);
    gradH = EdgeSobelPrewitt(edgeH, 'prewitt');
    edgeH = zerocros(edgeH).*gradH;
    edgeH = double(edgeH>=treshold);
    
    edgeS = filter2(h,saturation);
    gradS = EdgeSobelPrewitt(edgeS, 'prewitt');
    edgeS = zerocros(edgeS).*gradS;
    edgeS = double(edgeS>=treshold);
    
    edgeL = filter2(h,lightness);
    gradL = EdgeSobelPrewitt(edgeL, 'prewitt');
    edgeL = zerocros(edgeL).*gradL;
    edgeL = double(edgeL>=treshold);
    
    edge = not(edgeH | edgeS | edgeL);
%     edgeRGB(:,:,1)=edge(:,:);edgeRGB(:,:,2)=edge(:,:);edgeRGB(:,:,3)=edge(:,:);
%     figure;
%     imagesc(edgeRGB);