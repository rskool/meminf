%% Fig S3A-B

dataFolder = '/Users/renee/Documents/Github/RK_00001/mat_data';
addpath(dataFolder)
load spectra

spectraGood = spectra.Good;
spectraBad = spectra.Bad;
ppm = spectra.ppm_axis;

plot_JackKnife(spectraGood,[0,0,1],ppm)
plot_JackKnife(spectraBad,[1,0,0], ppm)

function plot_JackKnife(spec,colour,x_axis)
figure;
col = colour;
linest = '-';

y = nanmean(spec,1);
x=x_axis;
se = nanstd((spec));%./sqrt(size(spec,1)-1);
L = y - se;
U = y + se;
Xcoords = [x x(end:-1:1)];
Ycoords = [U L(end:-1:1)];

col2 = col;
col2(col<1) = col2(col<1)+ 0.6*1-col(col<1);

hold on;
Pa = patch(Xcoords,Ycoords,col2);
set(Pa,'linestyle','none','linewidth',2);
plot(x,y,'color',col,'linewidth',1,'LineStyle',linest);
alpha(0.5)
set(gcf,'color','w');
box off
set(gca,'TickDir','out', 'Fontsize', 10)
set(gca,'Xdir','reverse','Ytick',0:50:150,'Xtick',1:4)
ylim([-10, 180]);
xlim([0, 4.5]);
ylabel('Amplitude (a.u.)')
xlabel('Chemical shift (ppm)')
end

