% load frames
load('data/carseq.mat')

% implementation
frameSize = size(frames);
frameCount = frameSize(3);

rect = [60, 117, 146, 152];
rects = [];

for i = 2 : frameCount
    [u,v] = LucasKanadeInverseCompositional(frames(:,:,i-1), frames(:,:,i), rect);
    rect = rect + [v,u,v,u];
    rects = [rects;rect];
    %imshow(frames(:,:,i))
    %rectangle('Position',[rect(1), rect(2), rect(3)-rect(1), rect(4)-rect(2)])
     IMG = repmat(frames(:,:,i), 1, 1, 3);
     for iii = round(rect(2)) : round(rect(4))
         IMG(iii, round(rect(1)), :) = [0,255,0];
         IMG(iii, round(rect(3)), :) = [0,255,0];
     end
     for jjj = round(rect(1)): round(rect(3))
         IMG(round(rect(2)), jjj, :) = [0,255,0];
         IMG(round(rect(4)), jjj, :) = [0,255,0];
     end
     imshow(IMG)
end




% save the rects
save carseqrects.mat rects