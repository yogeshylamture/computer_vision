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

%benchmark: this function will generate all the required images and results.

function benchmark(iMark_script)
%% Get required structure
    tic;
    set_root_data('NaN','iMark_script',iMark_script);
    local_path = get_root_data('local_path');
    assignin('base','iMark_script',iMark_script);
%% Generate orignal directories
    time = datestr(now);
    W = numel(time);
    for i = 1:W
        if strcmp(time(1,i),':')
            time(1,i) = '-';
        else
            time(1,i) = time(1,i);
        end
    end
    imwrite_path = strcat(local_path,'\Output\',time,'\');
    set_root_data('NaN','imwrite_path',imwrite_path);
    %Make 3 subdirectories for displaying the watermarked, attacked and the results
    mkdir(strcat(imwrite_path,'Watermarked'));
    mkdir(strcat(imwrite_path,'Attacked'));
    mkdir(strcat(imwrite_path,'Results'));
    
    
%% Extract the required data

    path_dataset = iMark_script.path_dataset;
    layer = iMark_script.name_embedding_component;              %Name of the embedding layer
    filename_embed_algo = iMark_script.embed_algorithm;         %Embed algorithm to evaluate
    [path name_embed_algo ext vrs] = fileparts(filename_embed_algo);
    
    filename_detect_algo = iMark_script.detect_algorithm;       %Detect algorithm to evaluate
    [path name_detect_algo ext vrs] = fileparts(filename_detect_algo);
    
    
%% Generate a dataset from the path_dataset (only tiff images are used)
    files = dir(fullfile(strcat(path_dataset) , '\*.tif*'));        %if you also want to use different types change the extension
    i=1;
    name_image = cell(numel(files),1);
    while i<=numel(files)
        current_image = files(i,1);
        name_image(i,1) = {current_image.name};
        i = i + 1;
    end
    dataset = char(name_image);
    number_of_images = size(dataset,1); 
    
%% Generate the binary message from the type and message path
message = iMark_script.message;
    
%% Benchmark    
keys_dataset = '';
watermarked_image_paths = '';
results_metric1_attacked_struct = struct([]);
results_metric2_attacked_struct = struct([]);
results_BER_struct = struct([]);
for noi = 1:number_of_images        %you can paralize this by using parfor future version. feval is already used to excecute algorithms
    
%% calculate the prefered layer
        name_image = dataset(noi,:);
        [path name ext versn] = fileparts(name_image);
        path_image = strcat(path_dataset,'\',dataset(noi,:));
        save_name = strcat(local_path,'\Output\',time,'\Watermarked\',name,'_',layer);
        [original_image working_image] = (calculate_working_image(path_image,layer));
        
        embed_parameters = iMark_script.embed_parameters;           %Embedding variables (structure)
        embed_cell = struct2cell(embed_parameters);                 %convert to a cell to get the values
        [H_embed_cell] = size(embed_cell,1);                        %Get the size of the cell
        number_of_embed_var = H_embed_cell;
        names_embed_variables = fieldnames(embed_parameters);
        
        
%% Calculate single embedding structure 
    
        input_embed_parameters = struct('original_image',original_image,'working_image',working_image,'layer',layer,'message',message);
        [single_embedding_parameters ,name_specified_parameter,name_linear_parameter, start_value,step_value,end_value,specified] = calculate_single_parameters(iMark_script,input_embed_parameters,names_embed_variables);

        name_setting = '';
        j=1;
        for j = 1:specified

        %calculate the random key and save it for future decoding
        key = calculate_random_key(iMark_script.key_size);
        %save key for future decoding
        set_root_data('NaN','current_key',key);
        keys_dataset = strvcat(key,keys_dataset);
        set_root_data('NaN','key_dataset',keys_dataset);
        single_embedding_parameters = setfield(single_embedding_parameters,'key',key);
        
        
        
%% Values are fixed
            if specified == 1 && start_value == end_value        %the values are all fixed       
                    name_setting = '';
                    % generate save string
                    for k = 1:number_of_embed_var
                        name_variable = char(names_embed_variables(k,1));
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
                
                [watermarked_image] = feval(name_embed_algo,single_embedding_parameters);
                image_to_save = reconstuct_original_dimensions(watermarked_image,original_image,layer);
                
                metric1 = iMark_script.metric1;
                metric2 = iMark_script.metric2;

                %Calculate difference with selected metric
                try
                    metric1_value = feval(metric1,original_image,image_to_save);
                catch
                    metric1_value =0;   %an error occurd during the calculation
                end

                try
                    metric2_value = feval(metric2,original_image,image_to_save);
                catch
                    metric2_value =0;
                end

                if noi == 1
                    results_metric1_watermark_cell = cell(number_of_images+1,2);
                    results_metric1_watermark_cell(1,1) = cellstr('Setting/Image');
                    results_metric1_watermark_cell(1,2) = cellstr(name_setting);
                    results_metric1_watermark_cell(noi+1,1) = cellstr(name);
                    results_metric1_watermark_cell(noi+1,2) = num2cell(metric1_value);
                    
                    results_metric2_watermark_cell = cell(number_of_images+1,2);
                    results_metric2_watermark_cell(1,1) = cellstr('Setting/Image');
                    results_metric2_watermark_cell(1,2) = cellstr(name_setting);
                    results_metric2_watermark_cell(noi+1,1) = cellstr(name);
                    results_metric2_watermark_cell(noi+1,2) = num2cell(metric2_value);
                else
                    results_metric1_watermark_cell(noi+1,1) = cellstr(name);
                    results_metric1_watermark_cell(noi+1,2) = num2cell(metric1_value);
                    
                    results_metric2_watermark_cell(noi+1,1) = cellstr(name);
                    results_metric2_watermark_cell(noi+1,2) = num2cell(metric2_value);
                end
                
                nocw = j;
                total_watermarked = specified;
                [results_metric1_attacked_struct,results_metric2_attacked_struct,results_BER_struct] = benchmark_attack(image_to_save,single_embedding_parameters,strcat(name,name_setting),number_of_images,noi,total_watermarked,nocw,results_metric1_attacked_struct,results_metric2_attacked_struct,results_BER_struct);
                    
                
                imwrite(image_to_save ,save_string,'Compression','none');

%% Values are Linear
            elseif start_value ~= end_value                                        %the values are linear
                current_value = start_value;        %initialize current value
                specified = 0;                      
                
                m = 1;
                %determ the number of specified settings
                specified_current_value = current_value;
                while specified_current_value <= end_value 
                    specified = specified + 1;
                    specified_current_value = specified_current_value + step_value;
                end
                
                while current_value <= end_value 
                    single_parameters = setfield(single_embedding_parameters,name_linear_parameter,current_value);
                    name_setting = '';
                        % generate save string
                        for k = 1:1:number_of_embed_var
                            name_current_setting = char(names_embed_variables(k,1));
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
                        current_value = current_value + step_value;
                        
                        save_string = strcat(save_name,name_setting,'.tif');
                        watermarked_image_paths = strvcat(watermarked_image_paths, save_string);
                        
                        [watermarked_image] = feval(name_embed_algo,single_parameters);
                        image_to_save = reconstuct_original_dimensions(watermarked_image,original_image,layer);
                        
                        metric1 = iMark_script.metric1;
                        metric2 = iMark_script.metric2;

                        %Calculate difference with selected metric
                        try
                            metric1_value = feval(metric1,original_image,image_to_save);
                        catch
                            metric1_value =0;   %an error occurd during the calculation
                        end

                        try
                            metric2_value = feval(metric2,original_image,image_to_save);
                        catch
                            metric2_value =0;
                        end
                        
                        if m == 1 && noi == 1
                            results_metric1_watermark_cell = cell(number_of_images+1,specified+1);
                            results_metric1_watermark_cell(1,1) = cellstr('Setting/Image');
                            results_metric1_watermark_cell(1,2) = cellstr(name_setting);
                            results_metric1_watermark_cell(2,1) = cellstr(name);
                            results_metric1_watermark_cell(2,2) = num2cell(metric1_value);
                            
                            results_metric2_watermark_cell = cell(number_of_images+1,specified+1);
                            results_metric2_watermark_cell(1,1) = cellstr('Setting/Image');
                            results_metric2_watermark_cell(1,2) = cellstr(name_setting);
                            results_metric2_watermark_cell(2,1) = cellstr(name);
                            results_metric2_watermark_cell(2,2) = num2cell(metric2_value);
                        elseif m == 1 && noi ~=1
                            results_metric1_watermark_cell(noi+1,1) = cellstr(name);
                            results_metric1_watermark_cell(noi+1,2) = num2cell(metric1_value);
                            
                            results_metric2_watermark_cell(noi+1,1) = cellstr(name);
                            results_metric2_watermark_cell(noi+1,2) = num2cell(metric2_value);
                        else
                            results_metric1_watermark_cell(1,m+1) = cellstr(name_setting);
                            results_metric1_watermark_cell(noi+1,m+1) = num2cell(metric1_value);
                            
                            results_metric2_watermark_cell(1,m+1) = cellstr(name_setting);
                            results_metric2_watermark_cell(noi+1,m+1) = num2cell(metric2_value);
                        end
                        
                        
                        
                        
                        nocw = m;
                        
                        total_watermarked = specified;
                        [results_metric1_attacked_struct,results_metric2_attacked_struct,results_BER_struct] = benchmark_attack(image_to_save,single_parameters,strcat(name,name_setting),number_of_images,noi,total_watermarked,nocw,results_metric1_attacked_struct,results_metric2_attacked_struct,results_BER_struct);
                    
                        
                        m = m + 1;
                        
                        imwrite(image_to_save ,save_string,'Compression','none');

                        
                end
                
%% Values are specified
            else    %the values are specified
                
                name_setting = '';
                if j == 1
                    list_specified = getfield(single_embedding_parameters,name_specified_parameter);
                else
                end

                if ischar(list_specified)
                    current_value = list_specified(j,:);
                else
                    current_value = list_specified(j,1);
                end

                single_parameters = setfield(single_embedding_parameters,name_specified_parameter,current_value);
                
                % generate save string
                    for k = 1:number_of_embed_var
                        name_current_setting = char(names_embed_variables(k,1));
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
                    
                    [watermarked_image] = feval(name_embed_algo,single_parameters);
                    image_to_save = reconstuct_original_dimensions(watermarked_image,original_image,layer);
                    imwrite(image_to_save ,save_string,'Compression','none');
                    
                    metric1 = iMark_script.metric1;
                    metric2 = iMark_script.metric2;
    
                    %Calculate difference with selected metric
                    try
                        metric1_value = feval(metric1,original_image,image_to_save);
                    catch
                        metric1_value =0;   %an error occurd during the calculation
                    end
                    
                    try
                        metric2_value = feval(metric2,original_image,image_to_save);
                    catch
                        metric2_value =0;
                    end
                   
                    if j == 1 && noi == 1
                        results_metric1_watermark_cell = cell(number_of_images+1,specified+1);
                        results_metric1_watermark_cell(1,1) = cellstr('Setting/Image');
                        results_metric1_watermark_cell(1,2) = cellstr(name_setting);
                        results_metric1_watermark_cell(2,1) = cellstr(name);
                        results_metric1_watermark_cell(2,2) = num2cell(metric1_value);
                        
                        results_metric2_watermark_cell = cell(number_of_images+1,specified+1);
                        results_metric2_watermark_cell(1,1) = cellstr('Setting/Image');
                        results_metric2_watermark_cell(1,2) = cellstr(name_setting);
                        results_metric2_watermark_cell(2,1) = cellstr(name);
                        results_metric2_watermark_cell(2,2) = num2cell(metric2_value);
                        
                    elseif j == 1 && noi ~=1
                        results_metric1_watermark_cell(noi+1,1) = cellstr(name);
                        results_metric1_watermark_cell(noi+1,2) = num2cell(metric1_value);
                        
                        results_metric2_watermark_cell(noi+1,1) = cellstr(name);
                        results_metric2_watermark_cell(noi+1,2) = num2cell(metric2_value);
                    else
                        results_metric1_watermark_cell(1,j+1) = cellstr(name_setting);
                        results_metric1_watermark_cell(noi+1,j+1) = num2cell(metric1_value);
                        
                        results_metric2_watermark_cell(1,j+1) = cellstr(name_setting);
                        results_metric2_watermark_cell(noi+1,j+1) = num2cell(metric2_value);
                    end
                    
                    nocw = j;
                    total_watermarked = specified;
                    [results_metric1_attacked_struct,results_metric2_attacked_struct,results_BER_struct] = benchmark_attack(image_to_save,single_parameters,strcat(name,name_setting),number_of_images,noi,total_watermarked,nocw,results_metric1_attacked_struct,results_metric2_attacked_struct,results_BER_struct);
                    
            end  
            
        end
end 
toc;
time_elapsed = toc;
assignin('base','time_elapsed',num2str(time_elapsed/60));

assignin('base','results_watermark_metric1',results_metric1_watermark_cell);
assignin('base','results_watermark_metric2',results_metric2_watermark_cell);

assignin('base','results_attack_metric1',results_metric1_attacked_struct);
assignin('base','results_attack_metric2',results_metric2_attacked_struct);

assignin('base','results_BER',results_BER_struct);


%% Start the report generator settings
java.util.Locale.setDefault(java.util.Locale.US); %set up the default language as English 
cd(strcat(imwrite_path,'Results'));   %change directory for saving the report

file_format = iMark_script.file_format;
notify = iMark_script.notify;

 switch file_format
     case 'pdf'
         
         general_pdf_report = strcat(local_path,'\Report Generators\pdf_general_report');
         pdf_report = report(general_pdf_report);

         if strcmp(notify,'on')
            email_list = iMark_script.email_list;
            account = iMark_script.account';
            account_password = iMark_script.account_password;
            subject = iMark_script.subject;
            email_message= iMark_script.email_message;
            report_attached = iMark_script.report_attached;
            
            %put emails in cell
            k=fopen(email_list,'r');
            number_of_line = 1;
            while 1
                tline = fgetl(k);
                if ~ischar(tline),   break,   end
                email_list_cell(number_of_line,:) = cellstr(tline);
                number_of_line = number_of_line +1;
            end
            fclose(k);
            
            %initialize matlab to be able to send mails through gmail
            gmail_sendmail(account,account_password);
            
            if strcmp(report_attached,'yes')
                sendmail(email_list_cell,subject,email_message,pdf_report);
            else
                sendmail(email_list_cell,subject,email_message);
            end
            
        else
        end
         
         
     case 'html'
         general_html_report = strcat(local_path,'\Report Generators\html_general_report');
         html_report = report(general_html_report);

         if strcmp(notify,'on')
            email_list = iMark_script.email_list;
            account = iMark_script.account';
            account_password = iMark_script.account_password;
            subject = iMark_script.subject;
            email_message= iMark_script.email_message;
            
            %put emails in cell
            k=fopen(email_list,'r');
            number_of_line = 1;
            while 1
                tline = fgetl(k);
                if ~ischar(tline),   break,   end
                email_list_cell(number_of_line,:) = cellstr(tline);
                number_of_line = number_of_line +1;
            end
            fclose(k);
            
            %initialize matlab to be able to send mails through gmail
            gmail_sendmail(account,account_password);
            
            sendmail(email_list_cell,subject,email_message);
        else
        end
        
        if strcmp(iMark_script.upload_results,'yes')
            current_directory = cd;
            host = iMark_script.ftp_site;
            username = iMark_script.username;
            password = iMark_script.ftp_password;
            
            ftp_site  = ftp(host,username,password);
            mput(ftp_site,current_directory) 
        else
        end
         
     case 'rtf'
         general_rtf_report = strcat(local_path,'\Report Generators\rtf_general_report');
         rtf_report = report(general_rtf_report);

         if strcmp(notify,'on')
            email_list = iMark_script.email_list;
            account = iMark_script.account';
            account_password = iMark_script.account_password;
            subject = iMark_script.subject;
            email_message= iMark_script.email_message;
            report_attached = iMark_script.report_attached;
            
            %put emails in cell
            k=fopen(email_list,'r');
            number_of_line = 1;
            while 1
                tline = fgetl(k);
                if ~ischar(tline),   break,   end
                email_list_cell(number_of_line,:) = cellstr(tline);
                number_of_line = number_of_line +1;
            end
            fclose(k);
            
            %initialize matlab to be able to send mails through gmail
            gmail_sendmail(account,account_password);
            
            if strcmp(report_attached,'yes')
                sendmail(email_list_cell,subject,email_message,rtf_report);
            else
                sendmail(email_list_cell,subject,email_message);
            end
            
        else
        end
 end
         
cd(local_path);   %change back to root directory
clear all;



































