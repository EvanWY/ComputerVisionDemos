function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses

    I = img;
    if (size(I,3) == 1)
        I = repmat(I,[1,1,3]);
    end
        
    I = RGB2Lab(im2double(I));

    W = size(I, 1);
    H = size(I, 2);
    N = length(filterBank);
    
    filterResponses = zeros(W, H, 3*N);
    
    for i = 1:N
        filterResponses(:, :,  3*i-2 : 3*i) = imfilter(I, filterBank{i});
    end
end
