%% Fig S5F

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load aLOC_vs_PFC

pfc = aLOC_vs_PFC.PFC_XSS_b2_S5F;
aloc = aLOC_vs_PFC.aLOC_XSS_b2_S5F;


scatterplot(pfc,aloc)
xlabel('PFC fMRI XSS during b2, (a.u.)')
ylabel('aLOC fMRI XSS during b2, (a.u.')

[r,p]=corr(aloc,pfc,'Type','Pearson');