%% Fig 6A

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load residualParams

% parameters corrected for change in GABA, Glutamate and learning
XSS = residualParams.XSSincrease_6A;
learning = residualParams.learningD2_6A;

scatterplot(learning,XSS)
xlabel('% learning accuracy day2 (a.u.)')
ylabel('fMRI XSS increase, b2-b1, (a.u.)')
% xlim([8.5 12.5])
[r,p]=corr(XSS,learning,'Type','Spearman');