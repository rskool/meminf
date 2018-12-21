%% Fig 5C

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load residualParams

% parameters corrected for change in GABA, Glutamate and learning
XSS = residualParams.XSSincrease_5CD;
foils = residualParams.normFoilErrors_5C;

scatterplot(XSS,foils)
xlabel('fMRI XSS increase b2-b1, (a.u.)')
ylabel('% foil errors (a.u.)')
xlim([8.5 12.5])
[r,p]=corr(XSS,foils,'Type','Spearman');