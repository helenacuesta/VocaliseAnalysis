function [new_nmat] = useHMM(nmat,transition_mat,init_prob,transposition_idx)

if nargin < 4
    transposition_idx = 0;
end

pitch_classes = [60,61,62,63,64,65,66,67,68,69,70,71] + transposition_idx;

N = size(nmat,1);
new_nmat = nmat;
[~,states] = hmmgenerate(N,transition_mat,init_prob');
melody = pitch_classes(states);
new_nmat(:,4) = melody;

end

