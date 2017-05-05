[locsDoG, GaussianPyramid] = DoGdetector(testimage, 1, sqrt(2), [-1 0 1 2 3 4], 0.03, 12);
I = GaussianPyramid(:,:,1);

for i = 1 : size(locsDoG, 2)
    coloridx = locsDoG(3,i);
    
    I = insertShape(I,'circle',[locsDoG(2,i) locsDoG(1,i) 0],'LineWidth',2,'Color', [1-0.2*coloridx,0.2*coloridx,128]);
end

imshow(I);

imwrite(I, 'keypoints3.png');

[locsDoG, GaussianPyramid] = DoGdetector(testimage, 1, sqrt(2), [-1 0 1 2 3 4], 0.03, 999999999);
I = GaussianPyramid(:,:,1);

for i = 1 : size(locsDoG, 2)
    coloridx = locsDoG(3,i);
    
    I = insertShape(I,'circle',[locsDoG(2,i) locsDoG(1,i) 0],'LineWidth',2,'Color', [1-0.2*coloridx,0.2*coloridx,128]);
end

imshow(I);

imwrite(I, 'keypoints_without_edge_supression3.png');