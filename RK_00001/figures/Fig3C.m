%% Fig 3C

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load RDMParameterEstimates

data = RDMParameterEstimates.betweenMemorySimilarity;

figure
histogram(data,30, 'FaceColor',[0.65 0.65 0.65])
set(gcf,'color','w');
box off
xlabel('Between memory stimulus similarity (a.u.)')
ylabel('Number of participants')
xlim([-0.01 0.01])
ylim([0 4])