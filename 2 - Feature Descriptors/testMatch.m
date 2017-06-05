%im2 = imrotate(im1, 25);

[locs1, desc1] = briefLite(rgb2gray(im1));
[locs2, desc2] = briefLite(rgb2gray(im2));

[matches] = briefMatch(desc1, desc2, 0.97);

plotMatches(im1, im2, matches, locs1, locs2);