[locsDoG, GaussianPyramid] = DoGdetector(img2, 1, sqrt(2), [-1 0 1 2 3 4], 0.03, 12);
I = GaussianPyramid(:,:,1);

for i = 1 : size(locsDoG, 1)
    locsDoG(i, :);
    coloridx = locsDoG(i, 3);
    
    I = insertShape(I,'circle',[locsDoG(i, 1) locsDoG(i, 2) 0],'LineWidth',2,'Color', [1-0.2*coloridx,0.2*coloridx,128]);
end

imshow(I);