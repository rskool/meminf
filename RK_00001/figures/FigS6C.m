%% Fig S6C

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load paramEstimatesNeocortex

data = [paramEstimatesNeocortex.M2.Control_min_XSS_B1_S6C paramEstimatesNeocortex.M2.Control_min_XSS_B2_S6C];

bargraph(data)
set(gca,'XTickLabel',{'Block1' 'Block2'},'FontSize', 20);
ylim([-8 2])
ylabel('Control - XSS, memory 2 (a.u.)')