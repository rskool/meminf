%% Fig S4C

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load paramEstimatesNeocortex

data = [paramEstimatesNeocortex.M12.Control_min_XSS_B1_S4C paramEstimatesNeocortex.M12.Control_min_XSS_B2_S4C];

bargraph(data)
set(gca,'XTickLabel',{'Block1' 'Block2'},'FontSize', 20);
ylim([-5 15])
ylabel('Control - XSS, memory 1&2 (a.u.)')