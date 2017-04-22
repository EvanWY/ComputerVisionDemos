function [ warp_im ] = warpA( im, A, out_size )
% warp_im=warpAbilinear(im, A, out_size)
% Warps (w,h,1) image im using affine (3,3) matrix A 
% producing (out_size(1),out_size(2)) output image warp_im
% with warped  = A*input, warped spanning 1..out_size
% Uses nearest neighbor mapping.
% INPUTS:
%   im : input image
%   A : transformation matrix 
%   out_size : size the output image should be
% OUTPUTS:
%   warp_im : result of warping im by A

warp_im = zeros(out_size);

A = inv(A);
for i=1:out_size(1)
    for j=1:out_size(2)
        pos = round(A * [j,i,1]');
        if (pos(2) <=0 || pos(2) >out_size(1) || pos(1) <=0 || pos(1) >out_size(2) )
            warp_im(i,j) = 0;
        else
            warp_im(i,j)=im(pos(2),pos(1));
        end
    end
end

end