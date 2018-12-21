%% Figure S6D

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load residualsS6D

% calculate the true difference between correlation coefficients
c_true_diff = corrcoef(residualsHPC_b1,residualsFoil)-corrcoef(residualsHPC_b2,residualsFoil);
c_true_diff = c_true_diff(1,2);

block1 = [residualsHPC_b1, residualsFoil];
block2 = [residualsHPC_b2, residualsFoil];

nperm = 10000;
n_subj = length(block1);

for i=1:nperm
    idx1 = datasample(1:n_subj,n_subj,'Replace',false)';
    idx2 = datasample(1:n_subj,n_subj,'Replace',false)';
    [r1, ~]=corrcoef(block1(idx1,1),block1(:,2)); % col1 being betas and col2 behav
    [r2, ~]=corrcoef(block2(idx2,1),block2(:,2));
    c_diff(i) = r1(1,2)-r2(1,2);
end

figure;
histogram(c_diff,'facecolor',[0,0.5,0.5],'facealpha',.5,'edgecolor','none')
hold on
plot(c_true_diff, 80, 'r*', 'LineWidth', 2, 'MarkerSize', 15);
xlim([-2 2]);
set(gca,'TickDir','out', 'Fontsize', 10, 'LineWidth', 1,'Xtick',-1:1,'Ytick',0:200:800) 
set(gcf,'color','w');
box off
ylabel('Number of samples')
xlabel('Difference in correlation coefficient (r1-r2)')