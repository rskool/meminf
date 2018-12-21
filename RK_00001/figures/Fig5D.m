%% Fig 5D

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load residualParams

% parameters corrected for change in GABA, Glutamate and learning
XSS = residualParams.XSSincrease_5CD;
memAcc = residualParams.memAccuracy_5D;

scatterplot(XSS,memAcc)
xlabel('fMRI XSS increase b2-b1, (a.u.)')
ylabel('% memory accuracy (a.u.)')
xlim([8.5 12.5])
[r,p]=corr(XSS,memAcc,'Type','Spearman');