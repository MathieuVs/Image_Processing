function selectedImage = SuperMagicWand(im, ylist, xlist, tolerance, edgeHSVparam, region, colorMatch,edgeFilterHSV)
    %[filterSize, sigma, treshold]=edgeHSVparam;
    clc; close all;


    H = size(im, 1); % image height
    W = size(im, 2); % image width

    c_r = double(im(:, :, 1)); % Red channel
    c_g = double(im(:, :, 2)); % Green channel
    c_b = double(im(:, :, 3)); % Blue channel
    N = length(ylist); % Number of reference pixels
    % Find all pixels whose colors fall within the specified tolerance
    color_mask = false(H, W);
    for idx = 1:length(ylist)
        ref_r = double(im(ylist(idx), xlist(idx), 1));
        ref_g = double(im(ylist(idx), xlist(idx), 2));
        ref_b = double(im(ylist(idx), xlist(idx), 3));
        color_mask = color_mask | ...
                     ((c_r - ref_r) .^ 2 + (c_g - ref_g) .^ 2 + ...
                      (c_b - ref_b) .^ 2) <= tolerance ^ 2;
    end
    edgeColor = EdgeSobelPrewitt(double(color_mask), 'prewitt');
    edgeColor = edgeColor<0.5;

    edgeCHSV = edgeCannyHSV(im, edgeHSVparam);
%     edgeRGB(:,:,1)=edge(:,:);edgeRGB(:,:,2)=edge(:,:);edgeRGB(:,:,3)=edge(:,:);
%     figure;
%     imagesc(edgeRGB);
    edge = true(size(edgeCHSV));
    if colorMatch == 1
        edge = (edge & edgeColor);
    end
    if edgeFilterHSV == 1
        edge = (edge & edgeCHSV);
    end
    
    [objects, count] = bwlabel(edge, region); 
    % Initialize output mask
    bin_mask = false(H, W);
    % Linear indices of reference pixels
    pos_idxs = (xlist - 1) * H + ylist;
    for idx = 1:count
        object = (objects == idx); % an object

        % Add to output mask if the object contains a reference pixel 
        if any(object(pos_idxs))
            bin_mask = bin_mask | object;
        end
    end
    
    bin_mask = imfill(bin_mask,'holes');
    
%     h = [0 0 2 0 0; 0 1 2 1 0; 2 2 2 2 2; 0 1 2 1 0; 0 0 2 0 0];
%     h = h/norm(h);
%     bin_mask = (filter2(double(bin_mask),h)<10);
    
    selectedImage(:,:,1) = (c_r.*double(bin_mask))/256;
    selectedImage(:,:,2) = (c_g.*double(bin_mask))/256;
    selectedImage(:,:,3) = (c_b.*double(bin_mask))/256;
    figure;
    imagesc(selectedImage);

    
    
% figure;
% bin_maskRGB(:,:,1)=bin_mask(:,:);bin_maskRGB(:,:,2)=bin_mask(:,:);bin_maskRGB(:,:,3)=bin_mask(:,:);
% imagesc(bin_maskRGB);