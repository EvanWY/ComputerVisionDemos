function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

    filterBank  = createFilterBank();
    
    ALPHA = 130;
    K = 207;
    
    filter_responses = zeros(ALPHA * length(imPaths), 3 * length(filterBank));
    
    for i = 1 : length(imPaths)
        %DEBUG
        fprintf('building filter_responses, ( %d / %d ), image: "%s"\n', i, length(imPaths), imPaths{i});
        %DEBUG END
        fr = extractFilterResponses(imread(imPaths{i}), filterBank);
        for j = 1 : ALPHA
            vec = shiftdim(fr(randperm(size(fr, 1), 1), randperm(size(fr, 2), 1), :), 1);
            filter_responses(ALPHA * (i-1) + j, :) = vec;
        end
    end
    
    fprintf('finish building filter_responses\n');
    
    fprintf('start kmeans ...\n');
    [~, dictionary] = kmeans(filter_responses, K, 'EmptyAction','drop');
    dictionary = dictionary';
    fprintf('finish kmeans\n');

end
