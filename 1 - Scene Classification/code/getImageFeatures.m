function [h] = getImageFeatures(wordMap, dictionarySize)
% Compute histogram of visual words
% Inputs:
% 	wordMap: WordMap matrix of size (h, w)
% 	dictionarySize: the number of visual words, dictionary size
% Output:
%   h: vector of histogram of visual words of size dictionarySize (l1-normalized, ie. sum(h(:)) == 1)

    h = zeros(dictionarySize, 1);
    
    [H, W] = size(wordMap);
    
    for i = 1 : H
        for j = 1 : W
            h(wordMap(i,j)) = h(wordMap(i,j)) + 1;
        end
    end
    
    h = h / sum(h);
	
	assert(numel(h) == dictionarySize);
end