function [] = filenamesall(nstart,nstop)

global SpikeTraceData

for n=nstart:1:nstop
    n
    SpikeTraceData(n).Filename
end