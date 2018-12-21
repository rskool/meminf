%% Fig S3E-F

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load MRS_results_csf %loads variable 'metabolites_csfCorr

% GABA
n = length(metabolites_csfCorr(9).baseline);
means = mean([metabolites_csfCorr(9).baseline metabolites_csfCorr(9).tdcs metabolites_csfCorr(9).post_tdcs]);
sems = std([metabolites_csfCorr(9).baseline metabolites_csfCorr(9).tdcs metabolites_csfCorr(9).post_tdcs])./sqrt(n);

lineplot(means,sems);
set(gca,'Xtick',1:3,'XTickLabel',{'before tDCS' 'during tDCS' 'Post task'});
ylim([3.5, 5.5]);
ylabel('GABA concentration (uM/g)')

% Glutamate
n = length(metabolites_csfCorr(12).baseline);
means = mean([metabolites_csfCorr(12).baseline metabolites_csfCorr(12).tdcs metabolites_csfCorr(12).post_tdcs]);
sems = std([metabolites_csfCorr(12).baseline metabolites_csfCorr(12).tdcs metabolites_csfCorr(12).post_tdcs])./sqrt(n);

lineplot(means,sems);
set(gca,'Xtick',1:3,'XTickLabel',{'before tDCS' 'during tDCS' 'Post task'});
ylim([8.5, 10]);
ylabel('Glutamate concentration (uM/g)')


function lineplot(y,stdev)

barspacing = 1;
figure; 
xlim([0.5,length(y)+0.5]);
hold on;
for i=1:length(y)
    line([1+barspacing*(i-1),1+barspacing*(i-1)],[y(i)-stdev(i),y(i)+stdev(i)],'Color','k','LineWidth',3);
end
for i2= 1:(length(y)-1)
    line([1+barspacing*(i2-1),1+barspacing*(i2)],[y(i2), y(i2+1)], 'Color', [0.7,0.7,0.7],'LineWidth',3);
end
scatter([1,2,3],y, 220,'filled', 'k');
box off;
set(gca,'TickDir','out','Fontsize',10,'linewidth',2);
set(gcf,'color','w');
end