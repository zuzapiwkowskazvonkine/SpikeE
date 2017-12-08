function [avg_times,avg] = avg_envelope_select(tr_lfp,tr_events,prewin,postwin,n1,n2)

%tr_lfp: num of LFP trace in SpikeTraceData to use for averaging 
%tr_events: num of events trace in SpikeTraceData (ie airpuffs) to use for event times around
%which to average 
%prewin: window to use before each event (in sec)
%postwin: window to use after each event (in sec)

%n1: first event to avg
%n2: last event to avg (ie function averages events between n1 and n2)

%Zuzanna Piwkowska 06/12/2017


global SpikeTraceData

deltat=SpikeTraceData(tr_lfp).XVector(5)-SpikeTraceData(tr_lfp).XVector(4);
if size(SpikeTraceData(tr_lfp).Trace,2)>size(SpikeTraceData(tr_lfp).Trace,1)
    sum=zeros(1,ceil((prewin+postwin)/deltat));
else
    sum=zeros(ceil((prewin+postwin)/deltat),1);
end

size(sum)


n=0;


for i=n1:n2
       
    startt=SpikeTraceData(tr_events).XVector(i)-prewin;
    stopt=SpikeTraceData(tr_events).XVector(i)+postwin;
    

    if  stopt<=SpikeTraceData(tr_lfp).XVector(end)

        startx=ceil(startt/deltat);
        stopx=startx+max(size(sum))-1;
%         stopx=(stopt/deltat)
%         tot=stopx-startx+1;
%         if tot~=size(sum,2)
%             stopx=stopx-1;
%         end
        
  
        sum=sum+(SpikeTraceData(tr_lfp).Trace(startx:stopx));
                
        n=n+1;
    end
    
end

% avg=sum/length(SpikeTraceData(tr_events).Trace);
avg=sum/n;
avg_times=[];
avg_times=[0:deltat:(prewin+postwin)];
max(size(avg_times))
if max(size(avg))~=max(size(avg_times))
   avg_times=[0:deltat:(prewin+postwin)-deltat];
end
max(size(avg_times))
figure
plot(avg_times,avg);