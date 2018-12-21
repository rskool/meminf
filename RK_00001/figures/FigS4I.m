%% Fig S4I

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load behavResults

data = [behavResults.memAcc_stim12457_mem1 behavResults.memAcc_stim12457_mem2];

bargraph(data)
set(gca,'XTickLabel',{'mem1' 'mem2'},'FontSize', 20);
ylim([0 100])
ylabel('% Memory accuracy day 3')