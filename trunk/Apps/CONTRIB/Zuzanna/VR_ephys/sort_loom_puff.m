function [tr_loomfront,tr_loomfront_puff,tr_loomup,tr_loomup_puff] = sort_loom_puff(tr_loomtimes,tr_loompos,tr_puffs)

%tr_loomtimes: num of trace in SpikeTraceData with start times (non-digitized) of all looming stimuli (obtained by thresholding loom diam) 
%tr_loompos: num of trace in SpikeTraceData with the value of the looming stimulus position
%tr_puffs: num of trace in SpikeTraceData with start times (non-digitized) of puffs

%Zuzanna Piwkowska 19/10/2017

global SpikeTraceData

BeginTrace=length(SpikeTraceData)+1;

tr_loomfront=BeginTrace;
SpikeTraceData(BeginTrace).Trace=SpikeTraceData(tr_loomtimes).Trace;
SpikeTraceData(BeginTrace).XVector=SpikeTraceData(tr_loomtimes).XVector;
SpikeTraceData(BeginTrace).DataSize=SpikeTraceData(tr_loomtimes).DataSize;
SpikeTraceData(BeginTrace).Label.ListText='Loom Front';
SpikeTraceData(BeginTrace).Label.YLabel='Loom Front binned';
SpikeTraceData(BeginTrace).Label.XLabel=SpikeTraceData(tr_loomtimes).Label.XLabel;
SpikeTraceData(BeginTrace).Filename=SpikeTraceData(tr_loomtimes).Filename;
SpikeTraceData(BeginTrace).Path=SpikeTraceData(tr_loomtimes).Path;

BeginTrace=length(SpikeTraceData)+1;

tr_loomfront_puff=BeginTrace;
SpikeTraceData(BeginTrace).Trace=SpikeTraceData(tr_loomtimes).Trace;
SpikeTraceData(BeginTrace).XVector=SpikeTraceData(tr_loomtimes).XVector;
SpikeTraceData(BeginTrace).DataSize=SpikeTraceData(tr_loomtimes).DataSize;
SpikeTraceData(BeginTrace).Label.ListText='Loom Front + Puff';
SpikeTraceData(BeginTrace).Label.YLabel='Loom Front + Puff binned';
SpikeTraceData(BeginTrace).Label.XLabel=SpikeTraceData(tr_loomtimes).Label.XLabel;
SpikeTraceData(BeginTrace).Filename=SpikeTraceData(tr_loomtimes).Filename;
SpikeTraceData(BeginTrace).Path=SpikeTraceData(tr_loomtimes).Path;

BeginTrace=length(SpikeTraceData)+1;

tr_loomup=BeginTrace;
SpikeTraceData(BeginTrace).Trace=SpikeTraceData(tr_loomtimes).Trace;
SpikeTraceData(BeginTrace).XVector=SpikeTraceData(tr_loomtimes).XVector;
SpikeTraceData(BeginTrace).DataSize=SpikeTraceData(tr_loomtimes).DataSize;
SpikeTraceData(BeginTrace).Label.ListText='Loom Up';
SpikeTraceData(BeginTrace).Label.YLabel='Loom Up binned';
SpikeTraceData(BeginTrace).Label.XLabel=SpikeTraceData(tr_loomtimes).Label.XLabel;
SpikeTraceData(BeginTrace).Filename=SpikeTraceData(tr_loomtimes).Filename;
SpikeTraceData(BeginTrace).Path=SpikeTraceData(tr_loomtimes).Path;

BeginTrace=length(SpikeTraceData)+1;

tr_loomup_puff=BeginTrace;
SpikeTraceData(BeginTrace).Trace=SpikeTraceData(tr_loomtimes).Trace;
SpikeTraceData(BeginTrace).XVector=SpikeTraceData(tr_loomtimes).XVector;
SpikeTraceData(BeginTrace).DataSize=SpikeTraceData(tr_loomtimes).DataSize;
SpikeTraceData(BeginTrace).Label.ListText='Loom Up + Puff';
SpikeTraceData(BeginTrace).Label.YLabel='Loom Up + Puff binned';
SpikeTraceData(BeginTrace).Label.XLabel=SpikeTraceData(tr_loomtimes).Label.XLabel;
SpikeTraceData(BeginTrace).Filename=SpikeTraceData(tr_loomtimes).Filename;
SpikeTraceData(BeginTrace).Path=SpikeTraceData(tr_loomtimes).Path;

del=2;  %nb of delay points (after the onset of looming stim) to look for loompos data (sampling every 100ms, 2 is 200ms)
frontval=-15; %vert pos for lomming stimuli in the front
upval=90; %vert pos for lomming stimuli up (above mouse)
th=(frontval+upval)/2;

i=length(SpikeTraceData(tr_loomtimes).Trace)
%looping from the end for easier point removal
while i>0

    t=SpikeTraceData(tr_loomtimes).XVector(i) 
    v=[];
    v=find(SpikeTraceData(tr_puffs).XVector>t);
    if length(v)>=1
        SpikeTraceData(tr_puffs).XVector(v(1))
    end
    
    % this below does not work because the time steps in tr_loompos are
    % irregular, not all exactly equal to dt
    %     dt=SpikeTraceData(tr_loompos).XVector(2)-SpikeTraceData(tr_loompos).XVector(1)
    %     x=ceil(t/dt)
    
    x=find(SpikeTraceData(tr_loompos).XVector==t)
    
    if SpikeTraceData(tr_loompos).Trace(x+del)>th %up stimulus

        SpikeTraceData(tr_loomfront).XVector(i)=[]; %remove stim from 'front' list
        SpikeTraceData(tr_loomfront).Trace(i)=[];
        SpikeTraceData(tr_loomfront).DataSize=SpikeTraceData(tr_loomfront).DataSize-1;
        
        SpikeTraceData(tr_loomfront_puff).XVector(i)=[]; %remove stim from 'front+puff' list
        SpikeTraceData(tr_loomfront_puff).Trace(i)=[];
        SpikeTraceData(tr_loomfront_puff).DataSize=SpikeTraceData(tr_loomfront_puff).DataSize-1;
        
        %here test whether puff present or not within 1s window after
        %visual stim:
        if length(v)>=1
            if SpikeTraceData(tr_puffs).XVector(v(1))<t+1 %first puff following looming is less than 1s after looming starts, remove from 'up' list
                SpikeTraceData(tr_loomup).XVector(i)=[]; %remove stim from 'up' list
                SpikeTraceData(tr_loomup).Trace(i)=[];
                SpikeTraceData(tr_loomup).DataSize=SpikeTraceData(tr_loomup).DataSize-1;
            else %no puff after looming; remove from "up+puff' list
                SpikeTraceData(tr_loomup_puff).XVector(i)=[]; %remove stim from 'up+puff' list
                SpikeTraceData(tr_loomup_puff).Trace(i)=[];
                SpikeTraceData(tr_loomup_puff).DataSize=SpikeTraceData(tr_loomup_puff).DataSize-1;
            end
        else %no puff after last looming
            SpikeTraceData(tr_loomup_puff).XVector(i)=[]; %remove stim from 'up+puff' list
            SpikeTraceData(tr_loomup_puff).Trace(i)=[];
            SpikeTraceData(tr_loomup_puff).DataSize=SpikeTraceData(tr_loomup_puff).DataSize-1;
        end
        
    else %front stimulus
        
        SpikeTraceData(tr_loomup).XVector(i)=[]; %remove stim from 'up' list
        SpikeTraceData(tr_loomup).Trace(i)=[];
        SpikeTraceData(tr_loomup).DataSize=SpikeTraceData(tr_loomup).DataSize-1;
        
        SpikeTraceData(tr_loomup_puff).XVector(i)=[]; %remove stim from 'up+puff' list
        SpikeTraceData(tr_loomup_puff).Trace(i)=[];
        SpikeTraceData(tr_loomup_puff).DataSize=SpikeTraceData(tr_loomup_puff).DataSize-1;
        
        %here test whether puff present or not within 1s window after
        %visual stim:
        if length(v)>=1
            if SpikeTraceData(tr_puffs).XVector(v(1))<t+1 %first puff following looming is less than 1s after looming starts, remove from 'front' list
                SpikeTraceData(tr_loomfront).XVector(i)=[]; %remove stim from 'up' list
                SpikeTraceData(tr_loomfront).Trace(i)=[];
                SpikeTraceData(tr_loomfront).DataSize=SpikeTraceData(tr_loomfront).DataSize-1;
            else %no puff after looming; remove from "front+puff' list
                SpikeTraceData(tr_loomfront_puff).XVector(i)=[]; %remove stim from 'front+puff' list
                SpikeTraceData(tr_loomfront_puff).Trace(i)=[];
                SpikeTraceData(tr_loomfront_puff).DataSize=SpikeTraceData(tr_loomfront_puff).DataSize-1;
            end
        else %no puff after last looming
            SpikeTraceData(tr_loomfront_puff).XVector(i)=[]; %remove stim from 'front+puff' list
            SpikeTraceData(tr_loomfront_puff).Trace(i)=[];
            SpikeTraceData(tr_loomfront_puff).DataSize=SpikeTraceData(tr_loomup_puff).DataSize-1;
        end
        
    end
i=i-1;
end



