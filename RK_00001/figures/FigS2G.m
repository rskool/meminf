%% Fig S2G

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load RDMParameterEstimates

data = RDMParameterEstimates.withinVersusBetweenMemSimilarity_excl36;

figure
histogram(data,30, 'FaceColor',[0.65 0.65 0.65])
set(gcf,'color','w');
box off
xlabel('Within - between memory similarity (a.u.)')
ylabel('Number of participants')
xlim([-0.04 0.04])
ylim([0 3])