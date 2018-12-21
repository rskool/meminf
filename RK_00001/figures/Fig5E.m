%% Fig 5E

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load paramEstimatesNeocortex

differenceControl = paramEstimatesNeocortex.M1.ControlB1-paramEstimatesNeocortex.M1.ControlB2;
differenceXSS = paramEstimatesNeocortex.M1.XSS_B1-paramEstimatesNeocortex.M1.XSS_B2;
data = [differenceControl differenceXSS];

bargraph(data)
set(gca,'XTickLabel',{'Block1' 'Block2'},'FontSize', 20);
ylim([-5 10])
ylabel('Control - XSS, memory 1 (a.u.)')