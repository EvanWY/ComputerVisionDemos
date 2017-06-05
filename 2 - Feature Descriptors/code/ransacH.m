function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
% INPUTS
% locs1 and locs2 - matrices specifying point locations in each of the images
% matches - matrix specifying matches between these two sets of point locations
% nIter - number of iterations to run RANSAC
% tol - tolerance value for considering a point to be an inlier
%
% OUTPUTS
% bestH - homography model with the most inliers found during RANSAC
    maxInliers = 0;
    bestH = [];

    for i = 1 : nIter
        idxm = ceil(rand(4, 1) * size(matches, 1));
        idxm = matches(idxm, :);
        p1 = locs1(idxm(:, 1), 1:2)';
        p2 = locs2(idxm(:, 2), 1:2)';
        H2to1 = computeH(p1, p2);
        
        p1(3,:) = 1;
        p2(3,:) = 1;
        
        p1p = (H2to1 * p1);
        p1p = p1p ./ p1p(3,:);
        
        isinliner = sum(abs(p2 - p1p)) < tol;
        
        cnt = sum(isinliner);
        
        if cnt > maxInliers
            maxInliers = cnt;
            bestH = H2to1;
        end
    end

end