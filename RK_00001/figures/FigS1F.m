%% Fig S1F

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load trainingData
load behavResults

% MRI day 1
data = trainingData.day1(logical(behavResults.MRI),:);
n = sum(behavResults.MRI);
plot_learning(data,n)

% MRI day 2
data = trainingData.day2(logical(behavResults.MRI),:);
n = sum(behavResults.MRI);
plot_learning(data,n)

% tDCS day 1
data = trainingData.day1(logical(behavResults.TDCS),:);
n = sum(behavResults.TDCS);
plot_learning(data,n)

% tDCS day 2
data = trainingData.day2(logical(behavResults.TDCS),:);
n = sum(behavResults.TDCS);
plot_learning(data,n)

% Sham day 1
data = trainingData.day1(logical(behavResults.SHAM),:);
n = sum(behavResults.SHAM);
plot_learning(data,n)

% Sham day 2
data = trainingData.day2(logical(behavResults.SHAM),:);
n = sum(behavResults.SHAM);
plot_learning(data,n)

% Behav day 1
data = trainingData.day1(logical(behavResults.BEHAV),:);
n = sum(behavResults.BEHAV);
plot_learning(data,n)

% Behav day 2
data = trainingData.day2(logical(behavResults.BEHAV),:);
n = sum(behavResults.BEHAV);
plot_learning(data,n)


function plot_learning(data,n)

means = nanmean(data);
sems = nanstd(data)./sqrt(n);

figure;
plot(means,'o')
errorbar(means(end-4:end),sems(end-4:end),'-o','MarkerFaceColor','blue')
xlim([0 5])
ylim([65 100])
set(gcf,'color','w');
box off
set(gca,'TickDir','out', 'Fontsize', 10, 'XTick', 0:1:5, 'XTickLabel',{' ','4','3','2','1','0'})
xlabel('training blocks prior to final training block')
ylabel('% Learning accuracy')
end