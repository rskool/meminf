% Generate matrix with stimulus order 
n_stim_pairs_rep =4;
trial_pairs =[];
for trial_s1 = 1:length(DATA.stims1to7)
    for trial_s2 = 1:length(DATA.stims1to7)
        trial_pairs = [trial_pairs; trial_s1 trial_s2]; %#ok<*AGROW>
    end
end

% indicate context in col 3: Context: day1 = 1, day2 =2.
trial_pairs = repmat(trial_pairs,n_stim_pairs_rep/2,1);
trial_pairs_byctx = [trial_pairs, ones(length(trial_pairs),1) ; trial_pairs, 2*ones(length(trial_pairs),1)];

%randomise the order
trial_pairs_byctx = trial_pairs_byctx(randperm(length(trial_pairs_byctx)),:);

% indicate which of these trials are 'task' trials (7% in total)
rand_idx = randperm(length(trial_pairs_byctx));
ntask_trials = floor(length(trial_pairs)/7);
if mod(ntask_trials,2) ~= 0
  ntask_trials = ntask_trials-1;
end 
task_trials = rand_idx(1:ntask_trials);
task_stims = [ones(ntask_trials/2,1); 2*ones(ntask_trials/2,1)];
task_stims = task_stims(randperm(ntask_trials));
task_stim_id = randperm(ntask_trials) + length(DATA.stims1to7);

% add rotation indices- assign radomly
rotation_idx = repmat((1:4)',floor(length(trial_pairs_byctx)/4),1);
rotation_idx = [rotation_idx; (1:(length(trial_pairs_byctx) - length(rotation_idx)))'];
rotation_idx1 = rotation_idx(randperm(length(trial_pairs_byctx)));
rotation_idx2 = rotation_idx(randperm(length(trial_pairs_byctx)));

% Make stim matrix
stim_mat = zeros(length(trial_pairs_byctx),9);
stim_mat(:,1:3) = trial_pairs_byctx;
stim_mat(:,4:5) = [rotation_idx1, rotation_idx2];
stim_mat(task_trials,7) = 1;
stim_mat(task_trials,8) = task_stims;
stim_mat(task_trials,9) = task_stim_id;
