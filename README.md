# clustering
Scripts used to analyse attractor-like dynamics in the mouse auditory cortex from 2P recordings.
An acquired dataset is provided to test functionality.
Available for download here: https://drive.google.com/file/d/1utOBlnVg2yPi8YOzhjF3xNRPBHIoqPSu/view?usp=sharing

pipeline:
Scripts extract spiking-, or trace-based PSTHs from neuron*.mat files

'clustering' creates an averaged correlation matrix based on spike-based population vectors and performs hierarchal clustering stimuli-evoked responses. Returns nonclustered and clustered ACMs along with the identities of sounds in modes.

'clustering_IN' uses trace-based PSTHs instead of spike probabilities.

'INanalyser' creates ACMs for every neuron in the current folder based on fluorescent traces of the given neuron. These are then averaged across the population. Returns the meanACM.

'MixVisualizations' plots population vectors (1)mean over trials for all  stimuli (2)trial-by-trial for a single stimulus
(3)mean over trials for two user-defined stimuliN

'popResponse' plots the mean population activity across the population for every stimuli of the battery
