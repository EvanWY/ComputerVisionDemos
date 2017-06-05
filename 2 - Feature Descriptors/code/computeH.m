function H2to1 = computeH(p1,p2)
% INPUTS:
% p1 and p2 - Each are size (2 x N) matrices of corresponding (x, y)'  
%             coordinates between two images
%
% OUTPUTS:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear 
%         equation
    N = size(p1, 2);
    A = zeros(N * 2, 9);
    
    
    for i = 1 : N
        x1 = p1(1,i);
        y1 = p1(2,i);
        x2 = p2(1,i);
        y2 = p2(2,i);
        
        A(2*i-1, :) = [x1, y1,   1,   0,   0,   0,   -x1*x2,   -y1*x2,   -x2];
        A(2*i, :)   = [0,   0,   0,  x1,  y1,   1,   -x1*y2,   -y1*y2,   -y2];
    end
    
    h = A\zeros(2*N, 1);
    
    H2to1 = reshape(h, 3, 3)';
    
end