xn=26; %xdim
yn=27; %ydim
in=33; %intensity
mrn=34; %max response
fovn=35; %fov
cellid=14; %cell id number

global SpikeTraceData

%number of cells already in pje table (ie number of columns):

if exist('pje_new')>0
nbcells=size(pje_new,2);
else
    nbcells=0;
    pje_new=zeros(6,1);
end

%1 column per cell

for i=1:length(SpikeTraceData(xn).Trace)

pje_new(:,nbcells+i)=[cellid SpikeTraceData(xn).Trace(i) SpikeTraceData(yn).Trace(i) SpikeTraceData(in).Trace(i) SpikeTraceData(mrn).Trace(i) SpikeTraceData(fovn).Trace(i)];


end

size(pje_new)

