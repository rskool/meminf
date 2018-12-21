%% Fig S2I

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load RDMParameterEstimates

data = RDMParameterEstimates.withinVersusBetweenStimSimilarity;

figure
histogram(data,30, 'FaceColor',[0.65 0.65 0.65])
set(gcf,'color','w');
box off
xlabel('Within - between stimulus similarity (a.u.)')
ylabel('Number of participants')
xlim([-0.025 0.025])