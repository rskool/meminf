%% Fig S4E

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load paramEstimatesNeocortex

differenceControl = paramEstimatesNeocortex.M2.ControlB1-paramEstimatesNeocortex.M2.ControlB2;
differenceXSS = paramEstimatesNeocortex.M2.XSS_B1-paramEstimatesNeocortex.M2.XSS_B2;
data = [differenceControl differenceXSS];

bargraph(data)
set(gca,'XTickLabel',{'Block1' 'Block2'},'FontSize', 20);
ylim([-5 15])
ylabel('Control - XSS, memory 2 (a.u.)')