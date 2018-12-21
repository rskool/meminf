%% Fig S6B

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load paramEstimatesNeocortex

data = [paramEstimatesNeocortex.M1.Control_min_XSS_B1_S6B paramEstimatesNeocortex.M1.Control_min_XSS_B2_S6B];

bargraph(data)
set(gca,'XTickLabel',{'Block1' 'Block2'},'FontSize', 20);
ylim([-10 10])
ylabel('Control - XSS, memory 1 (a.u.)')