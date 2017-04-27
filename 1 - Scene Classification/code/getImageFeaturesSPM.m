function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    h = zeros(dictionarySize , (4^layerNum - 1)/3);
    [H, W] = size(wordMap);
    
    for level = layerNum - 1 : -1 : 0
        offset = (4^level - 1)/3;
        offset2 = (4^(1+level) - 1)/3;
        
        if level == 2
            indexMat = getIndexMatrixForImageFeaturesSPM(1, H, 1, W, level);
            for idx = 1 : 4^level
                vec = indexMat(idx, :);
                h(:, offset+idx) = getImageFeatures(wordMap(vec(1, 1) : vec(1, 2), vec(1, 3) : vec(1, 4)), dictionarySize) / 32;
            end
        end
        
        if level == 1
            for idx = 1 : 4^level
                h(:, offset+idx) = 0.5 * (h(:, offset2 + (4 * idx) - 3) + h(:, offset2 + (4 * idx) - 2) + h(:, offset2 + (4 * idx) - 1) + h(:, offset2 + (4 * idx) - 0)) / 4;
            end
        end
        
        if level == 0
            for idx = 1 : 4^level
                h(:, offset+idx) = (h(:, offset2 + (4 * idx) - 3) + h(:, offset2 + (4 * idx) - 2) + h(:, offset2 + (4 * idx) - 1) + h(:, offset2 + (4 * idx) - 0)) / 4;
            end
        end
        
    end
end