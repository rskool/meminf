% generate train pairing trial matrix

if expday == 1
    assoc  = [stim1 stim2 stim3 stim4 stim5 stim6 stim7];
elseif expday == 2
    assoc  = [stim1 stim2 stim6 stim4 stim5 stim3 stim7];
end
% change_stims = [stim3 stim6];
% change_stims_id = [3 6];

% Passive training
% Generate list of all possible pairs, 14 pairs per day
pairs = [];

for s = 1:length(DATA.stims1to7)
    if s<length(DATA.stims1to7)
       pairs = [pairs; assoc(s), assoc(s+1); assoc(s+1), assoc(s)]; %#ok<AGROW>
    end
end
pairs = [pairs; assoc(1) assoc(7); assoc(7) assoc(1)];


%orientation info; make four different orientations for each possible pair
orient = [ones(length(pairs),1);2*ones(length(pairs),1);3*ones(length(pairs),1);4*ones(length(pairs),1)];
pairs_orient = [orient(randperm(length(orient))), orient(randperm(length(orient)))];

%replicate the matrix
pairs = repmat(pairs,DATA.norients,1);

% prepare matrix
pstim_mat =[pairs, pairs_orient];
pstim_mat = pstim_mat(randperm(length(pstim_mat)),:);
pstim_mat = pstim_mat(1:DATA.n_Ptrials,:);

%% Active training
% generate all possible pairs of stimuli and all possible orientations
% using p1 and p2
apairs_orient = [];
for stim_pair = 1:length(pairs)
    for s1 = 1:DATA.norients
        for s2 = 1:DATA.norients
            apairs_orient = [apairs_orient; pairs(stim_pair,:) s1 s2]; %#ok<AGROW>
        end
    end
end

% Now give stims in col1 as test stims, stims in col2 as correct stims and select two other stims for
% alternative options at random
for day = 1:2
    stim_mat = [];
    pairings = apairs_orient;
    day_stims = assoc;
    pairings = pairings(randperm(length(pairings)),:);
    for p = 1:length(pairings)
        test_stim = pairings(p,1);
        
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
        corr_stim = pairings(p,2);
        position_info = randperm(3);
        stim_mat  = [stim_mat; pairings(p, 1:2) option_stims pairings(p,3:4) option_stims_orient position_info];
    end
    stim_mat = stim_mat(1:DATA.n_Atrials,:);
    astim_mat = stim_mat;  
end