deviceString='Apple Internal Keyboard / Trackpad';%% name of the scanner trigger box
[id,name] = GetKeyboardIndices;% get a list of all devices connected
device=0;

for i=1:length(name)%for each possible device
 if strcmp(name{i},deviceString)%compare the name to the name you want
    device=id(i);%grab the correct id, and exit loop
    break;
 end
end