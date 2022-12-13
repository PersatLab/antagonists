% !This code needs to be used after running the ImageJ macro 1_split_image.ijm!
% This script is only for image sequences that have no fluorescence channel!
close all
clear all

%% To Modify:

% Search all fields with "directory" and replace with your personal directories
% Rename only strings but no variables!

dir_BacStalk='C:\directory\Matlab_scripts\'; % directory of BacStalk_modified folder and this script
dir_func='C:\directory\'; % directory of the Functions folder
directory_data='G:\directory\'; % directory of the data processed by the ImageJ macro 1_split_image.ijm

% Select folders from csv file (Format column 1, 2, 3 must be Pil_types, dates, intervals, respectively)
[num,txt,~]=xlsread('Data_Input_Basic_Analysis.xlsx'); % must be located in dir_BacStalk
dates = num(:,1); % read as a column vector
Pil_types = txt(:,1); % read as a cell with one column
intervals = txt(:,3); % read as a cell with one column

% Select what part of the script to run
change_parameters_format = 1; % 1 if YES 0 if NO: this creates a 'parameters.mat' document with the info needed for the analysis. Run once to convert the csv files. 
do_BacStalk = 1; % 1 if YES 0 if NO
do_SaveVariables = 1;  % 1 if YES 0 if NO
do_video = 1; % 1 if YES 0 if NO: creates movies as individual images with below conditions. Requires the ImageJ macro 2_make_video.ijm to ocnvert to a .tif movie.
do_nonmoving = 0; % 1 if YES 0 if NO: makes movie of non-moving cells - just to check correct speed threshold !Won't do it when speed_limit=0!
do_fluopoles = 0; % must be 0 here because no fluorescent channel

% for Backstalk:
% recommended to run separate default BacStalk with a couple of images and figure out the best settings
mean_cell_size='8'; %in pixel
min_cell_size='6'; %in pixel
search_radius='20'; %in pixel
dilation_width='0.5'; %in pixel

% speed limit (in pixel per frame, typically use 1, note: changes according to frame interval) 
speed_limit=1;  % if set to 0 disables speed limit ("non_moving" cells will be empty) and not all downstream analysis scripts will work because some need a non-moving fraction

%% add path folder with functions
addpath(strcat(dir_func,'Functions')); 

%% Start:
for d=1:1:size(dates,1)

    Pil_type=Pil_types{d}
    date=num2str(dates(d))
    interval=intervals{d}
    
    adresse_data=strcat(directory_data,Pil_type,'\',date,'\',interval);
    addpath(adresse_data);

    folders=dir(adresse_data);
    num_folders=length(folders)-2;

    for folder=1:1:num_folders
      Pil_nbr=folder
        %% Step 1:Load data
        adresse=strcat(adresse_data,'\',num2str(Pil_nbr));
        addpath(adresse) % for the folder
        adresse  
        
        time=size(imfinfo(strcat(adresse,'\C0-data.tif')),1); %to count how many 'C0-data_t' image are in the folder.
        %% Step 2: save the parameters
        if change_parameters_format
          read_parameters(adresse);
        end
        load('parameters.mat','delta_x');
        %% Step 3: BacStalk
        if do_BacStalk
          addpath(strcat(directory,'BacStalk_modified')); 
          BacStalk_automated(adresse,time,mean_cell_size,min_cell_size,num2str(delta_x),search_radius,dilation_width)%directory,Pil_type,date,interval,Pil_nbr);
        end
        %% Step 4: Study video
        [speed_filter]=check_speed(speed_limit);
        [BactID,cell_prop,Data_speed...
          ,BactID_non_moving,cell_prop_non_moving,Data_speed_non_moving]=study_BacStalk_Phase(adresse,speed_limit,1);
        nbr_bact=size(BactID,1);
        %% Step 5: save all variables
        if ~speed_filter
            filename=strcat(adresse,'\variables_noSL.mat');
        else
            filename=strcat(adresse,'\variables.mat');
        end
        if do_SaveVariables
            save(filename)
        end
        %% step 6: create images for video 
        if do_video
            create_image_for_video(adresse,time,do_fluopoles,cell_prop,1,speed_filter);
            if do_nonmoving & speed_filter
                create_image_for_video(adresse,time,do_fluopoles,cell_prop_non_moving,0,speed_filter);
            end
        end
        %% step FINAL: remove path
        rmpath(adresse)
    end
     rmpath(adresse_data)
end
