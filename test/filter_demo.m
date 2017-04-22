% Download Leung Malik filter bank code from http://www.robots.ox.ac.uk/~vgg/research/texclass/code/makeLMfilters.m
X = makeLMfilters();
[m,m,n] = size(X);

montage(reshape(X,[m m 1 n]),'DisplayRange',[]);

f1 = X(:,:,1);
f1 = X(:,:,2);
imagesc(f1);

rank(f1)

[U,S,V] = svd(f1);
fy = U(:,1)*sqrt(S(1));
fx = V(:,1)*sqrt(S(1));
fx = fx';

figure(1);
subplot(311);
imagesc(fy); axis equal; colormap gray;
subplot(312);
imagesc(fx); axis equal; colormap gray;
subplot(313);
imagesc(fy*fx); axis equal;


% SVD
X = reshape(X,m*m,n);
[U,S,V] = svd(X);

figure(1);
plot(diag(S));

figure(2);
k = 10;
montage(reshape(U(:,1:k),[m m 1 k]),'DisplayRange',[-.1 .1]);

% Show best rank-k approximation
Xr = U(:,1:k) * S(1:k,1:k) * V(:,1:k)';
montage(reshape(Xr,[m m 1 n]),'DisplayRange',[-.1 .1]);