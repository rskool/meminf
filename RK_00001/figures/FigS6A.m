%% Fig S6A

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load paramEstimatesNeocortex

data = [paramEstimatesNeocortex.M12.Control_min_XSS_B1_S6A paramEstimatesNeocortex.M12.Control_min_XSS_B2_S6A];

bargraph(data)
set(gca,'XTickLabel',{'Block1' 'Block2'},'FontSize', 20);
ylim([-10 10])
ylabel('Control - XSS, memory 1&2 (a.u.)')