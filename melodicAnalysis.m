function [ PD,PID ] = melodicAnalysis(nmat,strPD,strPID)
% This code takes a note matrix as input and computes the pitch
% distribution and the pitch interval distribution. It checks if there are
% overlapping notes (in monophonic) and if so, it modifies the note matrix
% to avoid them.
% strPD and strPID are the titles of the plots of the pitch class
% distribution and the pitch interval distribution respectively

bpm = gettempo(nmat);
PD = pcdist1(nmat);
figure(1);
plotdist(PD)
title(strPD)
xlabel('Pitch classes')

for i=1:size(nmat,1)-1
    
    if ((nmat(i,1) + nmat(i,2)) >= nmat(i+1,1))
        nmat(i+1,1)= nmat(i,1) + nmat(i,2) + 0.02;
        nmat(i+1,6) = nmat(i+1,1)*(60/bpm);       
    end
    nmat(i,3) = 1;
end
nmat(end,3) = 1;

PID = ivdist1(nmat);
figure(2);
plotdist(PID)
title(strPID)
xlabel('Pitch interval - from descending perfect octave to ascending perfect octave')

end

