function [ sim_measure ] = melodicSimilarity(nmat1,nmat2,frameSize)
% This function takes two note matrices as input (nmat1 and nmat2) and
% comuputes a similarity measure based on the melodic similarity
% implemented in MIDI Toolbox (meldistance using 'contour'
% characteristics). The third input parameter is the size of the frame for
% the similarity analysis, frameSize=10 by default.

if nargin < 3
    frameSize = 10;
%

dst = []; 
k=0;
for i=1:length(nmat1)-frameSize
    k=k+1;
    win_mel_A = nmat1(i:i+frameSize,:);
    win_mel_new = nmat2(i:i+frameSize,:);
    dst(k) = meldistance(win_mel_A,win_mel_new,'contour','cosine');
end

dst = dst / max(dst); % normalize values

% plot(dst)

sim_measure = mean(dst);

end

