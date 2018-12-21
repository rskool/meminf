%% Fig S4H

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load residualParams

% parameters corrected for change in GABA, Glutamate and learning
XSS = residualParams.XSSincrease_S4H;
GABA = residualParams.GABAdecrease_5BS4H;

scatterplot(GABA,XSS)
xlabel('GABA decrease, t1-t2 (a.u.)')
ylabel('fMRI XSS increase b2-b1, (a.u.)')
[r,p]=corr(XSS,GABA,'Type','Spearman');