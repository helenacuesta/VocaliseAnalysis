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
subplot(1,2,1), plotdist(PD)
title(strPD)
xlabel('Pitch classes')

PID = ivdist1(nmat);
subplot(1,2,2), plotdist(PID)
title(strPID)
xlabel('Pitch interval - from descending perfect octave to ascending perfect octave')

end

