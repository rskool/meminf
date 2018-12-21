%% Fig 5F

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load paramEstimatesNeocortex

data = [paramEstimatesNeocortex.M1.ControlB1 paramEstimatesNeocortex.M1.ControlB2 ...
    paramEstimatesNeocortex.M1.XSS_B1 paramEstimatesNeocortex.M1.XSS_B2];

bargraph(data)
set(gca,'XTickLabel',{'Control' 'XSS','Control' 'XSS'},'FontSize', 20);
ylim([-5 20])
ylabel('Effect size, memory 1 (a.u.)')