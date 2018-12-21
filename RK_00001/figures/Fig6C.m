%% Fig 6C

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load residualParams

foil_d3 = residualParams.normFoilErrors_2H6C;
hpc_b2 = residualParams.hippocampusB2_6C;

scatterplot(hpc_b2, foil_d3)
xlabel('hippocampal BOLD signal b2 (a.u.)')
ylabel('% foil errors (a.u.)')
[r,p]=corr(hpc_b2,foil_d3,'Type','Pearson');