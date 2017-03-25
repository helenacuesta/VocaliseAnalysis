%%
% This code reads a midi file and performs some operations to extract some
% meaningful structure based on symbolic information.

% Code for the first presentation of the project: 
% Structure extraction using self-similarity matrices computed from
% symbolic information (melody extracted from the MIDI) and audio
% information (harmonic pitch-class profiles).
%%
addpath('./data');

% load MIDI file for Vocalise
nmat = readmidi('vocalise.mid');

%% Symbolic structure analysis
nmat_ch0 = getmidich(nmat,0); % get first channel - cello melody

% pitch values are in the 4th column of the matrix
% Check melody self-similarity
mel = nmat_ch0(:,4);
dur = nmat_ch0(:,7);
A = [mel, dur];

xaxis = nmat_ch0(:,6);
S = squareform(pdist(A, 'euclidean'));
% 
figure(1);
imagesc(xaxis,xaxis,S), set(gca,'YDir','normal')
title('Self-distance matrix of the pair melody-note duration')
xlabel('Seconds')
ylabel('Seconds')


%% Audio-based self-similarity analysis - HPCP
features = csvread('HPCP_vocalise.csv');
S = squareform(pdist(features, 'euclidean'));
hopsize = 5512;
L = (size(features,1)*hopsize) / 44100; % length of the audio
xaxis = linspace(0,L);

figure(2);
imagesc(xaxis,xaxis,S), set(gca,'YDir','normal')
title('Self-distance matrix of the HPCP descriptors for the whole audio')
xlabel('Seconds')
ylabel('Seconds')


