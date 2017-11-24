function [u,v] = LucasKanadeInverseCompositional(It, It1, rect)

% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [u,v] in the x- and y-directions.
    M = round(rect(4) - rect(2));
    N = round(rect(3) - rect(1));
    
    Xq0 = repmat([1:M]' + rect(2), 1, N);
    Yq0 = repmat([1:N] + rect(1), M, 1);
    T = interp2(im2double(It), Yq0, Xq0);
    %I = It1;
    
    [GTx, GTy] = imgradientxy(T);
    
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
        
%         IMG = It1;
%         for iii = round(p(1)+rect(2)) : round(p(1)+rect(2)+M)
%             IMG(iii, round(p(2)+rect(1))) = 255;
%             IMG(iii, round(p(2)+rect(1)+N)) = 255;
%         end
%         for jjj = round(p(2)+rect(1)): round(p(2)+rect(1)+N)
%             IMG(round(p(1)+rect(2)), jjj) = 255;
%             IMG(round(p(1)+rect(2)+M), jjj) = 255;
%         end
%         imshow(IMG)

        ErrorImage = I - T;
        %imshow(ErrorImage*10+0.5);

        SD = [0;0];
        for i = 1:2
            SD(i) = sum(sum(SDI(:,:,i) .* ErrorImage));
        end

        dp = InvH * SD;

        p = p - dp;
        
        if (abs(dp(1)) < 0.01 && abs(dp(2)) < 0.01 )
            break
        end
    end
    
    u = p(1);
    v = p(2);
    return
    
end



