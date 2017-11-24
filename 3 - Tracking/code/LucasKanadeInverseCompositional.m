function [u,v] = LucasKanadeInverseCompositional(It, It1, rect)

% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [u,v] in the x- and y-directions.
    T = It(rect(2):rect(4),rect(1):rect(3));
    %I = It1;
    
    [GTx, GTy] = imgradientxy(T);
    [M,N] = size(T);
    
    SDI = zeros(M,N,2);
    SDI(:,:,1) = ones(M,N)*0.5 .* GTy;
    SDI(:,:,2) = ones(M,N)*0.5 .* GTx;
    
    H = zeros(2,2);
    for i = 1:2
        for j = 1:2
            H(i,j) = sum(sum(SDI(:,:,i).*SDI(:,:,j)));
        end
    end
    
    InvH = inv(H);
    
    p = [0;0];
    
    
    for ii = 1:12000
        %%%%%%%
        %Xq = repmat([1:M]' + (p(1)+rect(1)), 1, N);
        %Yq= repmat([1:N] + (p(2)+rect(2)), M, 1);
        Xq = repmat([1:M]' + (p(1)+rect(2)), 1, N);
        Yq= repmat([1:N] + (p(2)+rect(1)), M, 1);
        I = interp2(im2double(It1), Yq, Xq);
        
        imshow(I)

        ErrorImage = I - im2double(T);
        %imshow(ErrorImage*10+0.5);

        SD = [0;0];
        for i = 1:2
            SD(i) = sum(sum(SDI(:,:,i) .* ErrorImage));
        end

        dp = InvH * SD;

        p = p - dp*1000;
        
        [dp, p, [ii;0]]
    end
    
end



