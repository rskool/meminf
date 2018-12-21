function scatterplot(x,y)

figure;
scatter(x,y,80, 'filled', 'k')
hold on
h = lsline; 
set(gca,'TickDir','out', 'Fontsize', 20); 
set(gcf,'color','w');
box off; set(h(1),'color','r'); 
set(h,'LineWidth',5); 