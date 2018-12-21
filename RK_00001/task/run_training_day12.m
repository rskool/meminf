% script to run the training task performed by participants on day 1 and 2

expday =1; %1 for training day 1, 2 for training day 2, 3 for day 3 test
day1_colour = 1; % 1 for first day blue and second day yellow, 2 for vice versa. Don't change for the same subject
subj_ID = 'S1'; 
subj_age = 22;
subj_hand = 'r';
subj_gender = 'f';

%prior to the first run on day 1, run randperm(7) to obtain a random
%order of stimuli within the circle. these number are kept the same
%througout the experiment
stim1 = 2; stim2 = 4; stim3 = 7; stim4 = 1; stim5 = 5; stim6 = 7; stim7 = 3;

%change after completion of each run
run = 1;

% NB before running, make appropriate edits in
% associative_training_learning script.

if day ==1 || day ==2
    associative_training_learning(expday, day1_colour, subj_ID, subj_age, subj_hand, subj_gender, stim1, stim2,stim3, stim4,stim5, stim6, stim7, run)
elseif day== 3
    associative_test_pairing(expday, day1_colour, subj_ID, subj_age, subj_hand, subj_gender, stim1, stim2,stim3, stim4,stim5, stim6, stim7, run)
end

