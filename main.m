% Last modified: 25th of march 2017
% Main script for the project "Analysis of the piece Vocalise by
% Rachmaninoff", developed by Helena Cuesta for the Audio and Music
% Processing Lab from the Sound and Music Computing master @ Universitat
% Pompeu Fabra, Barcelona.
% Questions, requests and comments should be sent to:
% helena -DOT- cuesta01 -AT- estudiant -DOT- upf -DOT- edu

clear all; close all;

%% Structure analysis

structure_extraction;

%% Melodic analysis

% We perform an analysis of the melodic line of the piece splitting it into
% the parts that have been found in the previous step. For more information
% about this, read the report in the paper linked in the repository.

addpath('./data')

% load MIDI file for Vocalise
nmat = readmidi('vocalise.mid');

% semi-automatic - structure boundaries in seconds, from the structure
time_boundaries = [0,93;...
    94,183;...
    184,252;...
    253,321;...
    322,370];

nmat_ch0 = getmidich(nmat,0); % get first channel - cello melody
nmat_ch1 = getmidich(nmat,1); % get second channel - piano accompaniment

bpm = gettempo(nmat);
nmat_ch0 = checkOverlap(nmat_ch0,bpm);

% Split parts A, AA, B, BB, C
nmat_A = onsetwindow(nmat_ch0,time_boundaries(1,1),time_boundaries(1,2),'sec');
nmat_AA = onsetwindow(nmat_ch0,time_boundaries(2,1),time_boundaries(2,2),'sec');
nmat_B = onsetwindow(nmat_ch0,time_boundaries(3,1),time_boundaries(3,2),'sec');
nmat_BB = onsetwindow(nmat_ch0,time_boundaries(4,1),time_boundaries(4,2),'sec');
nmat_C = onsetwindow(nmat_ch0,time_boundaries(5,1),time_boundaries(5,2),'sec');



% extract pitch-class and pitch interval distributions
melodyAnalysis;

%% Vocalise-based composition
% Use HMM to generate melodies based on Vocalise distributions

% read transition matrices
trans_mat_A = csvread('transition_mat_A.csv');
trans_mat_B = csvread('transition_mat_B.csv');
trans_mat_C = csvread('transition_mat_C.csv');

new_A = useHMM(nmat_A,trans_mat_A,pitch_class_dist_A);
new_AA = useHMM(nmat_AA,trans_mat_A,pitch_class_dist_A);
new_B = useHMM(nmat_B,trans_mat_B,pitch_class_dist_B);
new_BB = useHMM(nmat_BB,trans_mat_B,pitch_class_dist_B);
new_C = useHMM(nmat_C,trans_mat_C,pitch_class_dist_C);

% Concatenate the generated melodies following Vocalise structure

new_midi = [new_A;new_AA;new_B;new_BB;new_C];
filename = 'vocalise_new_comp.midi';
writemidi(new_midi,filename,bpm);

%% Similarity analysis
% Compute melodic similarity based on the melodic contours between Vocalise
% and the new composition
originalmidi = [nmat_A;nmat_AA;nmat_B;nmat_BB;nmat_C];
sim = melodicSimilarity(originalmidi,new_midi);
strcat({'The dissimilarity between the new composition and Vocalise is '},num2str(sim))
