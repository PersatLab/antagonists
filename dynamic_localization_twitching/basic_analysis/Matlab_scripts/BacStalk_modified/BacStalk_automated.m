% AUTOMATISATION de l'analyse avec BacStalk
%% BackStalk
function []=BacStalk_automated(adresse,time,mean_cell_size,min_cell_size,delta_x,search_radius,dilation_width)%directory,Pil_type,date,interval,Pil_nbr)

        filename=cell(1,time);
        for t=1:1:time
        filename{t}=char(strcat('C0-data_t',sprintfc('%03d',t-1),'.tif'));
        end

        % start
        BacStalk(mean_cell_size,min_cell_size,delta_x,search_radius,dilation_width)

        % lets add the files
        BacStalk_data = getUIData(gcf);
        addFiles(BacStalk_data,[],filename,adresse)

        % update channel 1
        BacStalk_data = getUIData(gcf);
        updateFileList(BacStalk_data,[])

        % Apply no Stalks
        BacStalk_data = getUIData(gcf);
        applyPreSettings(BacStalk_data,[],'stalks');

        %% Step 2:
        %Not NEEDED
        BacStalk_data = getUIData(gcf);
        showCellDetectionTab(BacStalk_data,[])

        %lets process all images
        BacStalk_data = getUIData(gcf);
        processImages(BacStalk_data,[],'all')

        % let's track all the cells
        BacStalk_data = getUIData(gcf);
        trackCells(BacStalk_data,[])

        %% Step 3:
        % let's save the data
        BacStalk_data = getUIData(gcf);
        showAnalysisTab(BacStalk_data,[]);

        % save data
        BacStalk_data = getUIData(gcf);
        saveData(BacStalk_data,[],adresse);

        %% close BacStalk
        BacStalk_data = getUIData(gcf);
        closeFigure(BacStalk_data,[]);
        
        %rmpath(adresse)
   %end
  % rmpath(adresse1)
end
%end
