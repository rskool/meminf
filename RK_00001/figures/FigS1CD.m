%% Fig S1C

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load behavResults

mri_d1 = nan(26,1); tdcs_d1 = nan(26,1); sham_d1 = nan(26,1); behav_d1 = nan(26,1);

mri_d1(1:sum(behavResults.MRI)) = behavResults.learningD1(logical(behavResults.MRI));
tdcs_d1(1:sum(behavResults.TDCS)) = behavResults.learningD1(logical(behavResults.TDCS));
sham_d1(1:sum(behavResults.SHAM)) = behavResults.learningD1(logical(behavResults.SHAM));
behav_d1(1:sum(behavResults.BEHAV)) = behavResults.learningD1(logical(behavResults.BEHAV));

bargraph([mri_d1 tdcs_d1 sham_d1 behav_d1])
ylim([85 100])
set(gca,'XTickLabel',{'MRI'; 'tDCS'; 'Sham'; 'Behav'},'FontSize', 20);
ylabel('% Learning accuracy');
title('Day 1 Phase 2 trianing')

%% Fig S1D

mri_d2 = nan(26,1); tdcs_d2 = nan(26,1); sham_d2 = nan(26,1); behav_d2 = nan(26,1);

mri_d2(1:sum(behavResults.MRI)) = behavResults.learningD2(logical(behavResults.MRI));
tdcs_d2(1:sum(behavResults.TDCS)) = behavResults.learningD2(logical(behavResults.TDCS));
sham_d2(1:sum(behavResults.SHAM)) = behavResults.learningD2(logical(behavResults.SHAM));
behav_d2(1:sum(behavResults.BEHAV)) = behavResults.learningD2(logical(behavResults.BEHAV));

bargraph([mri_d2 tdcs_d2 sham_d2 behav_d2])
ylim([85 100])
set(gca,'XTickLabel',{'MRI'; 'tDCS'; 'Sham'; 'Behav'},'FontSize', 20);
ylabel('% Learning accuracy');
title('Day 2 Phase 2 trianing')