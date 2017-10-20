function avg=avg_envelope(tr_lfp,tr_events,prewin,postwin)

%tr_lfp: num of LFP trace in SpikeTraceData to use for averaging 
%tr_events: num of events trace in SpikeTraceData (ie airpuffs) to use for event times around
%which to average 
%prewin: window to use before each event (in sec)
%postwin: window to use after each even (in sec)

%Zuzanna Piwkowska 18/10/2017


% prewin=1; %s
% postwin=1; %s
deltat=SpikeTraceData(10).XVector(2)-SpikeTraceData(10).XVector(1);
sum=zeros(1,ceil((prewin+postwin)/deltat));
size(sum)

for i=1:length(SpikeTraceData(14).Trace)
    
    startt=SpikeTraceData(14).XVector(i)-prewin;
    stopt=SpikeTraceData(14).XVector(i)+postwin;
    
    startx=ceil(startt/deltat);
    stopx=ceil(stopt/deltat);
    tot=stopx-startx+1;
    
    sum=sum+abs(SpikeTraceData(10).Trace(startx:stopx));
     
end

avg=sum/length(SpikeTraceData(14).Trace);
figure
plot(avg2)