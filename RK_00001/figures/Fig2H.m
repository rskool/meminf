%% Fig 2H

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load residualParams

hpc_b1 = residualParams.hippocampusB1_2H;
foil_d3 = residualParams.normFoilErrors_2H6C;

scatterplot(hpc_b1, foil_d3)
xlabel('hippocampal fMRI block 1 (a.u.)')
ylabel('% foil errors day 3 (a.u.)')

[r,p]=corr(hpc_b1,foil_d3,'Type','Pearson');
