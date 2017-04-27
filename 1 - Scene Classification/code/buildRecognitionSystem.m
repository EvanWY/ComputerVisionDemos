function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../data/traintest.mat');

	train_features = [];
    
    for i = 1 : length(train_imagenames)
        imgname = strcat('../data/', strrep(train_imagenames{i}, '.jpg', '.mat'));
        fprintf('%d: %s\n', i, imgname);
        load(imgname);
        h = getImageFeaturesSPM(3, wordMap, size(dictionary,2));
        train_features(:,i) = h;
    end

	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end