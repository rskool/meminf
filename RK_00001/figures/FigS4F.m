%% Fig S4F

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load paramEstimatesNeocortex

data = [paramEstimatesNeocortex.M2.ControlB1 paramEstimatesNeocortex.M2.ControlB2 ...
    paramEstimatesNeocortex.M2.XSS_B1 paramEstimatesNeocortex.M2.XSS_B2];

bargraph(data)
set(gca,'XTickLabel',{'Control' 'XSS','Control' 'XSS'},'FontSize', 20);
ylim([-10 10])
ylabel('Control - XSS, memory 2 (a.u.)')