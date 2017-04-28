function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../data/traintest.mat');
    
    conf = zeros(8, 8);
    counter = 0;

	for imgIdx = 1 : length(test_imagenames)
        imgName = strcat('../data/', strrep(test_imagenames{imgIdx}, '.jpg', '.mat'));
        load(imgName);
        h = getImageFeaturesSPM(3, wordMap, size(dictionary,2));
        distances = distanceToSet(h, train_features);
        [~,nnI] = max(distances);
        conf(test_labels(imgIdx), train_labels(nnI)) = conf(test_labels(imgIdx), train_labels(nnI)) + 1;
        
        if test_labels(imgIdx) == train_labels(nnI)
            counter = counter + 1;
        end
        
        fprintf('evaluating %d: "%s", %s->%s, current accuracy:%f\n', imgIdx, imgName, mapping{test_labels(imgIdx)}, mapping{train_labels(nnI)}, counter/imgIdx);
        
    end

end