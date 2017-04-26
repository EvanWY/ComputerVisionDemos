function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    M = size(img,1);
    N = size(img,2);
    
    filterResponse = extractFilterResponses(img, filterBank);
    shiftedFilterResponse = shiftdim(filterResponse, 2);
    reshapedFilterResponse = reshape(shiftedFilterResponse, size(shiftedFilterResponse, 1), []);
    
    [~, ClosestIdx] = pdist2(dictionary',reshapedFilterResponse','euclidean','Smallest',1);
    
    wordMap = reshape(ClosestIdx, M, N);
end
