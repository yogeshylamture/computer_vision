%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %  
%                           Hogeschool Antwerpen                          %
%                Industriële Wetenschappen: Elektronica-ICT               %
%                      MultiMediaGroep - Watermarking                     %
%                                                                         %
%                                                                         %
%                             Masterthesis 4.2                            %
%                                Kevin Heylen                             %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%watermark: this function will generate the required watermarked image.

function watermark()

%Use this part to specify to wat kind of value was used fixed/linear/specified
%Get the structure to get the size, values and names
iMark_script= get_root_data('iMark_script');

local_path = get_root_data('local_path');

%generate orignal path
time = datestr(now);
W = numel(time);
for i = 1:W
    if strcmp(time(1,i),':')
        time(1,i) = '-';
    %elseif strcmp(time(1,i),':')
    %    time(1,i) = '-';
    else
        time(1,i) = time(1,i);
    end
end


layer = iMark_script.name_embedding_layer;
imwrite_path = strcat(local_path,'\Output\',time,'\');
set_root_data('NaN','imwrite_path',imwrite_path);
mkdir(strcat(imwrite_path,'Watermarked'));
       
name_algo = iMark_script.embed_algorithm;
embed_parameters = iMark_script.embed_parameters;
[path name_algo ext vers] = fileparts(name_algo);

path_dataset = iMark_script.path_dataset;


files = dir(fullfile(strcat(path_dataset) , '\*.tif*'));
i=1;
name_image = cell(numel(files),1);
while i<=numel(files)
    current_image = files(i,1);
    name_image(i,1) = {current_image.name};
    i = i + 1;
end

dataset = char(name_image);
            
%generate_binary message
type = iMark_script.message_type;

if strcmp(type,'text')
    
    k = fopen(iMark_script.message_path,'r');
    [file,count] = fread(k, '*char');
    message_string = dec2bin(file,8);
    message_binary = '';
    for i = 1:count 
       message_binary = strcat(message_binary,message_string(i,:));
    end
    fclose(k);
    
elseif strcmp(type,'image')
    
    [image_binary] = dec2bin(imread(iMark_script.message_path),8);

    [H_binary_message W_binary_message D_binary] = size(image_binary);
    
    message_binary = '';
    for i = 1:H_binary_message 
       message_binary = strcat(message_binary,image_binary(i,:));
    end
    
else
    message_binary = '0101010101010101';
end

keys_dataset = '';
watermarked_image_paths = '';

number_of_images = size(dataset,1);
for noi = 1:number_of_images        %you can paralize this by using parfor future version. feval is already used to excecute algorithms
    
    %calculate the prefered layer
    name_image = dataset(noi,:);
    [path name ext versn] = fileparts(name_image);
    path_image = strcat(path_dataset,'\',dataset(noi,:));
    save_name = strcat(local_path,'\Output\',time,'\Watermarked\',name,'_',layer);
    [original_image working_image] = (calculate_working_image(path_image,layer));
    
    %initialization
        i = 1;              %used in the for loop to get the name en values
        specified = 1;      %standard 1 if otherwise the values are specified
        start_value = 1;    %standard 1 
        step_value = 1;     %standard 1
        end_value = 1;      %standard 1(if not same as start_value the while lus while repeat

        name_specified_parameter = '';
        name_linear_parameter = '';

        input_parameters = struct('original_image',original_image,'working_image',working_image,'layer',layer,'message_binary',message_binary);
        set_root_data('NaN','input_parameters',input_parameters);
        single_embedding_parameters = struct([]);
        embed_cell = struct2cell(embed_parameters);                                 %convert to a cell to get the values

        [H_embed_cell] = size(embed_cell,1);                %Get the size of the cell
        number_of_var = H_embed_cell;

        while i <= number_of_var
            names_variables = fieldnames(embed_parameters);
            variable = char(names_variables(i,1));
            name_parameter = char(strcat('iMark_script.embed_parameters.',variable));       %name value
            
            
            %name_parameter = char(strcat('iMark_script.embed_parameters.',embed_cell((i*2)-1,1),'_value'));       %name valu
            value_parameter = eval(name_parameter);                                                                 %get the value

            [H_value_parameter W_value_parameter D_value_parameter] = size(value_parameter);

            if ischar(value_parameter)              %if the value is a char
                if H_value_parameter == 1
                    if isempty(single_embedding_parameters)
                        single_embedding_parameters = setfield(input_parameters,strcat('var',num2str(i)),value_parameter);
                    else
                        single_embedding_parameters = setfield(single_embedding_parameters,strcat('var',num2str(i)),value_parameter);
                    end
                else
                    specified = H_value_parameter;                  %The number of specified values is equal to the height 
                    name_specified_parameter = strcat('var',num2str(i));
                    if isempty(single_embedding_parameters)
                        single_embedding_parameters = setfield(input_parameters,strcat('var',num2str(i)),value_parameter);
                    else
                        single_embedding_parameters = setfield(single_embedding_parameters,strcat('var',num2str(i)),value_parameter);
                    end
                end
            else                                    % the value is a double or an integer
                if H_value_parameter == W_value_parameter == 1 %the value is fixed
                    if isempty(single_embedding_parameters)
                        single_embedding_parameters = setfield(input_parameters,strcat('var',num2str(i)),value_parameter);
                    else
                        single_embedding_parameters = setfield(single_embedding_parameters,strcat('var',num2str(i)),value_parameter);
                    end
                elseif H_value_parameter ~= 1 && W_value_parameter == 1     % the values are specified
                    specified = H_value_parameter;
                    name_specified_parameter = strcat('var',num2str(i));
                    if isempty(single_embedding_parameters)
                        single_embedding_parameters = setfield(input_parameters,strcat('var',num2str(i)),value_parameter);
                    else
                        single_embedding_parameters = setfield(single_embedding_parameters,strcat('var',num2str(i)),value_parameter);
                    end
                elseif H_value_parameter == 1 && W_value_parameter ~= 1
                    start_value = value_parameter(1,1);    
                    end_value = value_parameter(1,2);
                    step_value = value_parameter(1,3);     
                    if isempty(single_embedding_parameters)
                        single_embedding_parameters = setfield(input_parameters,strcat('var',num2str(i)),value_parameter);
                    else
                        single_embedding_parameters = setfield(single_embedding_parameters,strcat('var',num2str(i)),value_parameter);
                    end
                    name_linear_parameter = strcat('var',num2str(i));
                end
            end
            i = i + 1;
        end
        name_setting = '';
        
        for j = 1:specified

        %calculate the random key and save it for future decoding
        key = calculate_random_key(iMark_script.key_size);
        %save key for future decoding
        keys_dataset = strvcat(key,keys_dataset);
        set_root_data('NaN','key_dataset',keys_dataset);
        single_embedding_parameters = setfield(single_embedding_parameters,'key',key);
            
            if specified == 1 && start_value == end_value        %the values are all fixed         

                [watermarked_image] = feval(name_algo,single_embedding_parameters);

                %save
                for k = 1:number_of_var
                    name_variable = char(names_variables(k,1));
                    value_current_setting = getfield(single_embedding_parameters,strcat('var',num2str(k)));

                    if ischar(value_current_setting)
                        if isempty(name_setting)
                            name_setting = strcat(name_variable,'_',value_current_setting);
                        else
                            name_setting = strcat('_',name_setting,'_',name_variable,'_',value_current_setting);
                        end
                    else
                        if isempty(name_setting)
                            name_setting = strcat(name_variable,'_',num2str(value_current_setting));
                        else
                            name_setting = strcat('_',name_setting,'_',name_variable,'_',num2str(value_current_setting));
                        end
                    end
                end
                save_string = strcat(save_name,name_setting,'.tif');
                watermarked_image_paths = strvcat(watermarked_image_paths, save_string);
                image_to_save = reconstuct_original_dimensions(watermarked_image);
                imwrite(image_to_save ,save_string,'Compression','none');


            elseif start_value ~= end_value                                        %the values are linear
                current_value = start_value;        %initialize current value
                while current_value <= end_value 
                    name_setting = '';
                    single_parameters = setfield(single_embedding_parameters,name_linear_parameter,current_value);
                    [watermarked_image] = feval(name_algo,single_parameters);

                    %save
                    for k = 1:number_of_var
                        name_current_setting = char(names_variables(k,1));
                        value_current_setting = getfield(single_embedding_parameters,strcat('var',num2str(k)));
                        [H_value W_value D_value] = size(value_current_setting);
                        if ischar(value_current_setting)
                            if isempty(name_setting)
                                name_setting = strcat(name_current_setting,'_',value_current_setting);
                            else
                                    name_setting = strcat('_',name_setting,'_',name_current_setting,'_',value_current_setting);
                            end
                        else
                            if W_value == 1
                                if isempty(name_setting)
                                    name_setting = strcat(name_current_setting,'_',num2str(value_current_setting));
                                else
                                    name_setting = strcat('_',name_setting,'_',name_current_setting,'_',num2str(value_current_setting));
                                end
                            else
                                if isempty(name_setting)
                                    name_setting = strcat(name_current_setting,'_',num2str(current_value));
                                else
                                    name_setting = strcat('_',name_setting,'_',name_current_setting,'_',num2str(current_value));
                                end
                            end

                        end
                    end
                    save_string = strcat(save_name,name_setting,'.tif');
                    watermarked_image_paths = strvcat(watermarked_image_paths, save_string);
                    image_to_save = reconstuct_original_dimensions(watermarked_image);
                    imwrite(image_to_save ,save_string,'Compression','none');

                     current_value = current_value + step_value;
                end

            else    %the values are specified
                if j == 1
                    list_specified = getfield(single_embedding_parameters,name_specified_parameter);
                else
                end

                if ischar(list_specified)
                    current_value = list_specified(j,:);

                    single_parameters = setfield(single_embedding_parameters,name_specified_parameter,current_value);
                    [watermarked_image] = feval(name_algo,single_parameters);
                else
                    current_value = list_specified(j,1);

                    single_parameters = setfield(single_embedding_parameters,name_specified_parameter,current_value);
                    [watermarked_image] = feval(name_algo,single_parameters);
                end

                %save
                name_setting = '';
                    for k = 1:number_of_var
                        name_current_setting = char(names_variables(k,1));
                        value_current_setting = getfield(single_embedding_parameters,strcat('var',num2str(k)));
                        [H_value] = size(value_current_setting,1);
                        if H_value == 1
                            if ischar(value_current_setting)
                                if isempty(name_setting)
                                    name_setting = strcat(name_current_setting,'_',value_current_setting);
                                else
                                    name_setting = strcat('_',name_setting,'_',name_current_setting,'_',value_current_setting);
                                end
                            else
                                if isempty(name_setting)
                                    name_setting = strcat(name_current_setting,'_',num2str(value_current_setting));
                                else
                                    name_setting = strcat('_',name_setting,'_',name_current_setting,'_',num2str(value_current_setting));
                                end
                            end
                        else
                            if ischar(value_current_setting)
                                if isempty(name_setting)
                                    name_setting = strcat(name_current_setting,'_',list_specified(j,:));
                                else
                                    name_setting = strcat('_',name_setting,'_',name_current_setting,'_',list_specified(j,:));
                                end
                            else
                                if isempty(name_setting)
                                    name_setting = strcat(name_current_setting,'_',num2str(list_specified(j,1)));
                                else
                                    name_setting = strcat('_',name_setting,'_',name_current_setting,'_',num2str(list_specified(j,1)));
                                end
                            end
                        end
                    end
                    save_string = strcat(save_name,name_setting,'.tif');
                    watermarked_image_paths = strvcat(watermarked_image_paths, save_string);
                    image_to_save = reconstuct_original_dimensions(watermarked_image);
                    imwrite(image_to_save ,save_string,'Compression','none');
            end     
        end
end 
set_root_data('NaN','generated_path',watermarked_image_paths);












