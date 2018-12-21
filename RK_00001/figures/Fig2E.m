%% Figure 2E

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load behavResults

mem1 = behavResults.memAcc_mem1(logical(behavResults.MRI));
mem2 = behavResults.memAcc_mem2(logical(behavResults.MRI));

bargraph([mem1 mem2])

set(gca,'XTickLabel',{'mem1'; 'mem2'},'FontSize', 20);
xlabel({'trials'})
ylabel({'% Memory accuracy day 3'})

