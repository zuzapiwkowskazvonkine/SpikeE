function [tr_loom,tr_puff,tr_loom_puff,tr_puff_loom] = sort_loom_puff_2(tr_loomtimes,tr_puffs)

%tr_loomtimes: num of trace in SpikeTraceData with start times (non-digitized) of all looming stimuli (obtained by thresholding loom diam) 
%tr_puffs: num of trace in SpikeTraceData with start times (non-digitized) of puffs

%Zuzanna Piwkowska 21/11/2017

global SpikeTraceData

BeginTrace=length(SpikeTraceData)+1;

tr_loom=BeginTrace;
SpikeTraceData(BeginTrace).Trace=SpikeTraceData(tr_loomtimes).Trace;
SpikeTraceData(BeginTrace).XVector=SpikeTraceData(tr_loomtimes).XVector;
SpikeTraceData(BeginTrace).DataSize=SpikeTraceData(tr_loomtimes).DataSize;
SpikeTraceData(BeginTrace).Label.ListText='Loom only';
SpikeTraceData(BeginTrace).Label.YLabel='Loom only binned';
SpikeTraceData(BeginTrace).Label.XLabel=SpikeTraceData(tr_loomtimes).Label.XLabel;
SpikeTraceData(BeginTrace).Filename=SpikeTraceData(tr_loomtimes).Filename;
SpikeTraceData(BeginTrace).Path=SpikeTraceData(tr_loomtimes).Path;

BeginTrace=length(SpikeTraceData)+1;

tr_puff=BeginTrace;
SpikeTraceData(BeginTrace).Trace=SpikeTraceData(tr_puffs).Trace;
SpikeTraceData(BeginTrace).XVector=SpikeTraceData(tr_puffs).XVector;
SpikeTraceData(BeginTrace).DataSize=SpikeTraceData(tr_puffs).DataSize;
SpikeTraceData(BeginTrace).Label.ListText='Puff only';
SpikeTraceData(BeginTrace).Label.YLabel='Puff only binned';
SpikeTraceData(BeginTrace).Label.XLabel=SpikeTraceData(tr_puffs).Label.XLabel;
SpikeTraceData(BeginTrace).Filename=SpikeTraceData(tr_puffs).Filename;
SpikeTraceData(BeginTrace).Path=SpikeTraceData(tr_puffs).Path;

BeginTrace=length(SpikeTraceData)+1;

tr_loom_puff=BeginTrace;
SpikeTraceData(BeginTrace).Trace=SpikeTraceData(tr_loomtimes).Trace;
SpikeTraceData(BeginTrace).XVector=SpikeTraceData(tr_loomtimes).XVector;
SpikeTraceData(BeginTrace).DataSize=SpikeTraceData(tr_loomtimes).DataSize;
SpikeTraceData(BeginTrace).Label.ListText='Loom+Puff';
SpikeTraceData(BeginTrace).Label.YLabel='Loom+Puff binned';
SpikeTraceData(BeginTrace).Label.XLabel=SpikeTraceData(tr_loomtimes).Label.XLabel;
SpikeTraceData(BeginTrace).Filename=SpikeTraceData(tr_loomtimes).Filename;
SpikeTraceData(BeginTrace).Path=SpikeTraceData(tr_loomtimes).Path;

BeginTrace=length(SpikeTraceData)+1;

tr_puff_loom=BeginTrace;
SpikeTraceData(BeginTrace).Trace=SpikeTraceData(tr_puffs).Trace;
SpikeTraceData(BeginTrace).XVector=SpikeTraceData(tr_puffs).XVector;
SpikeTraceData(BeginTrace).DataSize=SpikeTraceData(tr_puffs).DataSize;
SpikeTraceData(BeginTrace).Label.ListText='Puff+Loom';
SpikeTraceData(BeginTrace).Label.YLabel='Puff+Loom binned';
SpikeTraceData(BeginTrace).Label.XLabel=SpikeTraceData(tr_puffs).Label.XLabel;
SpikeTraceData(BeginTrace).Filename=SpikeTraceData(tr_puffs).Filename;
SpikeTraceData(BeginTrace).Path=SpikeTraceData(tr_puffs).Path;


del=2;  %nb of delay points (after the onset of looming stim) to look for loompos data (sampling every 100ms, 2 is 200ms)
% frontval=-15; %vert pos for lomming stimuli in the front
% upval=90; %vert pos for lomming stimuli up (above mouse)
% th=(frontval+upval)/2;

i=length(SpikeTraceData(tr_loomtimes).Trace)
%looping from the end for easier point removal
while i>0
    
    t=SpikeTraceData(tr_loomtimes).XVector(i)
    v=[];
    v=find(SpikeTraceData(tr_puffs).XVector>t);
    if length(v)>=1
        SpikeTraceData(tr_puffs).XVector(v(1));
    end
    
    %here test whether puff present or not within 1s window after
    %visual stim:
     if length(v)>=1
        if SpikeTraceData(tr_puffs).XVector(v(1))<t+1 %first puff following looming is less than 1s after looming starts, remove from 'loom only' list
            SpikeTraceData(tr_loom).XVector(i)=[]; %remove stim from 'loom only' list
            SpikeTraceData(tr_loom).Trace(i)=[];
            SpikeTraceData(tr_loom).DataSize=SpikeTraceData(tr_loom).DataSize-1;
        else %no puff after looming; remove from "loom+puff' list
            SpikeTraceData(tr_loom_puff).XVector(i)=[]; %remove stim from 'loom+puff' list
            SpikeTraceData(tr_loom_puff).Trace(i)=[];
            SpikeTraceData(tr_loom_puff).DataSize=SpikeTraceData(tr_loom_puff).DataSize-1;
        end
    else %no puff after last looming
        SpikeTraceData(tr_loom_puff).XVector(i)=[]; %remove stim from 'loom+puff' list
        SpikeTraceData(tr_loom_puff).Trace(i)=[];
        SpikeTraceData(tr_loom_puff).DataSize=SpikeTraceData(tr_loom_puff).DataSize-1;
    end
        
    i=i-1;
end

i=length(SpikeTraceData(tr_puffs).Trace)
%looping from the end for easier point removal
while i>0
        
    t=SpikeTraceData(tr_puffs).XVector(i)
    v=[];
    v=find(SpikeTraceData(tr_loomtimes).XVector<t);
    if length(v)>=1
        SpikeTraceData(tr_loomtimes).XVector(v(end))
    end
    
    %here test whether looming stim present or not within 1s window before
    %puff:
     
    if length(v)>=1
        if SpikeTraceData(tr_loomtimes).XVector(v(end))>t-1 %last loom preceding puff is less than 1s before puff, remove from 'puff only' list
            SpikeTraceData(tr_puff).XVector(i)=[]; %remove stim from 'puff only' list
            SpikeTraceData(tr_puff).Trace(i)=[];
            SpikeTraceData(tr_puff).DataSize=SpikeTraceData(tr_puff).DataSize-1;
        else
            SpikeTraceData(tr_puff_loom).XVector(i)=[]; %remove stim from 'puff+loom' list
            SpikeTraceData(tr_puff_loom).Trace(i)=[];
            SpikeTraceData(tr_puff_loom).DataSize=SpikeTraceData(tr_puff_loom).DataSize-1;            
        end
        
    else %no loom before the first puff
        SpikeTraceData(tr_puff_loom).XVector(i)=[]; %remove stim from 'puff+loom' list
        SpikeTraceData(tr_puff_loom).Trace(i)=[];
        SpikeTraceData(tr_puff_loom).DataSize=SpikeTraceData(tr_puff_loom).DataSize-1;        
    end
    
   i=i-1 
end

