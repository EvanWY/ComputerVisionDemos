function [u,v] = LucasKanadeInverseCompositional(It, It1, rect)

% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [u,v] in the x- and y-directions.
    T = It(rect(2):rect(4),rect(1):rect(3));
    %I = It1;
    
    [GTx, GTy] = imgradientxy(T);
    [M,N] = size(T);
    
    SDI = zeros(M,N,6);
    SDI(:,:,1) = repmat([1:N]/N,M,1) .* GTx;
    SDI(:,:,2) = repmat([1:N]/N,M,1) .* GTy;
    SDI(:,:,3) = repmat(([1:M]/M)',1,N) .* GTx;
    SDI(:,:,4) = repmat(([1:M]/M)',1,N) .* GTy;
    SDI(:,:,5) = ones(M,N)*0.5 .* GTx;
    SDI(:,:,6) = ones(M,N)*0.5 .* GTy;
    
    H = zeros(6,6);
    for i = 1:6
        for j = 1:6
            H(i,j) = sum(sum(SDI(:,:,i).*SDI(:,:,j)));
        end
    end
    
    InvH = inv(H);
    
    p = [0;0;0;0;0;0];
    
    
    for ii = 1:12
        %%%%%%%
        I = zeros(M,N);
        WarpMat = inv([p(1)+1, p(3), p(5); p(2), p(4)+1, p(6); 0, 0, 1]);
        for i = 1:M
            for j = 1:N
                vec = WarpMat * [i; j; 1];
                I(i,j) = interp2(It1, vec(2)+rect(1),vec(1)+rect(2));
            end
        end
        
        subplot(3,4,ii),imshow(I/255)

        ErrorImage = I/255 - im2double(T);
        %imshow(ErrorImage*10+0.5);

        SD = [0;0;0;0;0;0];
        for i = 1:6
            SD(i) = sum(sum(SDI(:,:,i) .* ErrorImage));
        end

        dp = InvH * SD * 100;

        dp = [-dp(1)-dp(1)*dp(4)+dp(2)*dp(3); 
            -dp(2); 
            -dp(3); 
            -dp(4)-dp(1)*dp(4)+dp(2)*dp(3);
            -dp(5)-dp(4)*dp(5)+dp(3)*dp(6);
            -dp(6)-dp(1)*dp(6)+dp(2)*dp(5)] / ((1+dp(1))*(1+dp(4)) - dp(2)*dp(3));
        
        p = [p(1)+dp(1)+p(1)*dp(1)+p(3)*dp(2);
            p(2)+dp(2)+p(2)*dp(1)+p(4)*dp(2);
            p(3)+dp(3)+p(1)*dp(3)+p(3)*dp(4);
            p(4)+dp(4)+p(2)*dp(3)+p(4)*dp(4);
            p(5)+dp(5)+p(1)*dp(5)+p(3)*dp(6);
            p(6)+dp(6)+p(2)*dp(5)+p(4)*dp(6);]
    end
    
end



