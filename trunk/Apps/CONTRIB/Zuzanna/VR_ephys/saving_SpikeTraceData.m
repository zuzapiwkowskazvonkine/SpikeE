SpikeTraceData(1).Trace=LFP_data;
SpikeTraceData(1).XVector=0.001*LFP_times;
SpikeTraceData(1).Label.ListText='LFP';
SpikeTraceData(1).Label.XLabel='s';
SpikeTraceData(1).Label.YLabel='mV';
SpikeTraceData(1).DataSize=length(LFP_data);
SpikeTraceData(1).Filename='20171009_171009_c1_summary.mat';
SpikeTraceData(1).Path='D:\Ephys_data\09102017_Metchnikoff';

SpikeTraceData(2).Trace=speed_data;
SpikeTraceData(2).XVector=0.001*speed_times;
SpikeTraceData(2).Label.ListText='speed';
SpikeTraceData(2).Label.XLabel='s';
SpikeTraceData(2).Label.YLabel='cm/s';
SpikeTraceData(2).DataSize=length(speed_data);
SpikeTraceData(2).Filename='20171009_171009_c1_summary.mat';
SpikeTraceData(2).Path='D:\Ephys_data\09102017_Metchnikoff';

SpikeTraceData(3).Trace=ones(1,length(event_times));
SpikeTraceData(3).XVector=0.001*event_times;
SpikeTraceData(3).Label.ListText='airpuffs';
SpikeTraceData(3).Label.XLabel='s';
SpikeTraceData(3).Label.YLabel='events';
SpikeTraceData(3).DataSize=length(event_times);
SpikeTraceData(3).Filename='20171009_171009_c1_summary.mat';
SpikeTraceData(3).Path='D:\Ephys_data\09102017_Metchnikoff';




