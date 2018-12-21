%% Fig 3B

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load RDMParameterEstimates

data = RDMParameterEstimates.withinVersusBetweenMemSimilarity;

figure
histogram(data,30, 'FaceColor',[0.65 0.65 0.65])
set(gcf,'color','w');
box off
xlabel('Within - between memory similarity (a.u.)')
ylabel('Number of participants')
xlim([-0.015 0.015])
ylim([0 3])

