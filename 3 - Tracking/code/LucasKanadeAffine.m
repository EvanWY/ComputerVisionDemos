function Mat = LucasKanadeAffine(It, It1)

% input - image at time t, image at t+1 
% output - M affine transformation matrix
    
    %rect = [60, 117, 146, 152]
    %rect = [1,1,size(It)];
    It = im2double(It);
    T = It;
    It1 = im2double(It1);
    %I = It1;
    
    [GTx, GTy] = imgradientxy(T);
    [M,N] = size(T);
    
    SDI = zeros(M,N,6);
    SDI(:,:,1) = repmat([1:N]/N,M,1) .* GTx;
    SDI(:,:,2) = repmat([1:N]/N,M,1) .* GTy;
    SDI(:,:,3) = repmat(([1:M]/M)',1,N) .* GTx;
    SDI(:,:,4) = repmat(([1:M]/M)',1,N) .* GTy;
    SDI(:,:,5) = ones(M,N) .* GTx;
    SDI(:,:,6) = ones(M,N) .* GTy;
    
    H = zeros(6,6);
    for i = 1:6
        for j = 1:6
            H(i,j) = sum(sum(SDI(:,:,i).*SDI(:,:,j)));
        end
    end
    
    InvH = inv(H);
    
    p = [0;0;0;0;0;0];
    Mp = [p(1)+1, p(3), p(5); p(2), p(4)+1, p(6); 0, 0, 1];
    
    for ii = 1:1200
        %subplot(4,4,ii)
        
        WarpMat = Mp; 
        XYq = ones(3,M,N);
        XYq(1,:,:) = repmat([1:M]'/M, 1, N);
        XYq(2,:,:)= repmat([1:N]/N, M, 1);
        XYq = reshape(WarpMat * reshape(XYq, 3, []), 3, M, N);
        I = interp2(It1, reshape(XYq(2,:,:)*N,M,N), reshape(XYq(1,:,:)*M,M,N), 'linear', -1);


        ErrorImage = (I - T) .* (I>-0.5);
        %imshow(ErrorImage)
        
        %imshow(SDI(:,:,i) .* ErrorImage);
        montage([It1, I, ErrorImage + 0.5, T, GTx + 0.5, GTy + 0.5; reshape(SDI.* repmat(ErrorImage,1,1,6) * 10, M, N*6)])

        SD = [0;0;0;0;0;0];
        for i = 1:6
            SD(i) = sum(sum(SDI(:,:,i) .* ErrorImage));
        end

        dp = InvH * SD * 0.1;

         dp = [-dp(1)-dp(1)*dp(4)+dp(2)*dp(3); 
             -dp(2); 
             -dp(3); 
             -dp(4)-dp(1)*dp(4)+dp(2)*dp(3);
             -dp(5)-dp(4)*dp(5)+dp(3)*dp(6);
             -dp(6)-dp(1)*dp(6)+dp(2)*dp(5)] / ((1+dp(1))*(1+dp(4)) - dp(2)*dp(3));
         
         dp
         
         p = [p(1)+dp(1)+p(1)*dp(1)+p(3)*dp(2);
             p(2)+dp(2)+p(2)*dp(1)+p(4)*dp(2);
             p(3)+dp(3)+p(1)*dp(3)+p(3)*dp(4);
             p(4)+dp(4)+p(2)*dp(3)+p(4)*dp(4);
             p(5)+dp(5)+p(1)*dp(5)+p(3)*dp(6);
             p(6)+dp(6)+p(2)*dp(5)+p(4)*dp(6);];

        %Mdp = [dp(1)+1, dp(3), dp(5); dp(2), dp(4)+1, dp(6); 0, 0, 1];
        %Mp = inv(Mdp * Mp);
        Mp = [p(1)+1, p(3), p(5); p(2), p(4)+1, p(6); 0, 0, 1];
        %Mp = [1, 0, p(5); 0, 1, p(6); 0, 0, 1];
    end
    
    subplot(4,4,13),imshow(It)
    subplot(4,4,14),imshow(It1)
    
end