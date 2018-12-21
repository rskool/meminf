%% Fig 6B

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load residualParams

% parameters corrected for change in GABA, Glutamate and learning
XSS = residualParams.XSSincrease_6B;
learning = residualParams.learningD1_6B;

scatterplot(learning,XSS)
xlabel('% learning accuracy day1 (a.u.)')
ylabel('fMRI XSS increase, b2-b1, (a.u.)')
[r,p]=corr(XSS,learning,'Type','Spearman');