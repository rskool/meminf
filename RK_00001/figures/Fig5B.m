%% Fig 5B

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load residualParams

% paremeters corrected for change in Glutamate
XSS = residualParams.XSSincrease_5B;
GABA = residualParams.GABAdecrease_5BS4H;

scatterplot(GABA,XSS)
xlabel('GABA decrease, t1-t2 (a.u.)')
ylabel('fMRI XSS increase b2-b1, (a.u.)')

[r,p]=corr(XSS,GABA,'Type','Spearman');