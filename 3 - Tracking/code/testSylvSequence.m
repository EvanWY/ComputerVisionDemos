% load frames
load('data/sylvbases.mat')
load('data/sylvseq.mat')

% implementation
frameSize = size(frames);
frameCount = frameSize(3);

rect = [102-1, 62-1, 156, 108];
rects = [];
rect2 = [102-1, 62-1, 156, 108];

for i = 2 : frameCount
    [u,v] = LucasKanadeBasis(frames(:,:,i-1), frames(:,:,i), rect, bases);
    [u2,v2] = LucasKanadeInverseCompositional(frames(:,:,i-1), frames(:,:,i), rect2);
    rect = rect + [v,u,v,u];
    rect2 = rect2 + [v2,u2,v2,u2];
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
     
     
     for iii = round(rect2(2)) : round(rect2(4))
         IMG(iii, round(rect2(1)), :) = [255,255,0];
         IMG(iii, round(rect2(3)), :) = [255,255,0];
     end
     for jjj = round(rect2(1)): round(rect2(3))
         IMG(round(rect2(2)), jjj, :) = [255,255,0];
         IMG(round(rect2(4)), jjj, :) = [255,255,0];
     end
     
     
     imshow(IMG)
end




% save the rects
save sylvseqrects.mat rects