# The Hippocampus and Neocortical Inhibitory Engrams Protect against Memory Interference, Neuron 2019
This repository contains the Matlab scripts and data files that can be used to reproduce the figures from Koolschijn et al., Neuron 2019, as well as the Matlab scripts that were used to run the behavioural tasks.

Dependencies for the figures:
- MATLAB (we used version 2016b)
- RSA toolbox (Nili et al., 2014)

Dependencies for the task:
- MATLAB (we used version 2016b)
- Psychtoolbox (https://www.psychtoolbox.org)

The activation maps (nifti format) and the Matlab code to generate the figures is contained in the 'figures' folder. Figures are generated using the data files in the 'mat_data' folder. In addition, the full trial-by-trial RDMs are included (fullRDMs.mat).

The behavioural tasks used in the experiment can be run through the 'run_task.m' file after changes the experimental variables in this file accordingly. Prior to running the task, the root folder in the relevant task folder should be modified (e.g. in associative_test_learning.m).
