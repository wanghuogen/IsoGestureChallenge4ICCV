clear,clc
parent_dir = 'image4tensorflow/train/';
Norm4S_dir1 = [parent_dir,'train_depth_fullbody/'];
if ~exist(Norm4S_dir1)
    mkdir(Norm4S_dir1);
end
Norm4S_dir2 = [parent_dir,'train_depth_full/'];
if ~exist(Norm4S_dir2)
    mkdir(Norm4S_dir2);
end


fpn = fopen ('DATA/IsoGD_phase_1/IsoGD_phase_1/train_list.txt');
ff_train1 = fopen('image4tensorflow/train/train_depth_fullbody.txt','w');
ff_val1 = fopen('image4tensorflow/train/val_depth_fullbody.txt','w');
ff_train2 = fopen('image4tensorflow/train/train_depth_full.txt','w');
ff_val2 = fopen('image4tensorflow/train/val_depth_full.txt','w');

while feof(fpn) ~= 1                  
      file = fgetl(fpn);          
      obj_origin = VideoReader(['DATA/IsoGD_phase_1/IsoGD_phase_1/',file(23:43)]);
      detectionLabel = fopen(['DATA/DetectionLabel4Depth4train/',file(29:31),'/Label_',file(33:39),'.txt']);
      disp(['Extract frame of ',file(33:39)]);
      numFrames_origin = obj_origin.NumberOfFrames;
      wd = obj_origin.Width;
      ht = obj_origin.Height;
      
      hand_area = zeros(ht,wd,3);
      
      l = 1;
      while feof(detectionLabel) ~= 1
          label_file = fgetl(detectionLabel);           
          numFrame = str2num(label_file(1:4))+1;
          TextFile = textscan(label_file,'%s');
          [m,n] = size(TextFile{1});
          k = (m-1)/4;
          for i = 1:k
              hand_area(str2num(TextFile{1}{4*i-1})+1:str2num(TextFile{1}{4*i+1})+1,str2num(TextFile{1}{4*i-2})+1:str2num(TextFile{1}{4*i})+1,:) = 255;
          end
      end
      fclose(detectionLabel);
      
      hand_area = im2bw(hand_area);
      [LL,num_L] = bwlabel(hand_area);
      stats = regionprops(LL,'Area');     
      area = cat(1,stats.Area);  
      index = find(area >0.5*max(area));          
      img_hand = ismember(LL,index);           
      [row, col] = find( img_hand ~= 0 );
      
      
      
      depth_final = zeros(ht,wd,3);
      outImageNamef = fullfile(Norm4S_dir1,num2str(str2num(file(45:end))-1,'%03d'),file(33:39));
      outImageNamer = fullfile(Norm4S_dir2,num2str(str2num(file(45:end))-1,'%03d'),file(33:39));
      if ~exist(fullfile(Norm4S_dir1,num2str(str2num(file(45:end))-1,'%03d'),file(33:39)))
          mkdir(fullfile(Norm4S_dir1,num2str(str2num(file(45:end))-1,'%03d'),file(33:39)));
      end
      if ~exist(fullfile(Norm4S_dir2,num2str(str2num(file(45:end))-1,'%03d'),file(33:39)))
          mkdir(fullfile(Norm4S_dir2,num2str(str2num(file(45:end))-1,'%03d'),file(33:39)));
      end
      for t = 1:numFrames_origin
          depthmap_origin = read(obj_origin, t);
          imageNamef = fullfile(outImageNamef,sprintf('%s.jpg',num2str(t,'%03d')));
          imageNamer = fullfile(outImageNamer,sprintf('%s.jpg',num2str(t,'%03d')));
          depth_final(min(row):max(row),min(col):max(col),:) = depthmap_origin(min(row):max(row),min(col):max(col),:);
          imwrite(depthmap_origin,imageNamef)
          imwrite(uint8(depth_final),imageNamer)
          depth_final = zeros(ht,wd,3);  
      end
        fprintf(ff_train1,[outImageNamef,' ',num2str(numFrames_origin),' ',num2str(str2num(file(45:end))-1),'\n']);
        fprintf(ff_train2,[outImageNamer,' ',num2str(numFrames_origin),' ',num2str(str2num(file(45:end))-1),'\n']);
        if mod(str2num(file(35:39)),3)==0
            fprintf(ff_val1,[fullfile(Norm4S_dir1,file(33:39)),' ',num2str(numFrames_origin),' ',num2str(str2num(file(45:end))-1),'\n']);
            fprintf(ff_val2,[fullfile(Norm4S_dir2,file(33:39)),' ',num2str(numFrames_origin),' ',num2str(str2num(file(45:end))-1),'\n']);
        end
      
end
fclose(ff_train1);
fclose(ff_val1);
fclose(ff_train2);
fclose(ff_val2);
fclose(fpn);
