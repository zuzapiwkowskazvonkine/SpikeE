xn=44; %xdim
yn=45; %ydim
in=46; %intensity
mrn=43; %max response
fovn=47; %fov
signifn=48; %significance in file
cellid=1; %cell id number

global SpikeTraceData

%number of cells already in pje table (ie number of columns):

if exist('dcncells')>0
nbcells=size(dcncells,2);
else
    nbcells=0;
    dcncells=zeros(7,1);
end

%1 column per cell

for i=1:length(SpikeTraceData(xn).Trace)

dcncells(:,nbcells+i)=[cellid SpikeTraceData(xn).Trace(i) SpikeTraceData(yn).Trace(i) SpikeTraceData(in).Trace(i) SpikeTraceData(mrn).Trace(i) SpikeTraceData(fovn).Trace(i) SpikeTraceData(signifn).Trace(i)];


end

size(dcncells)

