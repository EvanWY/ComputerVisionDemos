function [locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k, ...
                                        levels, compareA, compareB)
%%Compute BRIEF feature
% INPUTS
% im      - a grayscale image with values from 0 to 1
% locsDoG - locsDoG are the keypoint locations returned by the DoG detector
% levels  - Gaussian scale levels that were given in Section1
% compareA and compareB - linear indices into the patchWidth x patchWidth image 
%                         patch and are each nbits x 1 vectors
%
% OUTPUTS
% locs - an m x 3 vector, where the first two columns are the image coordinates 
%		 of keypoints and the third column is the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. m is the number of 
%        valid descriptors in the image and will vary
    locs = [];
    desc = [];
    for idx = 1:size(locsDoG, 1)
        x = locsDoG(idx, 2);
        y = locsDoG(idx, 1);
        d = floor(9 / 2);
        
        patch = [];
        
        flag = 1;
        
        try
            patch = reshape(im(x - d : x + d, y - d : y + d), [], 1);
        catch e
            flag = 0;
        end
        
        if flag == 1
            locs = [locs; locsDoG(idx, :)];
            desc = [desc; (patch(compareB) > patch(compareA))'];
        end
            
    end

end