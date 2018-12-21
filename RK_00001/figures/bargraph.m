function bargraph(data)

means = nanmean(data);
sems = nanstd(data)/sqrt(length(data));
figure;
hold on
for i=1:length(means)
    handlebar=bar(i, means(i));
    set(handlebar,'LineWidth',1,'BarWidth',0.5);
end

handle=errorbar(means,sems,'k','LineWidth',1.5);
set(handle,'linestyle','none');

set(gcf,'color','w');
box off
set(gca,'TickDir','out', 'Fontsize', 16, 'XTick',1:length(means), 'LineWidth', 1)

end