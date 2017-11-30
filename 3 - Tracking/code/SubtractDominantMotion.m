function mask = SubtractDominantMotion(image1, image2)

% input - image1 and image2 form the input image pair
% output - mask is a binary image of the same size
    Mp = LucasKanadeAffine(image1, image2);
    
    [M,N] = size(image1);
    
    WarpMat = Mp; 
    XYq = ones(3,M,N);
    XYq(1,:,:)= repmat([1:N]/N, M, 1);
    XYq(2,:,:) = repmat([1:M]'/M, 1, N);
    XYq = reshape(WarpMat * reshape(XYq, 3, []), 3, M, N);
    warp1 = interp2(im2double(image1), reshape(XYq(1,:,:)*N,M,N), reshape(XYq(2,:,:)*M,M,N), 'linear', -1);
    
    diff = abs((warp1 - im2double(image2)) .* (warp1 > -0.5)) > 0.1;
    mask = bwareaopen(imdilate(diff, strel('sphere',2)), 100);
    %imshow([image2, diff * 255,mask * 255])

end