%% Fig S3C

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load spectra

bad = nan(60,1);

good = [spectra.FWHM_Good.baseline; spectra.FWHM_Good.tdcs; spectra.FWHM_Good.post_tdcs];
bad(1:length(spectra.FWHM_Bad.baseline)*3) = [spectra.FWHM_Bad.baseline; spectra.FWHM_Bad.tdcs; spectra.FWHM_Bad.post_tdcs];

bargraph([good bad])
ylabel('Average FWHM (ppm)')
set(gca,'Ytick',0:0.01:0.05,'Xtick',1:2,'XTickLabel',{'Included' 'Excluded'},'Fontsize',10);
