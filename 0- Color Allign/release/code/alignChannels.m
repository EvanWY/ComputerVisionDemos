function [rgbResult] = alignChannels(red, green, blue)
% alignChannels - Given 3 images corresponding to different channels of a
%       color image, compute the best aligned result with minimum
%       aberrations
% Args:
%   red, green, blue - each is a matrix with H rows x W columns
%       corresponding to an H x W image
% Returns:
%   rgb_output - H x W x 3 color image output, aligned as desired

%% Write code here
    sz = size(red);
    rgbResult = zeros(sz(1), sz(2) ,3);
    
    maxXg=0;
    maxYg=0;
    minValg=999999999999999;
    for dx = -30:30
        for dy = -30:30
            v = ncc(red,circshift(green,[dx,dy]));
            if (v < minValg)
                minValg = v;
                maxXg = dx;
                maxYg = dy;
            end
        end
    end
    
    maxXb=0;
    maxYb=0;
    minValb=999999999999999;
    for dx = -30:30
        for dy = -30:30
            v = ncc(red,circshift(blue,[dx,dy]));
            if (v < minValb)
                minValb = v;
                maxXb = dx;
                maxYb = dy;
            end
        end
    end
    
    
    rgbResult(:,:,1) = red;
    rgbResult(:,:,2) = circshift(green,[maxXg,maxYg]);
    rgbResult(:,:,3) = circshift(blue,[maxXb,maxYb]);
    rgbResult = rgbResult/255;

end


function [val] = ssd(im1,im2)

    sub = im1-im2;
    endmat = sub.*sub;
    val = sum(sum(endmat));
end

function [val] = ncc(im1,im2)
    im1 = double(im1);
    im2 = double(im2);
    val = - sum(sum(im1.*im2)) / (sqrt(sum(sum(im1.*im1))) * sqrt(sum(sum(im2.*im2))));
end
