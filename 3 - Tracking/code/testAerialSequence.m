% load frames
load('data/aerialseq.mat')

% implementation
[M,N,frameCount] = size(frames);

for i = 2 : frameCount
    mask = SubtractDominantMotion(frames(:,:,i-1), frames(:,:,i));
    doubleFi = im2double(frames(:,:,i));
    fm = max(doubleFi , double(mask));
    imshow([repmat([doubleFi, ones(M,30)], 1,1,3)*255, imfuse(frames(:,:,i), fm, 'Scaling','none','ColorChannels',[1 2 2])]);
end