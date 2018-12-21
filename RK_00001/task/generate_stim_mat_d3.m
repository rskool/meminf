% Train pairing trial mat
day1  = [stim1 stim2 stim3 stim4 stim5 stim6 stim7];
day2  = [stim1 stim2 stim6 stim4 stim5 stim3 stim7];

% day 1 pairs
p1 = [];
for s = 1:length(DATA.stims1to7)
    if s<length(DATA.stims1to7)
        p1 = [p1; day1(s), day1(s+1); day1(s+1), day1(s)]; %#ok<AGROW>
    end
end
p1= [p1; day1(1) day1(7); day1(7) day1(1)];

% day 2 pairs
p2 = [];
for s = 1:length(DATA.stims1to7)
    if s<length(DATA.stims1to7)
        p2 = [p2; day2(s), day2(s+1); day2(s+1), day2(s)];
    end
end
p2= [p2; day2(1) day2(7); day2(7) day2(1)];
    
% generate all possible pairs of stimuli and all possible orientations
apairs_orient_day1 = []; apairs_orient_day2 = [];
for stim_pair = 1:length(p1)
    for s1 = 1:DATA.norients
        for s2 = 1:DATA.norients
            apairs_orient_day1 = [apairs_orient_day1; p1(stim_pair,:) s1 s2]; %#ok<*AGROW>
            apairs_orient_day2 = [apairs_orient_day2; p2(stim_pair,:) s1 s2];
        end
    end
end

% Now give stims in col1 as test stims, stims in col2 as correct stims and select two other stims for
% alternative options at random
for day = 1:2
    stim_mat = [];
    eval(['pairs = apairs_orient_day' num2str(day) ';'])
    eval(['day_stims = day' num2str(day) ';']);
    %randomise the order of pairs
    pairs = pairs(randperm(length(pairs)),:);
    for p = 1:length(pairs)
        test_stim = pairs(p,1);
        
        %randomly select alternative stims from non assoc options
        idx_test_stim = find(day_stims==test_stim);
        if test_stim~=day_stims(end)
            ass_stimplus = day_stims(idx_test_stim+1);
        elseif test_stim==day_stims(end)
            ass_stimplus = day_stims(1);
        end
        if test_stim~=day_stims(1)
            ass_stimminu = day_stims(idx_test_stim-1);
        elseif test_stim==day_stims(1)
            ass_stimminu = day_stims(end);
        end
        wrong_stims = find(day_stims~=ass_stimplus  & day_stims~=ass_stimminu & day_stims~=day_stims(idx_test_stim));
        wrong_stims = day_stims(wrong_stims);
        wrong_stims = wrong_stims(randperm(length(wrong_stims)));
        
        %compile matrix with all stims
        option_stims = wrong_stims(1:2);
        option_stims_orient = randperm(DATA.norients);
        option_stims_orient = option_stims_orient(1:2);
        corr_stim = pairs(p,2);
        position_info = randperm(3);
        stim_mat  = [stim_mat; pairs(p, 1:2) option_stims pairs(p,3:4) option_stims_orient position_info];
    end
    stim_mat = stim_mat(1:DATA.n_Atrials,:);
    eval(['astim_mat_day' num2str(day) '=stim_mat;']);
end