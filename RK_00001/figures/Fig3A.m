%% Plot Figure 3A
% requires RSA Toolbox (Nili et al., 2014)

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load conditionRDMs

crossContextRDMs = conditionRDMs(8:end,1:7,:);

rsa.fig.showRDMs(mean(crossContextRDMs,3),1)
h=get(gcf,'children');
colormap(h(3),'parula')