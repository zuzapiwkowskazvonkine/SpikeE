%plot Max Resp vs. size of stripe (Xdim=300, ie parasagittal)

pje=[pje; zeros(1,size(pje,2))];

%find all sagittal stripes and squares (xdim=300)
ids=find(pje(2,:)==300);  % use pje only -> old cells
table_sag=pje(:,ids);

ids2=find(table_sag(3,:)==30);
table_y30px=table_sag(:,ids2);

ids3=find(table_sag(3,:)==300);
table_y300px=table_sag(:,ids3);

ncells=max(table_y30px(1,:));

for i=1:ncells
    
      
    id30=find(table_y30px(1,:)==i); %get indices for the analyzed cell
    table_cell=table_y30px(:,id30);
    
    mfov=max(table_cell(6,:)); %needed if diff fovs tested for one cell (only for new cells)
    
    for n=1:mfov
        
        id300=find((table_y300px(1,:)==i)&(table_y300px(6,:)==n));
        
        if length(id300>0)
            table_cell_ref=table_y300px(:,id300);
            idf=find(table_cell(6,:)==n);  %30px saggital stripes tested for this fov
            
            if length(idf>0)
            
               ints=table_y30px(4,id30(idf)); %all tested intensitites for this cell and fov (with repeats if they exist)
               
               
              for k=1:length(ints) %loop over all tested intensities
                  
                  ref_ind=find(table_cell_ref(4,:)==ints(k));
                  ref_resp=table_cell_ref(5,ref_ind);
                  
                  if length(ref_ind)>0
                  table_y30px(7,id30(idf(k)))=table_y30px(5,id30(idf(k)))-mean(ref_resp); %add line in table, with nb of spikes in resp - ref resp (negative if missing spikes rel. to 100px stim)
                  else
                  table_y30px(7,id30(idf(k)))=100; %absurd number, to exclude later
                  end
              end
               
                
            end
            
        end
        
    end
    
   
end

rem=find(table_y30px(7,:)==100);
for i=1:length(rem)
    table_y30px(:,rem(i))=[];
end

%%%% ydim = 60 px

ids2=find(table_sag(3,:)==60);
table_y60px=table_sag(:,ids2);

ncells=max(table_y60px(1,:));

for i=1:ncells
    
      
    id30=find(table_y60px(1,:)==i); %get indices for the analyzed cell
    table_cell=table_y60px(:,id30);
    
    mfov=max(table_cell(6,:)); %needed if diff fovs tested for one cell (only for new cells)
    
    for n=1:mfov
        
        id300=find((table_y300px(1,:)==i)&(table_y300px(6,:)==n));
        
        if length(id300>0)
            table_cell_ref=table_y300px(:,id300);
            idf=find(table_cell(6,:)==n);  %60px saggital stripes tested for this fov
            
            if length(idf>0)
            
               ints=table_y60px(4,id30(idf)); %all tested intensitites for this cell and fov (with repeats if they exist)
               
               
              for k=1:length(ints) %loop over all tested intensities
                  
                  ref_ind=find(table_cell_ref(4,:)==ints(k));
                  ref_resp=table_cell_ref(5,ref_ind);
                  
                  if length(ref_ind)>0
                  table_y60px(7,id30(idf(k)))=table_y60px(5,id30(idf(k)))-mean(ref_resp); %add line in table, with nb of spikes in resp - ref resp (negative if missing spikes rel. to 100px stim)
                  else
                  table_y60px(7,id30(idf(k)))=100; %absurd number, to exclude later
                  end
              end
               
                
            end
            
        end
        
    end
    
   
end

rem=find(table_y60px(7,:)==100);
for i=1:length(rem)
    table_y60px(:,rem(i))=[];
end

%%%% ydim = 90 px

ids2=find(table_sag(3,:)==90);
table_y90px=table_sag(:,ids2);

ncells=max(table_y90px(1,:));

for i=1:ncells
    
      
    id30=find(table_y90px(1,:)==i); %get indices for the analyzed cell
    table_cell=table_y90px(:,id30);
    
    mfov=max(table_cell(6,:)); %needed if diff fovs tested for one cell (only for new cells)
    
    for n=1:mfov
        
        id300=find((table_y300px(1,:)==i)&(table_y300px(6,:)==n));
        
        if length(id300>0)
            table_cell_ref=table_y300px(:,id300);
            idf=find(table_cell(6,:)==n);  %60px saggital stripes tested for this fov
            
            if length(idf>0)
            
               ints=table_y90px(4,id30(idf)); %all tested intensitites for this cell and fov (with repeats if they exist)
               
               
              for k=1:length(ints) %loop over all tested intensities
                  
                  ref_ind=find(table_cell_ref(4,:)==ints(k));
                  ref_resp=table_cell_ref(5,ref_ind);
                  
                  if length(ref_ind)>0
                  table_y90px(7,id30(idf(k)))=table_y90px(5,id30(idf(k)))-mean(ref_resp); %add line in table, with nb of spikes in resp - ref resp (negative if missing spikes rel. to 100px stim)
                  else
                  table_y90px(7,id30(idf(k)))=100; %absurd number, to exclude later
                  end
              end
               
                
            end
            
        end
        
    end
    
   
end

rem=find(table_y90px(7,:)==100);
for i=1:length(rem)
    table_y90px(:,rem(i))=[];
end

%%%%%%%%%%%%% mediolateral stripes

%find all mediolateral stripes and squares (ydim=300)
ids=find(pje(3,:)==300);  % use pje only -> old cells
table_ml=pje(:,ids);

ids2=find(table_ml(2,:)==30); %xdim=30
table_x30px=table_ml(:,ids2);

ids3=find(table_ml(2,:)==300);
table_x300px=table_ml(:,ids3);

ncells=max(table_x30px(1,:));

for i=1:ncells
    
    id30=find(table_x30px(1,:)==i); %get indices for the analyzed cell
    table_cell=table_x30px(:,id30);
    
    mfov=max(table_cell(6,:)); %needed if diff fovs tested for one cell (only for new cells)
    
    for n=1:mfov
        
        id300=find((table_x300px(1,:)==i)&(table_x300px(6,:)==n));
        
        if length(id300>0)
            table_cell_ref=table_x300px(:,id300);
            idf=find(table_cell(6,:)==n);  %30px saggital stripes tested for this fov
            
            if length(idf>0)
            
               ints=table_x30px(4,id30(idf)); %all tested intensitites for this cell and fov (with repeats if they exist)
               
               
              for k=1:length(ints) %loop over all tested intensities
                  
                  ref_ind=find(table_cell_ref(4,:)==ints(k));
                  ref_resp=table_cell_ref(5,ref_ind);
                  
                  if length(ref_ind)>0
                  table_x30px(7,id30(idf(k)))=table_x30px(5,id30(idf(k)))-mean(ref_resp); %add line in table, with nb of spikes in resp - ref resp (negative if missing spikes rel. to 100px stim)
                  else
                  table_x30px(7,id30(idf(k)))=100; %absurd number, to exclude later
                  end
              end
               
                
            end
            
        end
        
    end
    
   
end

rem=find(table_x30px(7,:)==100);
for i=1:length(rem)
    table_x30px(:,rem(i))=[];
end

%%%% xdim = 60 px

ids2=find(table_ml(2,:)==60);
table_x60px=table_ml(:,ids2);

ncells=max(table_x60px(1,:));

for i=1:ncells
    
      
    id30=find(table_x60px(1,:)==i); %get indices for the analyzed cell
    table_cell=table_x60px(:,id30);
    
    mfov=max(table_cell(6,:)); %needed if diff fovs tested for one cell (only for new cells)
    
    for n=1:mfov
        
        id300=find((table_x300px(1,:)==i)&(table_x300px(6,:)==n));
        
        if length(id300>0)
            table_cell_ref=table_x300px(:,id300);
            idf=find(table_cell(6,:)==n);  %60px saggital stripes tested for this fov
            
            if length(idf>0)
            
               ints=table_x60px(4,id30(idf)); %all tested intensitites for this cell and fov (with repeats if they exist)
               
               
              for k=1:length(ints) %loop over all tested intensities
                  
                  ref_ind=find(table_cell_ref(4,:)==ints(k));
                  ref_resp=table_cell_ref(5,ref_ind);
                  
                  if length(ref_ind)>0
                  table_x60px(7,id30(idf(k)))=table_x60px(5,id30(idf(k)))-mean(ref_resp); %add line in table, with nb of spikes in resp - ref resp (negative if missing spikes rel. to 100px stim)
                  else
                  table_x60px(7,id30(idf(k)))=100; %absurd number, to exclude later
                  end
              end
               
                
            end
            
        end
        
    end
    
   
end

rem=find(table_x60px(7,:)==100);
for i=1:length(rem)
    table_x60px(:,rem(i))=[];
end

%%%% xdim = 90 px

ids2=find(table_ml(2,:)==90);
table_x90px=table_ml(:,ids2);

ncells=max(table_x90px(1,:));

for i=1:ncells
    
      
    id30=find(table_x90px(1,:)==i); %get indices for the analyzed cell
    table_cell=table_x90px(:,id30);
    
    mfov=max(table_cell(6,:)); %needed if diff fovs tested for one cell (only for new cells)
    
    for n=1:mfov
        
        id300=find((table_x300px(1,:)==i)&(table_x300px(6,:)==n));
        
        if length(id300>0)
            table_cell_ref=table_x300px(:,id300);
            idf=find(table_cell(6,:)==n);  %60px saggital stripes tested for this fov
            
            if length(idf>0)
            
               ints=table_x90px(4,id30(idf)); %all tested intensitites for this cell and fov (with repeats if they exist)
               
               
              for k=1:length(ints) %loop over all tested intensities
                  
                  ref_ind=find(table_cell_ref(4,:)==ints(k));
                  ref_resp=table_cell_ref(5,ref_ind);
                  
                  if length(ref_ind)>0
                  table_x90px(7,id30(idf(k)))=table_x90px(5,id30(idf(k)))-mean(ref_resp); %add line in table, with nb of spikes in resp - ref resp (negative if missing spikes rel. to 100px stim)
                  else
                  table_x90px(7,id30(idf(k)))=100; %absurd number, to exclude later
                  end
              end
               
                
            end
            
        end
        
    end
    
   
end

rem=find(table_x90px(7,:)==100);
for i=1:length(rem)
    table_x90px(:,rem(i))=[];
end

