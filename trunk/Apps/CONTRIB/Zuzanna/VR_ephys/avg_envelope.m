function [avg_times,avg] = avg_envelope(tr_lfp,tr_events,prewin,postwin)

%tr_lfp: num of LFP trace in SpikeTraceData to use for averaging 
%tr_events: num of events trace in SpikeTraceData (ie airpuffs) to use for event times around
%which to average 
%prewin: window to use before each event (in sec)
%postwin: window to use after each even (in sec)

%Zuzanna Piwkowska 18/10/2017

global SpikeTraceData

deltat=SpikeTraceData(tr_lfp).XVector(2)-SpikeTraceData(tr_lfp).XVector(1);
if size(SpikeTraceData(tr_lfp).Trace,2)>size(SpikeTraceData(tr_lfp).Trace,1)
    sum=zeros(1,ceil((prewin+postwin)/deltat));
else
    sum=zeros(ceil((prewin+postwin)/deltat),1);
end

size(sum)

n=0;

for i=1:length(SpikeTraceData(tr_events).Trace)
    

    
    startt=SpikeTraceData(tr_events).XVector(i)-prewin;
    stopt=SpikeTraceData(tr_events).XVector(i)+postwin;
    
    if startt>=150 && stopt<=250%SpikeTraceData(tr_lfp).XVector(end)
        
        startx=ceil(startt/deltat);
        stopx=ceil(stopt/deltat);
        tot=stopx-startx+1
        if tot~=size(sum,2)
            stopx=stopx-1;
        end
        
        
        
        sum=sum+abs(SpikeTraceData(tr_lfp).Trace(startx:stopx));
        
        
        n=n+1;
    end
    
end

% avg=sum/length(SpikeTraceData(tr_events).Trace);
avg=sum/n;
avg_times=[0:deltat:ceil(prewin+postwin)];
if max(size(avg))~=max(size(avg_times))
   avg_times=[0:deltat:ceil(prewin+postwin)-deltat];
end
figure
plot(avg_times,avg);