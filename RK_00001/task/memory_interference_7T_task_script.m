function memory_interference_7T_task_script(day,blue, Subj_ID, Subj_age, Subj_hand, Subj_gender, stim1, stim2,stim3, stim4,stim5, stim6, stim7, run)

% set up PTB
PsychDefaultSetup(2);
Screen('CloseAll')
screens = Screen('Screens');
rng('shuffle');
KbName('UnifyKeyNames');

root = '/Users/renee/Documents/Github/memory_interference/task';

imageFolder = fullfile(root, 'Stims');

format long; %ensure RT is to multiple decimal places

% store subject data
DATA.subject.ID = Subj_ID;
DATA.subject.age = Subj_age;
DATA.subject.hand = Subj_hand;
DATA.subject.gender = Subj_gender;
DATA.stims1to7 = ([stim1, stim2, stim3, stim4, stim5, stim6, stim7]);

%% Set up
% n_stim_pairs = (length(DATA.stims1to7)*(length(DATA.stims1to7)-1));%gives total number of pairs, where A-B ~= B-A
%  %must be even number
% DATA.n_trials = n_stim_pairs*n_stim_pairs_rep; % number of times to repeat- this gives 14 of each trial type in total where A-B = B-A

% Timing
DATA.Times.dur_stim   = 0.8;
DATA.Times.dur_ISI   = 0.3;


%Set up button press monitoring when running outside scanner
ttl_number;
keylist=ones(1,256);
% keylist_idx = logical([ones(1,256)]);
 KbQueueCreate(device,keylist);
 KbQueueStart();

key = KbName('Space');

%Create Trial Matrix
generate_stim_mat_scan_task;
DATA.stim_mat = stim_mat;

%Example bitmap size
m=imread(fullfile(imageFolder,'SS0_1.bmp'));
[y,x,~]=size(m);
bmp_size= [0,0,x,y];

%Load ITIs and randomise
load('ITI_mat_gam_mean_2p9s_min_1p5s'); % loads variable itis
itis = itis(randperm(length(itis)));

for screen = screens
    fprintf('\n***** ScreenTest: Testing Screen %d *****\n',screen);
    Screen('Preference', 'SyncTestSettings', 0.01);
    
    PsychDebugWindowConfiguration
    [w, ~] = Screen(screen, 'OpenWindow');
    Screen('TextSize', w,  16);
    
    %dummy calls
    KbCheck;
    WaitSecs(0.1);
    GetSecs;
    
    priorityLevel=MaxPriority(w);
    Priority(priorityLevel);
    
    % Create directory and file name in which to save subject data
    if(run ==1)
        if ~exist(fullfile(root, 'results',Subj_ID),'dir')
            mkdir(fullfile(root,'results',Subj_ID));
        end
    end
    
    if ~exist(fullfile(root, 'results', Subj_ID, ['scan_task_' Subj_ID '_day' num2str(day) '_run' num2str(run) '.mat']),'file')
        datafile    = fullfile(root, 'results', Subj_ID, ['scan_task_' Subj_ID '_day' num2str(day) '_run' num2str(run) '.mat']);
    else
        fprintf('/n/n/nA file with this subject and session number already exists!\nPlease specify other name...')
        return
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Run experiment
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %instructions
    if blue==1
        message = 'Hello - you are about to start the scan task! On each trial \n \n you will be shown two consecutive stimuli and the background  \n \n colour will either be blue, as seen in day 1 of your training, or  \n \n yellow, as seen in day 2 of your training. Your task is to spot \n \n  those stimuli that are different from the 7 stimuli that you saw \n \n during the training on day 1 and 2. There are 20 "incorrect" stimuli \n \n in total and when you spot one, press space \n \n after the pair has been shown. You \n \n will receive 20p for each of the "incorrect" stimuli that you spot.  \n \n Please try to concentrate on looking carefully at \n \n  all the shapes throughout. \n \n \n Press the mouse to start the task...';
    elseif blue==2
            message = 'Hello - you are about to start the scan task! On each trial \n \n you will be shown two consecutive stimuli and the background  \n \n colour will either be yellow, as seen in day 1 of your training, or  \n \n blue, as seen in day 2 of your training. Your task is to spot \n \n  those stimuli that are different from the 7 stimuli that you saw \n \n during the training on day 1 and 2. There are 20 "incorrect" stimuli \n \n in total and when you spot one, press space \n \n after the pair has been shown. You \n \n will receive 20p for each of the "incorrect" stimuli that you spot.  \n \n Please try to concentrate on looking carefully at \n \n  all the shapes throughout. \n \n \n Press the mouse to start the task...';
    end
    
    DrawFormattedText(w, message, 'center', 'center', [0 0 0]);
    Screen('Flip', w);
        
    GetClicks(w);
        
    Screen('Flip', w);
    
    %loop through trials
    for t=1:length(stim_mat)
        rt=NaN;
        correct=0;

        [~, ~, ~]=KbCheck;
        if stim_mat(t,7)==1
            KbQueueFlush();
        end
     
        if t==1
            DATA.start_time = GetSecs;     
        end

        if (blue == 1 && stim_mat(t,3)==1) || (blue == 2 && stim_mat(t,3)==2)
            Screen('FillRect', w, [0 0 255]); % Make background blue
            Screen('Flip', w);
        elseif (blue == 1 && stim_mat(t,3)==2) || (blue == 2 && stim_mat(t,3)==1)
            Screen('FillRect',w,[255 255 0]); % Make background yellow
            Screen('Flip', w);
        end
        Screen('Flip', w);
        WaitSecs(0.6);
        
        % load and display images
        if stim_mat(t,7)==0
            img1 = imread(fullfile(imageFolder,['SS' ,num2str(DATA.stims1to7(stim_mat(t,1))-1), '_' num2str(stim_mat(t,4)) '.bmp'])); % load s1
            img2 = imread(fullfile(imageFolder,['SS' ,num2str(DATA.stims1to7(stim_mat(t,2))-1), '_' num2str(stim_mat(t,5)) '.bmp'])); % load s2
        elseif stim_mat(t,7)==1 && stim_mat(t,8)==1
            img1 = imread(fullfile(imageFolder,['SS' ,num2str(stim_mat(t,9)-1), '.bmp'])); %load incorrect shape
            img2 = imread(fullfile(imageFolder,['SS' ,num2str(DATA.stims1to7(stim_mat(t,2))-1), '_' num2str(stim_mat(t,5)) '.bmp'])); % load s2
        elseif stim_mat(t,7)==1 && stim_mat(t,8)==2
            img1 = imread(fullfile(imageFolder,['SS' ,num2str(DATA.stims1to7(stim_mat(t,1))-1), '_' num2str(stim_mat(t,4)) '.bmp'])); % load s1
            img2 = imread(fullfile(imageFolder,['SS' ,num2str(stim_mat(t,9)-1), '.bmp'])); %load incorrect shape
        end
        imageDisplay1=Screen('MakeTexture', w, img1);
        imageDisplay2=Screen('MakeTexture', w, img2);
        
        % display s1
        Screen('DrawTexture', w, imageDisplay1,[], [(350+bmp_size(1)),(200+bmp_size(2)),(350+bmp_size(3)),(200+bmp_size(4))]); % image position set
        Screen('Flip', w);
        time_stamp_s1 = GetSecs-DATA.start_time;
        WaitSecs(DATA.Times.dur_stim);
        Screen('Flip', w);
        
        WaitSecs(DATA.Times.dur_ISI);
        
        % display s2
        Screen('DrawTexture', w, imageDisplay2,[], [(350+bmp_size(1)),(200+bmp_size(2)),(350+bmp_size(3)),(200+bmp_size(4))]); % image position set
        Screen('Flip', w);
        time_stamp_s2 = GetSecs - DATA.start_time;
        time_stamp_s2_true = GetSecs;
        WaitSecs(DATA.Times.dur_stim);
        Screen('Flip', w);
        
        % if task trial check for response
        if stim_mat(t,7)==1
            while (GetSecs) < (time_stamp_s2_true + DATA.Times.dur_stim + itis(t) - 0.6)
                [~,~,KeyCode] = KbCheck;
                if KeyCode(key) == 1
                    rt = (GetSecs-DATA.start_time) - time_stamp_s2 - DATA.Times.dur_stim;
                    correct = 1;
                end
            end
        end
        
        while (GetSecs)< (time_stamp_s2_true + DATA.Times.dur_stim + itis(t) - 0.6)
            WaitSecs(0.1);
        end
        
        % save trial info
        DATA.exp_data(t,1:9)=stim_mat(t,1:9);
        DATA.exp_data(t,10)=time_stamp_s1;
        DATA.exp_data(t,11)=time_stamp_s2;
        DATA.exp_data(t,12)=rt;
        DATA.exp_data(t,13)=correct;
        DATA.exp_data(t,14)=itis(t);
        save(datafile,'DATA');
        
        % end of session message
        if t==length(stim_mat)
            Screen('FillRect', w, [255 255 255]);
            Screen('Flip', w);
            n_correct = sum(DATA.exp_data(find(DATA.exp_data(:,7)==1),13)); 
            earning = n_correct*0.2;
            accuracy= round(100*(n_correct/length(find(DATA.exp_data(:,7)==1))));
            feedb_tx= ['Great- that''s the end of the task block. \n\n You spotted ' num2str(accuracy) '% of the "incorrect shapes \n\n and earned £' num2str(earning) '!'];
            DrawFormattedText(w, feedb_tx, 'center', 'center', [0 0 0]);
            Screen('Flip', w);
            
            DATA.results.accuracy = accuracy;
            DATA.results.earnings =earning;
            save(datafile,'DATA');
            
            GetClicks(w);
            Screen('Flip', w);
        end
    end
end

Screen('Close',w);

fprintf('\n***** ScreenTest: Done With Screen %d *****\n',screen);
end
