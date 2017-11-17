function [tr_tw_only,tr_puff_tw,tr_puff_only] = sort_twitches(tr_twitches, tr_puffs, win, tstart, tend)


% Before applying function, threshold speed with refr period 0.4s and thresh 2 cm/s, give resulting
% Trace nb as tr_twitches

% sort detected events (between tstart and tstop) in 3 categories: 
% puff only, no twitch in next win sec (typically win=0.5)
% twitch only, not preceded by puff within win sec
% puff followed by twitch within win sec

%do the whole analysis between tstart and tend (in sec)

%Zuzanna Piwkowska 05/11/2017

global SpikeTraceData

BeginTrace=length(SpikeTraceData)+1;

tr_tw_only=BeginTrace;
SpikeTraceData(BeginTrace).Trace=SpikeTraceData(tr_twitches).Trace;
SpikeTraceData(BeginTrace).XVector=SpikeTraceData(tr_twitches).XVector;
SpikeTraceData(BeginTrace).DataSize=SpikeTraceData(tr_twitches).DataSize;
SpikeTraceData(BeginTrace).Label.ListText='Twitches only';
SpikeTraceData(BeginTrace).Label.YLabel='Twitches only binned';
SpikeTraceData(BeginTrace).Label.XLabel=SpikeTraceData(tr_twitches).Label.XLabel;
SpikeTraceData(BeginTrace).Filename=SpikeTraceData(tr_twitches).Filename;
SpikeTraceData(BeginTrace).Path=SpikeTraceData(tr_twitches).Path;

BeginTrace=length(SpikeTraceData)+1;

tr_puff_tw=BeginTrace;
SpikeTraceData(BeginTrace).Trace=SpikeTraceData(tr_puffs).Trace;
SpikeTraceData(BeginTrace).XVector=SpikeTraceData(tr_puffs).XVector;
SpikeTraceData(BeginTrace).DataSize=SpikeTraceData(tr_puffs).DataSize;
SpikeTraceData(BeginTrace).Label.ListText='Puffs+Twitches only';
SpikeTraceData(BeginTrace).Label.YLabel='Puffs+Twitches binned';
SpikeTraceData(BeginTrace).Label.XLabel=SpikeTraceData(tr_puffs).Label.XLabel;
SpikeTraceData(BeginTrace).Filename=SpikeTraceData(tr_puffs).Filename;
SpikeTraceData(BeginTrace).Path=SpikeTraceData(tr_puffs).Path;

BeginTrace=length(SpikeTraceData)+1;

tr_puff_only=BeginTrace;
SpikeTraceData(BeginTrace).Trace=SpikeTraceData(tr_puffs).Trace;
SpikeTraceData(BeginTrace).XVector=SpikeTraceData(tr_puffs).XVector;
SpikeTraceData(BeginTrace).DataSize=SpikeTraceData(tr_puffs).DataSize;
SpikeTraceData(BeginTrace).Label.ListText='Puffs only';
SpikeTraceData(BeginTrace).Label.YLabel='Puffs only binned';
SpikeTraceData(BeginTrace).Label.XLabel=SpikeTraceData(tr_puffs).Label.XLabel;
SpikeTraceData(BeginTrace).Filename=SpikeTraceData(tr_puffs).Filename;
SpikeTraceData(BeginTrace).Path=SpikeTraceData(tr_puffs).Path;


i=length(SpikeTraceData(tr_twitches).Trace);
%looping from the end for easier point removal
while i>0
    t=SpikeTraceData(tr_twitches).XVector(i);
    v=[];
    v=find(SpikeTraceData(tr_puffs).XVector<=t);
    if t>tend||t<tstart
        SpikeTraceData(tr_tw_only).XVector(i)=[]; %remove twitch from 'tw only' list
        SpikeTraceData(tr_tw_only).Trace(i)=[];
        SpikeTraceData(tr_tw_only).DataSize=SpikeTraceData(tr_tw_only).DataSize-1;
    else
        if length(v)>=1
            tpuff=SpikeTraceData(tr_puffs).XVector(v(end)); %closest time of puff preceding twitch;
            if t-tpuff<win %puff close to twitch, remove from list of 'twitches only'
                SpikeTraceData(tr_tw_only).XVector(i)=[]; %remove twitch from 'tw only' list
                SpikeTraceData(tr_tw_only).Trace(i)=[];
                SpikeTraceData(tr_tw_only).DataSize=SpikeTraceData(tr_tw_only).DataSize-1;
            end
        end
    end
    i=i-1;
end


i=length(SpikeTraceData(tr_puffs).Trace);
%looping from the end for easier point removal
while i>0
    t=SpikeTraceData(tr_puffs).XVector(i);
    v=[];
    v=find(SpikeTraceData(tr_twitches).XVector>=t);
    
    if t>tend||t<tstart % do not include this puff because out of analysis window
        SpikeTraceData(tr_puff_only).XVector(i)=[]; %remove puff from 'puff only' list
        SpikeTraceData(tr_puff_only).Trace(i)=[];
        SpikeTraceData(tr_puff_only).DataSize=SpikeTraceData(tr_puff_only).DataSize-1;
        SpikeTraceData(tr_puff_tw).XVector(i)=[]; %remove puff from 'puff+twitch' list
        SpikeTraceData(tr_puff_tw).Trace(i)=[];
        SpikeTraceData(tr_puff_tw).DataSize=SpikeTraceData(tr_puff_tw).DataSize-1;
    else
        if length(v)>=1
            ttw=SpikeTraceData(tr_twitches).XVector(v(1)); %closest time of twitch following puff;
            if ttw-t<win  %puff close to twitch, remove from list of 'puffs only'
                SpikeTraceData(tr_puff_only).XVector(i)=[]; %remove puff from 'puff only' list
                SpikeTraceData(tr_puff_only).Trace(i)=[];
                SpikeTraceData(tr_puff_only).DataSize=SpikeTraceData(tr_puff_only).DataSize-1;
            else %remove from list 'puff+twitch'
                SpikeTraceData(tr_puff_tw).XVector(i)=[]; %remove puff from 'puff+twitch' list
                SpikeTraceData(tr_puff_tw).Trace(i)=[];
                SpikeTraceData(tr_puff_tw).DataSize=SpikeTraceData(tr_puff_tw).DataSize-1;
            end
        end
    end
    i=i-1;
end

SpikeTraceData(tr_tw_only).DataSize
SpikeTraceData(tr_puff_tw).DataSize
SpikeTraceData(tr_puff_only).DataSize
