function [u,v] = LucasKanadeBasis(It, It1, rect, bases)

% input - image at time t, image at t+1, rectangle (top left, bot right
% coordinates), bases 
% output - movement vector, [u,v] in the x- and y-directions.
    M = round(rect(4) - rect(2));
    N = round(rect(3) - rect(1));
    
    Xq0 = repmat([1:M]' + rect(2), 1, N);
    Yq0 = repmat([1:N] + rect(1), M, 1);
    T = interp2(im2double(It), Yq0, Xq0);
    %I = It1;
    
    [GTx, GTy] = imgradientxy(T);
    
    SDI0 = zeros(M,N,2);
    SDI0(:,:,1) = ones(M,N)*0.5 .* GTy;
    SDI0(:,:,2) = ones(M,N)*0.5 .* GTx;
    
    SDQ = zeros(M,N,2);
    basisSize = size(bases);
    basisCount = basisSize(3);
    tempSum = zeros(M,N,2);
    
    tmp = zeros(basisCount,2);
    for i = 1:basisCount
        tmp(i,:) = [sum(sum(bases(:,:,i).*SDI0(:,:,1))), sum(sum(bases(:,:,i).*SDI0(:,:,2)))];
    end
    for m = 1:M
        for n=1:N
            for i = 1:basisCount
                tmp2 = tmp(i,:) * bases(m,n,i);
                tempSum(m,n,:) = tempSum(m,n,:) + reshape(tmp2,1,1,2);
            end
        end
    end
    SDQ = SDI0 - tempSum;
    
    H = zeros(2,2);
    for i = 1:2
        for j = 1:2
            H(i,j) = sum(sum(SDQ(:,:,i).*SDQ(:,:,j)));
        end
    end
    
    InvH = inv(H);
    
    p = [0;0];
    
    for ii = 1:12000
        Xq = repmat([1:M]' + (p(1)+rect(2)), 1, N);
        Yq= repmat([1:N] + (p(2)+rect(1)), M, 1);
        I = interp2(im2double(It1), Yq, Xq);

        ErrorImage = I - T;

        SD = [0;0];
        for i = 1:2
            SD(i) = sum(sum(SDQ(:,:,i) .* ErrorImage));
        end

        dp = InvH * SD;

        p = p - dp;
        
        if (abs(dp(1)) < 0.01 && abs(dp(2)) < 0.01 )
            ii
            break
        end
    end
    
    u = p(1);
    v = p(2);
    return
    
end