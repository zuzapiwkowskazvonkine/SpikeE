tr_evnts=15;

tr_lfp=9;
prewin=0.5;
postwin=0.5;

deltat=SpikeTraceData(tr_lfp).XVector(5)-SpikeTraceData(tr_lfp).XVector(4);
times_p=zeros(ceil((prewin+postwin)/deltat),length(SpikeTraceData(tr_evnts).Trace));
avgs_p=zeros(ceil((prewin+postwin)/deltat),length(SpikeTraceData(tr_evnts).Trace));

tr_sp=10;
deltat=SpikeTraceData(tr_sp).XVector(5)-SpikeTraceData(tr_sp).XVector(4);
times_s=zeros(ceil((prewin+postwin)/deltat),length(SpikeTraceData(tr_evnts).Trace));
avgs_s=zeros(ceil((prewin+postwin)/deltat),length(SpikeTraceData(tr_evnts).Trace));

tr_spr=14;
deltat=SpikeTraceData(tr_spr).XVector(5)-SpikeTraceData(tr_spr).XVector(4);
times_sr=zeros(ceil((prewin+postwin)/deltat),length(SpikeTraceData(tr_evnts).Trace));
avgs_sr=zeros(ceil((prewin+postwin)/deltat),length(SpikeTraceData(tr_evnts).Trace));

for i=1:length(SpikeTraceData(tr_evnts).Trace)

[times_p(:,i),avgs_p(:,i)]=avg_envelope_select(tr_lfp,tr_evnts,prewin,postwin,i,i);
[times_sp(:,i),avgs_sp(:,i)]=avg_envelope_select(tr_sp,tr_evnts,prewin,postwin,i,i);
[times_spr(:,i),avgs_spr(:,i)]=avg_envelope_select(tr_spr,tr_evnts,prewin,postwin,i,i);

figure
plot(times_p(:,i),avgs_p(:,i)*100,times_sp(:,i),avgs_sp(:,i),'r',times_spr(:,i),avgs_spr(:,i),'k')

end