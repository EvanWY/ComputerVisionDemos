function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses

    I = RGB2Lab(im2double(img));

    W = size(I, 1);
    H = size(I, 2);
    N = size(filterBank, 1);
    
    %filterResponses = zeros(W, H, 3*N);
    filterResponses = zeros(W, H, 3, N);
    
    for i = 1:N
        if (size(I, 3) == 3)
            %filterResponses(:, :,  3*i-2 : 3*i) = imfilter(I, filterBank(:, :, i));
            filterResponses(:, :, :,  i) = imfilter(I, filterBank{i});
        else
            %filterResponses(:, :,  3*i-2 : 3*i) = imfilter(repmat(I,[1,1,3]), filterBank(:, :, i));
            filterResponses(:, :, :,  i) = imfilter(repmat(I,[1,1,3]), filterBank{i});
        end
    end
end
