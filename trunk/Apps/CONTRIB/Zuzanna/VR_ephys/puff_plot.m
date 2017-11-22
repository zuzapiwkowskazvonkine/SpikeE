function [puffs]=puff_plot(vec,nb_puffs,puff_onset,puff_isi,puff_dur,plot_value)
puffs=zeros(1,length(vec));
% nb_puffs=5;
% puff_onset=4.99;
% puff_isi=0.5;
% puff_dur=0.3;
% plot_value=2.5;

dt=vec(2)-vec(1);

for n=1:nb_puffs
   
    puffs(round((puff_onset+(n-1)*puff_isi)/dt):round((puff_onset+(n-1)*puff_isi+puff_dur)/dt))=plot_value;
    
end