%
% This code reads a midi file, extracts the melody and computes:
% 1. Pitch class distribution
% 2. Pitch interval distribution
% We do it for parts A,B,C, as the repetitions of A and B are the same and
% will have the same distributions


%%
% ========================
% MELODY ANALYSIS
% ========================

%% PART A

% Obtain the pitch class distribution 
PCstr = 'Pitch Class Distribution of the melodic line in Part A';
PIDstr = 'Pitch Interval Distribution of the melodic line in Part A';
[pitch_class_dist_A, pitch_interval_dist_A] = melodicAnalysis(nmat_A,PCstr,PIDstr);


%% PART B

PCstr = 'Pitch Class Distribution of the melodic line in Part B';
PIDstr = 'Pitch Interval Distribution of the melodic line in Part B';
[pitch_class_dist_B, pitch_interval_dist_B] = melodicAnalysis(nmat_B,PCstr,PIDstr);

%% PART C

PCstr = 'Pitch Class Distribution of the melodic line in Part C';
PIDstr = 'Pitch Interval Distribution of the melodic line in Part C';
[pitch_class_dist_C, pitch_interval_dist_C] = melodicAnalysis(nmat_C,PCstr,PIDstr);




