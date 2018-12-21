function associative_training_learning(expday, blue, Subj_ID, Subj_age, Subj_hand, Subj_gender, stim1, stim2,stim3, stim4,stim5, stim6, stim7, run)

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
close all;
PsychDefaultSetup(2);
Screen('CloseAll')
screens = Screen('Screens');
KbName('UnifyKeyNames');
HideCursor();

rng('shuffle');

% set colours
bgColor=cell(2,2);
bgColor{1,1}='blue';
bgColor{2,1}='yellow';
bgColor{1,2}='yellow';
bgColor{2,2}='blue';

format long; %ensure RT is to multiple decimal places

%passive training
p_stims = 56;%14 pairs * 4 rotations
passive_rep_pair = 0.5;% 50% percent number of possible pairs to show
DATA.n_Ptrials = p_stims*(passive_rep_pair);

%active training
DATA.n_Atrials = 100;

% Timing
DATA.Times.dur_Stim1   = 3; %For passive
DATA.Times.dur_Stim2   = 1;  %For active
DATA.Times.choice_selc = 0.5;
DATA.Times.feedback = 1.5; % presentation time of feedback during active learning
DATA.Times.max_RT = 3;
trialTimeout = 3;

% Define response and control keys, see http://psychtoolbox-3.googlecode.com/svn/trunk/Psychtoolbox/PsychBasic/KbName.m
key1 = KbName('b'); key2 = KbName('n'); key3 = KbName('m');

%Create Trial Matrix
generate_stim_mat_d12;
DATA.pstim_mat = pstim_mat; %passive training
DATA.astim_mat = astim_mat; %active training

%Example bitmap size
m=imread(fullfile(imageFolder,'SS0_1.bmp'));
[y,x,~]=size(m);
bmp_size= [0,0,x,y];

m=imread(fullfile(imageFolder,'green_tick.bmp'));
[y,x,~]=size(m);
bmp2_size= [0,0,x,y];

% Test each screen
for screen = screens
    %% Psychtoolbox setup
    fprintf('\n***** ScreenTest: Testing Screen %d *****\n',screen);
    PsychDebugWindowConfiguration;
    
    Screen('Preference', 'SkipSyncTests', 1);
    Screen('Preference', 'SyncTestSettings', 0.01);
    [w, rect] = PsychImaging('Openwindow',screen,[1 1 1]);   
    H=rect(RectBottom);
    Screen('TextSize', w, 20);
    
    %dummy calls
    KbCheck;
    WaitSecs(0.1);
    GetSecs;
    
    priorityLevel=MaxPriority(w);
    Priority(priorityLevel);
    
    %% Create directory for subject data
    if run==1 && expday==1
        if ~exist(fullfile(root, 'results',Subj_ID),'dir')
            mkdir(fullfile(root,'results',Subj_ID));
        else
            fprintf('\n\n\nA folder with this subject and session number already exists!\nPlease specify other name...')
            return
        end
    end
    
    if ~exist(fullfile(root, 'results', Subj_ID, ['train_pairing_' Subj_ID '_day' num2str(expday) '_run' num2str(run) '.mat']),'file')
        datafile    = fullfile(root, 'results', Subj_ID, ['train_pairing_' Subj_ID '_day' num2str(expday) '_run' num2str(run) '.mat']);
    else
        fprintf('\n\n\nA file with this subject and session number already exists!\nPlease specify other name...')
        return
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Run experiment
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% Passive training
    if run < 2
        if expday==1
            message = ['Hello - Welcome and thank you for participating in our experiment! \n \n Our experiment is run over THREE days:\n \n On DAY 1 (today!) you will\n \n learn a set of associations between shapes when the background colour is ', bgColor{expday,blue}, '.\n \nOn DAY 2 you will learn a different set of associations when the background colour is ', bgColor{2,blue},'. \n\n\n Press the mouse to read the rest of the instructions...'];
            DrawFormattedText(w, message, 'center', 'center', [0 0 0]);
            Screen('Flip', w);
            GetClicks(w);
            message ='For the first half of today''s experiment, you will be shown the pairs of shapes \n \n you will need to associate. There are 7 shapes altogether, each of which is paired with two other shapes.\n \nBear in mind that each shape can rotate by 90 degrees so you must learn to recognise the shapes \n \n regardless of their orientation. Try and remember as many pairs as possible from Part 1 as you will \n \n be tested on them in Part 2 where you will recieve CASH BONUSES for correct answers. \n \n You are not required to press any buttons during Part 1, \n\n just try and memorise as many associations as possible. \n\n\n Press the mouse to start part 1 of the task...';
            DrawFormattedText(w, message, 'center', 'center', [0 0 0]);
            Screen('Flip', w);
            GetClicks(w)
            Screen('Flip', w);
        elseif expday==2
            message = ['Hello - Welcome back to day 2 of our experiment! \n \n Today you will see the 7 shapes that you saw yesterday, but some of the pairs have changed. \n \n You will see that the background colour is now ', bgColor{expday,blue}, ', indicating that the pairs are different to yesterday.\n \n Your job is to learn the new pairs as accurately as possible. \n \n Again there are 7 shapes each of which is paired with two other shapes.'];
            DrawFormattedText(w, message, 'center', 'center', [0 0 0]);
            Screen('Flip', w);
            GetClicks(w);
            message ='The structure of the task is the same as yesterday, so for the first half of the experiment, \n \n you will be shown the pairs of shapes you will need to associate. \n \n Again, bear in mind that each shape can rotate by 90 degrees. Try and remember as many pairs\n \n as possible from Part1 as you will be tested on them in Part 2 \n \n where you will recieve CASH BONUSES for correct answers. You are not required to\n \n press any buttons during Part 1, just try and memorise as many associations as possible. \n\n\n Press the mouse to start part 1 of the task...';
            DrawFormattedText(w, message, 'center', 'center', [0 0 0]);
            Screen('Flip', w);
            GetClicks(w)
            Screen('Flip', w);
        end
        
        Screen('Flip', w);
        
        for p=1:length(DATA.pstim_mat)
            [~, ~, ~]=KbCheck;
            if (expday==1 && blue == 1) || (expday == 2 && blue == 2)
                Screen('FillRect', w, [0 0 1]); % Make background blue
                Screen('Flip', w);
            else
                Screen('FillRect', w, [1 1 0]); % Make background yellow
                Screen('Flip', w);
            end
            
            % Show stimuli
            img1 = imread(fullfile(imageFolder,['SS' ,num2str(DATA.pstim_mat(p,1) -1), '_' num2str(DATA.pstim_mat(p,3)) '.bmp']));
            imageDisplay1=Screen('MakeTexture', w, img1);
            Screen('DrawTexture', w, imageDisplay1,[], [(370+bmp_size(1)),(300+bmp_size(2)),(370+bmp_size(3)),(300+bmp_size(4))]);
            img2 = imread(fullfile(imageFolder,['SS' ,num2str(DATA.pstim_mat(p,2) -1), '_' num2str(DATA.pstim_mat(p,4)) '.bmp'])); % second image loaded
            imageDisplay2=Screen('MakeTexture', w, img2);
            Screen('DrawTexture', w, imageDisplay2,[], [(730+bmp_size(1)),(300+bmp_size(2)),(730+bmp_size(3)),(300+bmp_size(4))]);
            Screen('Flip', w);
            WaitSecs(DATA.Times.dur_Stim1);
            Screen('Flip', w);
            
            if p==length(DATA.pstim_mat)
                message = 'End of Part 1\n \n \n \n \n Press the mouse to continue to Part 2...';
                DrawFormattedText(w, message, 'center', 'center', [0 0 0]);
                Screen('Flip', w);
                GetClicks(w);
                Screen('Flip', w);
            end
        end
    end
    
    %% Active training
    message = 'Part 2: On each trial in this part of the experiment you will briefly be shown one shape. \n \n This will be followed by the three remaining shapes. \n \n Your task is to choose the correct shape for the pair, using buttons b, n and m. \n \n  Try to respond as fast as possible, but DON''T COMPROMISE YOUR ACCURACY. \n \n \n Press the mouse to continue with the instructions...';
    DrawFormattedText(w, message, 'center', 'center', [0 0 0]);
    Screen('Flip', w);
    GetClicks(w);
    Screen('Flip', w);
    message = 'The shape presentation will be fast- if you are unsure which is \n\n the correct pairing, then guess and use \n\n the feedback to learn the correct response.\n\n 3 of your choices will be chosen at random at the end of each block.  \n\n For each of the 3 trials, if you made a fast correct response \n \n then you will get 50p! \n \n\n Press the mouse to start part 2 of the task...';
    DrawFormattedText(w, message, 'center', 'center', [0 0 0]);
    Screen('Flip', w);
    GetClicks(w);
    Screen('Flip', w);
    
    WaitSecs(1.000);
    
    for t = 1:size(DATA.astim_mat,1)
        clear img img1 img2 img3 imageDisplay1
        img = imread(fullfile(imageFolder,['SS' ,num2str(DATA.astim_mat(t,1) -1), '_' num2str(DATA.astim_mat(t,5)), '.bmp']));
        
        if (expday==1 && blue == 1) || (expday == 2 && blue == 2)
            Screen('FillRect', w, [0 0 1]);  % Make background blue
            Screen('Flip', w);
        else
            Screen('FillRect', w, [1 1 0]); % Make background yellow
            Screen('Flip', w);
        end

        % load and display 3 choice stimuli
        imageDisplay=Screen('MakeTexture', w, img);
        Screen('DrawTexture', w, imageDisplay,[], [(500+bmp_size(1)),(300+bmp_size(2)),(500+bmp_size(3)),(300+bmp_size(4))]);
        Screen('Flip', w);
        WaitSecs(DATA.Times.dur_Stim2);
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
        resp = 0;press=0;
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
        
        %Reshow selected shape in its previous position
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
        
        %Present feedback- initial shape and correct pairing
        if DATA.astim_mat(t,9)==1
            imageDisplay1=Screen('MakeTexture', w, img1);
            Screen('DrawTexture', w, imageDisplay1,[], [(620+bmp_size(1)),(300+bmp_size(2)),(620+bmp_size(3)),(300+bmp_size(4))]);
        elseif DATA.astim_mat(t,9)==2
            imageDisplay2=Screen('MakeTexture', w, img2);
            Screen('DrawTexture', w, imageDisplay2,[], [(620+bmp_size(1)),(300+bmp_size(2)),(620+bmp_size(3)),(300+bmp_size(4))]);
        elseif DATA.astim_mat(t,9)==3
            imageDisplay3=Screen('MakeTexture', w, img3);
            Screen('DrawTexture', w, imageDisplay3,[], [(620+bmp_size(1)),(300+bmp_size(2)),(620+bmp_size(3)),(300+bmp_size(4))]);
        end
        Screen('TextSize', w, 30);
        if correct==1
            greentick = imread(fullfile(imageFolder, 'green_tick.bmp'));
            imageDisplay4=Screen('MakeTexture', w, greentick);
            feedb_tx='Correct shape! 50p!';
            DrawFormattedText(w, feedb_tx, 'center',(H/2-110), [0 255 0]);   
        elseif correct==0
            redtick = imread(fullfile(imageFolder, 'red_cross.bmp'));
            imageDisplay4=Screen('MakeTexture', w, redtick);
            if press==1
                feedb_tx='Wrong shape!';
                DrawFormattedText(w, feedb_tx, 'center',(H/2-110), [255 0 0]);
            elseif press==0
                feedb_tx='Too SLOW!';
                DrawFormattedText(w, feedb_tx, 'center',(H/2-110), [255 0 0]);
                rt = DATA.Times.max_RT;
            end
        end
        Screen('DrawTexture', w, imageDisplay4,[], [(550+bmp2_size(1)),(100+bmp2_size(2)),(550+bmp2_size(3)),(100+bmp2_size(4))]);
        imageDisplay=Screen('MakeTexture', w, img);
        Screen('DrawTexture', w, imageDisplay,[], [(300+bmp_size(1)),(300+bmp_size(2)),(300+bmp_size(3)),(300+bmp_size(4))]);
        
        Screen('Flip', w);
        WaitSecs(DATA.Times.feedback);
        Screen('Flip', w);
        
        WaitSecs(0.05);
        
        % store results of this trial
        DATA.exp_data(t,1:11)=DATA.astim_mat(t,1:11);
        DATA.exp_data(t,12)=resp;
        DATA.exp_data(t,13)=rt;
        DATA.exp_data(t,14)=correct;
        
        save(datafile,'DATA');
        
        % if at the end of the experiment present accuracy to participant
        if t == size(DATA.astim_mat,1)
            Screen('FillRect', w, [1 1 1]);
            Screen('Flip', w);
            n_correct = sum(DATA.exp_data(:,14));
            three_rand_trials = randperm(size(DATA.astim_mat,1));
            three_rand_trials =  three_rand_trials(1:3);
            earning = sum(DATA.exp_data( three_rand_trials,14))*0.5;
            accuracy= round(100*(n_correct/size(DATA.astim_mat,1)));
            acc_per_stim = [];
            for s = 1:length(DATA.stims1to7)
                eval(['acc_stim = sum(DATA.exp_data(find(DATA.exp_data(:,1)==stim' num2str(s) '),14));'])
                eval(['acc_stim_length = length(find(DATA.exp_data(:,1)==stim' num2str(s) '));'])
                acc_per_stim = [acc_per_stim; acc_stim/acc_stim_length]; %#ok<AGROW>
            end
            final_rt = (round(100*mean(DATA.exp_data(size(DATA.astim_mat,1)-10:size(DATA.astim_mat,1),13))))/100;
            feedb_tx= ['Great- that''s the end of the block. \n\n ' num2str(accuracy) '% accuracy, ' num2str(final_rt) 's reaction time. \n\n You earnt £' num2str(earning) '! \n\n\n Please call the experimenter...'];
            DrawFormattedText(w, feedb_tx, 'center',(H/2-180), [0 255 0]);
            Screen('Flip', w);
            GetClicks(w);
            Screen('Flip', w);
        end
    end
    
    % store summary results
    DATA.results.acc_per_stim = acc_per_stim;
    DATA.results.final_rt = final_rt;
    DATA.results.acc_mean = accuracy;
    DATA.results.earnings = earning;
    
    save(datafile,'DATA');
    
    Screen('Close',w);
    
    fprintf('\n***** ScreenTest: Done With Screen %d *****\n',screen);
end
end