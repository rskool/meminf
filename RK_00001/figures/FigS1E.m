%% Fig S1E

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load behavResults

mri = nan(26,1); tdcs = nan(26,1); sham = nan(26,1); behav = nan(26,1);

mri(1:sum(behavResults.MRI)) = behavResults.memoryAccuracy(logical(behavResults.MRI));
tdcs(1:sum(behavResults.TDCS)) = behavResults.memoryAccuracy(logical(behavResults.TDCS));
sham(1:sum(behavResults.SHAM)) = behavResults.memoryAccuracy(logical(behavResults.SHAM));
behav(1:sum(behavResults.BEHAV)) = behavResults.memoryAccuracy(logical(behavResults.BEHAV));

bargraph([mri tdcs sham behav])
set(gca,'XTickLabel',{'MRI'; 'tDCS'; 'Sham'; 'Behav'},'FontSize', 20);
ylabel('% Memory accuracy day 3');