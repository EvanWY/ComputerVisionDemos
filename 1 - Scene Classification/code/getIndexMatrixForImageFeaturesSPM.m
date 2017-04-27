function [idxmat] = getIndexMatrixForImageFeaturesSPM(T, B, L, R, level)
    if (level == 0)
        idxmat = [T, B, L, R];
    else
        HC = floor((B - T) / 2) + T;
        WC = floor((R - L) / 2) + L;
        idxmat = [
            getIndexMatrixForImageFeaturesSPM(T, HC, L, WC, level - 1);
            getIndexMatrixForImageFeaturesSPM(T, HC, WC + 1, R, level - 1);
            getIndexMatrixForImageFeaturesSPM(HC + 1, B, L, WC, level - 1);
            getIndexMatrixForImageFeaturesSPM(HC + 1, B, WC + 1, R, level - 1);
            ];
    end
end

