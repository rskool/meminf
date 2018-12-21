%% Fig S4D

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load paramEstimatesNeocortex

data = [paramEstimatesNeocortex.M1.Control_min_XSS_B1 paramEstimatesNeocortex.M1.Control_min_XSS_B2];

bargraph(data)
set(gca,'XTickLabel',{'Block1' 'Block2'},'FontSize', 20);
ylim([-4 8])
ylabel('Control - XSS, memory 1 (a.u.)')