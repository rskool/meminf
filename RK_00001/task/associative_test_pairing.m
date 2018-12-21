function associative_test_pairing(expday,blue, Subj_ID, Subj_age, Subj_hand, Subj_gender, stim1, stim2,stim3, stim4,stim5, stim6, stim7, run)

% store subject data
DATA.subject.ID = Subj_ID;
DATA.subject.age = Subj_age;
DATA.subject.hand = Subj_hand;
DATA.subject.gender = Subj_gender;
DATA.stims1to7 = ([stim1, stim2, stim3, stim4, stim5, stim6, stim7]);
DATA.norients = 4;
DATA.blue_or_yellow = blue;

% change root folder accordingly 
root='/Users/renee/Documents/Github/memory_interference/task';
addpath root;

imageFolder = fullfile(root, 'Stims');

% setup psychtoolbox
close all
PsychDefaultSetup(2);
Screen('CloseAll')
screens = Screen('Screens');
KbName('UnifyKeyNames');
HideCursor();

rng('shuffle');

format long; %ensure RT is to multiple decimal places

%% Test set up
DATA.n_Atrials = 50; % 50 trials per context

% Timing
DATA.Times.dur_Stim = 1;
DATA.Times.choice_selc = 0.4;
DATA.Times.feedback = 1;
DATA.Times.max_RT = 3;
trialTimeout = 3;

% Define response and control keys, see http://psychtoolbox-3.googlecode.com/svn/trunk/Psychtoolbox/PsychBasic/KbName.m
key1 = KbName('b'); key2 = KbName('n'); key3 = KbName('m');

%Create Trial Matrix
generate_stim_mat_d3;
DATA.astim_mat = [astim_mat_day1 ones(size(astim_mat_day1,1),1); astim_mat_day2 2*ones(size(astim_mat_day2,1),1)];
DATA.astim_mat = DATA.astim_mat(randperm(size(DATA.astim_mat,1)),:);

%Example bitmap size
m=imread(fullfile(imageFolder,'SS0_1.bmp'));
[y,x,~]=size(m);
bmp_size= [0,0,x,y];

% Test each screen
for screen = screens
    fprintf('\n***** ScreenTest: Testing Screen %d *****\n',screen);

    %% Psychtoolbox setup
    PsychDebugWindowConfiguration;
    Screen('Preference', 'SyncTestSettings', 0.01);
    [w, rect] = PsychImaging('Openwindow',screen,[1 1 1]);
    H=rect(RectBottom);
    Screen('TextSize', w, 24);
    
    % dummy calls
    KbCheck;
    WaitSecs(0.1);
    GetSecs;
    
    priorityLevel=MaxPriority(w);
    Priority(priorityLevel);
    
    % Create directory for subject data     
    if run==1 
        if ~exist(fullfile(root, 'results',Subj_ID),'dir')
            mkdir(fullfile(root,'results',Subj_ID));
        end
    end
    if ~exist(fullfile(root, 'results', Subj_ID, ['test_pairing_' Subj_ID '_day' num2str(expday) '_run' num2str(run) '.mat']),'file')
        datafile    = fullfile(root, 'results', Subj_ID, ['test_pairing_' Subj_ID '_day' num2str(expday) '_run' num2str(run) '.mat']);
    else
        fprintf('\n\n\nA file with this subject and session number already exists!\nPlease specify other name...')
        return
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Run experiment
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% Active test phase
    message = 'On each trial in this part of the experiment you will briefly be shown one shape, as on day1 and day2. \n \n This will be followed by the three remaining shapes. \n \n Your task is to choose the correct shape for the pair, using buttons b, n and m. \n \n  Try to respond as fast as possible, but DON''T COMPROMISE YOUR ACCURACY. \n \n \n Press the mouse to continue with the instructions...';
    DrawFormattedText(w, message, 'center', 'center', [0 0 0]);
    Screen('Flip', w);
    GetClicks(w);
    Screen('Flip', w);
    message = 'Note that the background colour will now change on each trial so your \n\n task is to choose the correct pair, given the background colour. \n\n You will not receive feedback for your choice so try to be as .\n\n accurate as possible. Two of your choices will be chosen at random at the end of the task.  \n\n For each of the 2 trials, if you made a fast correct response \n \n then you will get 50p! \n \n\n Press the mouse to start part 2 of the task...';
    DrawFormattedText(w, message, 'center', 'center', [0 0 0]);
    Screen('Flip', w);
    GetClicks(w);
    Screen('Flip', w);
    
    WaitSecs(1.000);
    
    % loop through stimulus matrix
    for t = 1:size(DATA.astim_mat,1)
        img = imread(fullfile(imageFolder,['SS' ,num2str(DATA.astim_mat(t,1) -1), '_' num2str(DATA.astim_mat(t,5)), '.bmp']));
        
        if (blue==1 && DATA.astim_mat(t,12)==1) || (blue ==2 && DATA.astim_mat(t,12)==2)
                Screen('FillRect', w, [0 0 1]); % Make background blue
                Screen('Flip', w);
        elseif (blue ==2 && DATA.astim_mat(t,12)==2) ||  (blue ==1 && DATA.astim_mat(t,12)==2)
                Screen('FillRect', w, [1 1 0]); % Make background yellow
                Screen('Flip', w);
        end
        
        % present probe stimulus
        imageDisplay=Screen('MakeTexture', w, img);
        Screen('DrawTexture', w, imageDisplay,[], [(500+bmp_size(1)),(300+bmp_size(2)),(500+bmp_size(3)),(300+bmp_size(4))]);
        Screen('Flip', w);
        WaitSecs(DATA.Times.dur_Stim);

        %present choice stimuli
        [~, ~, ~]=KbCheck;
        img1 = imread(fullfile(imageFolder,['SS' ,num2str(DATA.astim_mat(t,(find(DATA.astim_mat(t,9:11)==1)+1))-1), '_', num2str(DATA.astim_mat(t,find(DATA.astim_mat(t,9:11)==1)+5)), '.bmp']));
        img2 = imread(fullfile(imageFolder,['SS' ,num2str(DATA.astim_mat(t,(find(DATA.astim_mat(t,9:11)==2)+1))-1), '_', num2str(DATA.astim_mat(t,find(DATA.astim_mat(t,9:11)==2)+5)), '.bmp']));
        img3 = imread(fullfile(imageFolder,['SS' ,num2str(DATA.astim_mat(t,(find(DATA.astim_mat(t,9:11)==3)+1))-1), '_', num2str(DATA.astim_mat(t,find(DATA.astim_mat(t,9:11)==3)+5)), '.bmp']));
        imageDisplay1=Screen('MakeTexture', w, img1);
        imageDisplay2=Screen('MakeTexture', w, img2);
        imageDisplay3=Screen('MakeTexture', w, img3);
        Screen('DrawTexture', w, imageDisplay1,[], [(180+bmp_size(1)),(300+bmp_size(2)),(180+bmp_size(3)),(300+bmp_size(4))]);
        Screen('DrawTexture', w, imageDisplay2,[], [(500+bmp_size(1)),(300+bmp_size(2)),(500+bmp_size(3)),(300+bmp_size(4))]);
        Screen('DrawTexture', w, imageDisplay3,[], [(820+bmp_size(1)),(300+bmp_size(2)),(820+bmp_size(3)),(300+bmp_size(4))]);
        [~, startTime] =Screen('Flip', w);
        
        % Get keypress response
        rt = 0;
        resp = 0; press=0;
        correct=0;
        while GetSecs - startTime <= trialTimeout
            
            [~,~,KeyCode] = KbCheck;
            respTime = GetSecs;
            if KeyCode(key1)==1
                resp=1;
                press=1;
                if DATA.astim_mat(t,9)==1
                    correct=1;
                end
            elseif KeyCode(key2)==1
                resp=2;
                press=1;
                if DATA.astim_mat(t,9)==2
                    correct=1;
                end
            elseif KeyCode(key3)==1
                resp=3;
                press=1;
                if DATA.astim_mat(t,9)==3
                    correct=1;
                end
            else
                resp=0;
            end
            
            rt = respTime - startTime;
            if press==1
                break;
            end
        end
        
        Screen('Flip', w);
        
        %Reshow selected shape
        if resp==1
            imageDisplay1=Screen('MakeTexture', w, img1);
            Screen('DrawTexture', w, imageDisplay1,[], [(180+bmp_size(1)),(300+bmp_size(2)),(180+bmp_size(3)),(300+bmp_size(4))]);
        elseif resp==2
            imageDisplay2=Screen('MakeTexture', w, img2);
            Screen('DrawTexture', w, imageDisplay2,[], [(500+bmp_size(1)),(300+bmp_size(2)),(500+bmp_size(3)),(300+bmp_size(4))]);
        elseif resp==3
            imageDisplay3=Screen('MakeTexture', w, img3);
            Screen('DrawTexture', w, imageDisplay3,[], [(820+bmp_size(1)),(300+bmp_size(2)),(820+bmp_size(3)),(300+bmp_size(4))]);
        end
        Screen('Flip', w);
        WaitSecs(DATA.Times.choice_selc);
        Screen('Flip', w);
        
        % notify participant if too slow
        Screen('TextSize', w, 30);
        if press==0
                feedb_tx='Too SLOW!';
                DrawFormattedText(w, feedb_tx, 'center',(H/2-180), [255 0 0]);
                rt = DATA.Times.max_RT;
                Screen('Flip', w);
                WaitSecs(DATA.Times.feedback);
                Screen('Flip', w);
        end
   
        WaitSecs(0.05);
        
        % store data of this trial
        DATA.exp_data(t,1:12)=DATA.astim_mat(t,1:12);
        DATA.exp_data(t,13)=resp;
        DATA.exp_data(t,14)=rt;
        DATA.exp_data(t,15)=correct;
        save(datafile,'DATA');
        
        WaitSecs(1.0);

        % at the end of the test display overall score
        if t == size(DATA.astim_mat,1)
            Screen('FillRect', w, [1 1 1]);
            Screen('Flip', w);
            n_correct = sum(DATA.exp_data(:,15));
            five_rand_trials = randperm(size(DATA.astim_mat,1));
            five_rand_trials = five_rand_trials(1:2);
            earning = sum(DATA.exp_data(five_rand_trials,15))*0.5;
            accuracy= round(100*(n_correct/size(DATA.astim_mat,1)));
            acc_per_stim = [];
            for s = 1:length(DATA.stims1to7)
                eval(['acc_stim = sum(DATA.exp_data(find(DATA.exp_data(:,1)==stim' num2str(s) ',15)));'])
                eval(['acc_stim_length = length(find(DATA.exp_data(:,1)==stim' num2str(s) '));'])
                acc_per_stim = [acc_per_stim; acc_stim/acc_stim_length]; %#ok<AGROW>
            end
            final_rt = (round(100*mean(DATA.exp_data(size(DATA.astim_mat,1):size(DATA.astim_mat,1),13))))/100;
            feedb_tx= ['Great- that''s the end of the block. \n\n ' num2str(accuracy) '% accuracy, ' num2str(final_rt) 's reaction time. \n\n You earnt £' num2str(earning) '! \n\n\n Please call the experimenter...'];
            DrawFormattedText(w, feedb_tx, 'center',(H/2-180), [0 255 0]);
            Screen('Flip', w);
            GetClicks(w);
            Screen('Flip', w);
        end
    end
    
    Screen('Close',w);
    
    fprintf('\n***** ScreenTest: Done With Screen %d *****\n',screen);
end
end