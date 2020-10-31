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


function [results_metric1_attacked_struct,results_metric2_attacked_struct,results_BER_struct] = benchmark_attack(image_to_attack,single_parameters,name,number_of_images,current_image,total_watermarked,current_watermarked,results_metric1_attacked_struct,results_metric2_attacked_struct,results_BER_struct)

%Get required data
iMark_script = get_root_data('iMark_script');
attack_cell = struct2cell(iMark_script.attack_parameters);
imwrite_path = get_root_data('imwrite_path');        

number_of_attacks = size(attack_cell,1);

    for j = 1:number_of_attacks
       attack_names = fieldnames(iMark_script.attack_parameters);
       current_attack = char(attack_names(j,:));
       [status mess messid]=mkdir(strcat(imwrite_path,'\Attacked\',current_attack));
       try
           warning('off', messid);
       catch
       end
       
       save_path = strcat(imwrite_path,'\Attacked\',current_attack,'\',name);
       
       string_value = strcat('iMark_script.attack_parameters.',current_attack);
       
       values_current_attack = eval(string_value); 
       type = size(values_current_attack,1);
       
       if type > 1      %the values are linear
           step = 0;
           m = 1;
           specified = 0;
           
           while values_current_attack(2,1) >= values_current_attack(1,1)+ step;
               
                specified = specified +1;
                step = step+ values_current_attack(3,1);
           end
           
           step = 0;
            while values_current_attack(2,1) >= values_current_attack(1,1)+ step;
                value = values_current_attack(1,1)+step;
                string_eval = strcat(current_attack,'_attack(','image_to_attack,',num2str(double(value)),')');
                
                attacked_image = eval(string_eval);
                %Decoder algorithm needs to come here
                metric_BER = watermark_decoder(iMark_script,attacked_image,single_parameters);
                %end decoder
                
                imwrite(attacked_image, strcat(save_path,'_',current_attack,'_',num2str(value),'.tif'),'Compression','none');
                
              %use resize for metric value
              [ori_H] = size(image_to_attack,1);
              [ori_W] = size(image_to_attack,2);
              
              [at_H] = size(attacked_image,1);
              [at_W] = size(attacked_image,2);
              
              resolution_ori = ori_H*ori_W;
              resolution_at = at_H*at_W;
              if resolution_ori ~= resolution_at                    %the dimensions are changed 
                  resize_option = iMark_script.resize_geometrical;
                  if strcmp(resize_option,'on')
                      interpolation_option = iMark_script.interpolation;
                      
                      attacked_image = imresize(attacked_image,[ori_H ori_W],interpolation_option);
                      
                      metric1_value = feval(iMark_script.metric1,image_to_attack,attacked_image);
                      metric2_value = feval(iMark_script.metric2,image_to_attack,attacked_image);
                      
                  else  
                      metric1_value = 0;
                      metric2_value = 0;
                  end
              else
                    metric1_value = feval(iMark_script.metric1,image_to_attack,attacked_image);
                    metric2_value = feval(iMark_script.metric2,image_to_attack,attacked_image);
              end
              %end resize 

                if step == 0 && current_image == 1 && current_watermarked == 1
                    size_struct = numel(results_metric1_attacked_struct);
                    if isempty(results_metric1_attacked_struct) || size_struct <= number_of_attacks 
                        results_metric1_attacked_cell = cell(number_of_images*total_watermarked+1,specified+1);
                        results_metric1_attacked_cell(1,1) = cellstr(strcat(current_attack,'/ Image'));
                        results_metric1_attacked_cell(1,2) = cellstr(num2str(value));
                        results_metric1_attacked_cell(2,1) = cellstr(name);
                        results_metric1_attacked_cell(2,2) = num2cell(metric1_value);
                        results_metric1_attacked_struct(j).name = current_attack;
                        results_metric1_attacked_struct(j).results = results_metric1_attacked_cell;
                        
                        results_metric2_attacked_cell = cell(number_of_images*total_watermarked+1,specified+1);
                        results_metric2_attacked_cell(1,1) = cellstr(strcat(current_attack,'/ Image'));
                        results_metric2_attacked_cell(1,2) = cellstr(num2str(value));
                        results_metric2_attacked_cell(2,1) = cellstr(name);
                        results_metric2_attacked_cell(2,2) = num2cell(metric2_value);
                        results_metric2_attacked_struct(j).name = current_attack;
                        results_metric2_attacked_struct(j).results = results_metric2_attacked_cell;
                        
                        results_BER_cell = cell(number_of_images*total_watermarked+1,specified+1);
                        results_BER_cell(1,1) = cellstr(strcat(current_attack,'/ Image'));
                        results_BER_cell(1,2) = cellstr(num2str(value));
                        results_BER_cell(2,1) = cellstr(name);
                        results_BER_cell(2,2) = num2cell(metric_BER);
                        results_BER_struct(j).name = 'BER';
                        results_BER_struct(j).results = results_BER_cell;
                    elseif current_watermarked ~= 1
                        results_metric1_attacked_cell = results_metric1_attacked_struct(j).results;
                        results_metric1_attacked_cell(current_image+current_watermarked,1) = cellstr(name);
                        results_metric1_attacked_cell(current_image+current_watermarked-1,m+1) = num2cell(metric1_value);
                        results_metric1_attacked_struct(j).results = results_metric1_attacked_cell;
                        
                        results_metric2_attacked_cell = results_metric2_attacked_struct(j).results;
                        results_metric2_attacked_cell(current_image+current_watermarked,1) = cellstr(name);
                        results_metric2_attacked_cell(current_image+current_watermarked-1,m+1) = num2cell(metric2_value);
                        results_metric2_attacked_struct(j).results = results_metric2_attacked_cell;
                        
                        results_BER_cell = results_BER_struct(j).results;
                        results_BER_cell(current_image+current_watermarked,1) = cellstr(name);
                        results_BER_cell(current_image+current_watermarked-1,m+1) = num2cell(metric_BER);
                        results_BER_struct(j).results = results_BER_cell;
                    else
                        results_metric1_attacked_cell = results_metric1_attacked_struct(j).results;
                        results_metric1_attacked_cell(current_image+current_watermarked,1) = cellstr(name);
                        results_metric1_attacked_cell(current_image+current_watermarked,m+1) = num2cell(metric1_value);
                        results_metric1_attacked_struct(j).results = results_metric1_attacked_cell;
                        
                        results_metric2_attacked_cell = results_metric2_attacked_struct(j).results;
                        results_metric2_attacked_cell(current_image+current_watermarked,1) = cellstr(name);
                        results_metric2_attacked_cell(current_image+current_watermarked,m+1) = num2cell(metric2_value);
                        results_metric2_attacked_struct(j).results = results_metric2_attacked_cell;
                        
                        results_BER_cell = results_BER_struct(j).results;
                        results_BER_cell(current_image+current_watermarked,1) = cellstr(name);
                        results_BER_cell(current_image+current_watermarked,m+1) = num2cell(metric_BER);
                        results_BER_struct(j).results = results_BER_cell;
                    end
                elseif step == 0 && current_image == 1 && current_watermarked ~= 1
                    results_metric1_attacked_cell = results_metric1_attacked_struct(j).results;
                    results_metric1_attacked_cell(current_watermarked+1,1) = cellstr(name);
                    results_metric1_attacked_cell(current_watermarked+1,2) = num2cell(metric1_value);
                    results_metric1_attacked_struct(j).results = results_metric1_attacked_cell;
                    
                    results_metric2_attacked_cell = results_metric2_attacked_struct(j).results;
                    results_metric2_attacked_cell(current_watermarked+1,1) = cellstr(name);
                    results_metric2_attacked_cell(current_watermarked+1,2) = num2cell(metric2_value);
                    results_metric2_attacked_struct(j).results = results_metric2_attacked_cell;  
                    
                    results_BER_cell = results_BER_struct(j).results;
                    results_BER_cell(current_watermarked+1,1) = cellstr(name);
                    results_BER_cell(current_watermarked+1,2) = num2cell(metric_BER);
                    results_BER_struct(j).results = results_BER_cell;  
                    
                elseif step == 0  && current_image ~=1
                    results_metric1_attacked_cell = results_metric1_attacked_struct(j).results;
                    results_metric1_attacked_cell((total_watermarked*current_image-(total_watermarked-1))+current_watermarked,1) = cellstr(name);
                    results_metric1_attacked_cell((total_watermarked*current_image-(total_watermarked-1))+current_watermarked,2) = num2cell(metric1_value);
                    results_metric1_attacked_struct(j).results = results_metric1_attacked_cell;
                    
                    results_metric2_attacked_cell = results_metric2_attacked_struct(j).results;
                    results_metric2_attacked_cell((total_watermarked*current_image-(total_watermarked-1))+current_watermarked,1) = cellstr(name);
                    results_metric2_attacked_cell((total_watermarked*current_image-(total_watermarked-1))+current_watermarked,2) = num2cell(metric2_value);
                    results_metric2_attacked_struct(j).results = results_metric2_attacked_cell;
                    
                    results_BER_cell = results_BER_struct(j).results;
                    results_BER_cell((total_watermarked*current_image-(total_watermarked-1))+current_watermarked,1) = cellstr(name);
                    results_BER_cell((total_watermarked*current_image-(total_watermarked-1))+current_watermarked,2) = num2cell(metric_BER);
                    results_BER_struct(j).results = results_BER_cell;
                    
                else
                    results_metric1_attacked_cell = results_metric1_attacked_struct(j).results;
                    results_metric1_attacked_cell(1,m+1) = cellstr(num2str(value));
                    if current_image == 1
                        results_metric1_attacked_cell(current_image+current_watermarked,m+1) = num2cell(metric1_value);
                    else
                        results_metric1_attacked_cell((total_watermarked*current_image-(total_watermarked-1))+current_watermarked,m+1) = num2cell(metric1_value);
                    end
                    results_metric1_attacked_struct(j).results = results_metric1_attacked_cell;
                    
                    results_metric2_attacked_cell = results_metric2_attacked_struct(j).results;
                    results_metric2_attacked_cell(1,m+1) = cellstr(num2str(value));
                    if current_image == 1
                        results_metric2_attacked_cell(current_image+current_watermarked,m+1) = num2cell(metric2_value);
                    else
                        results_metric2_attacked_cell((total_watermarked*current_image-(total_watermarked-1))+current_watermarked,m+1) = num2cell(metric2_value);
                    end
                    results_metric2_attacked_struct(j).results = results_metric2_attacked_cell;
                    
                    results_BER_cell = results_BER_struct(j).results;
                    results_BER_cell(1,m+1) = cellstr(num2str(value));
                    if current_image == 1
                        results_BER_cell(current_image+current_watermarked,m+1) = num2cell(metric2_value);
                    else
                        results_BER_cell((total_watermarked*current_image-(total_watermarked-1))+current_watermarked,m+1) = num2cell(metric_BER);
                    end
                    results_BER_struct(j).results = results_BER_cell;
                end
                m = m + 1;
                step = step+ values_current_attack(3,1);
            end
       else             %the values are specified
          count_variables = size(values_current_attack,2);
          for k = 1:count_variables
              value = values_current_attack(1,k);
              string_eval = strcat(current_attack,'_attack(','image_to_attack,',num2str(value),')');
                
              attacked_image = eval(string_eval);
              imwrite(attacked_image, strcat(save_path,'_',current_attack,'_',num2str(value),'.tif'),'Compression','none');
              
              %use resize for metric value
              %use resize for metric value
              [ori_H] = size(image_to_attack,1);
              [ori_W] = size(image_to_attack,2);
              
              [at_H] = size(attacked_image,1);
              [at_W] = size(attacked_image,2);
              
              resolution_ori = ori_H*ori_W;
              resolution_at = at_H*at_W;
              if resolution_ori ~= resolution_at                    %the dimensions are changed 
                  try
                      resize_option = iMark_script.resize_geometrical;
                  catch
                      resize_option = 'off';
                  end
                  if strcmp(resize_option,'on')
                      interpolation_option = iMark_script.interpolation;
                      
                      attacked_image = imresize(attacked_image,[ori_H ori_W],interpolation_option);
                      %Decoder algorithm needs to come here
                        metric_BER = watermark_decoder(iMark_script,attacked_image,single_parameters);
                      %end decoder
                      
                      metric1_value = feval(iMark_script.metric1,image_to_attack,attacked_image);
                      metric2_value = feval(iMark_script.metric2,image_to_attack,attacked_image);
                      
                  else  
                      metric1_value = 0;
                      metric2_value = 0;
                  end
              else
                    metric1_value = feval(iMark_script.metric1,image_to_attack,attacked_image);
                    metric2_value = feval(iMark_script.metric2,image_to_attack,attacked_image);
              end
              %end resize 

                if k == 1 && current_image == 1 && current_watermarked == 1        %initialize cell results
                    size_struct = numel(results_metric1_attacked_struct);
                    if isempty(results_metric1_attacked_struct) || size_struct <= number_of_attacks 
                        results_metric1_attacked_cell = cell(number_of_images*total_watermarked+1,count_variables+1);
                        results_metric1_attacked_cell(1,1) = cellstr(strcat(current_attack,'/ Image'));
                        results_metric1_attacked_cell(1,2) = cellstr(num2str(value));
                        results_metric1_attacked_cell(2,1) = cellstr(name);
                        results_metric1_attacked_cell(2,2) = num2cell(metric1_value);
                        results_metric1_attacked_struct(j).name = current_attack;
                        results_metric1_attacked_struct(j).results = results_metric1_attacked_cell;
                        
                        results_metric2_attacked_cell = cell(number_of_images+1,count_variables+1);
                        results_metric2_attacked_cell(1,1) = cellstr(strcat(current_attack,'/ Image'));
                        results_metric2_attacked_cell(1,2) = cellstr(num2str(value));
                        results_metric2_attacked_cell(2,1) = cellstr(name);
                        results_metric2_attacked_cell(2,2) = num2cell(metric2_value);
                        results_metric2_attacked_struct(j).name = current_attack;
                        results_metric2_attacked_struct(j).results = results_metric2_attacked_cell;
                        
                        results_BER_cell = cell(number_of_images+1,count_variables+1);
                        results_BER_cell(1,1) = cellstr(strcat(current_attack,'/ Image'));
                        results_BER_cell(1,2) = cellstr(num2str(value));
                        results_BER_cell(2,1) = cellstr(name);
                        results_BER_cell(2,2) = num2cell(metric_BER);
                        results_BER_struct(j).name = 'BER';
                        results_BER_struct(j).results = results_BER_cell;
                     else
                        results_metric1_attacked_cell = results_metric1_attacked_struct(j).results;
                        results_metric1_attacked_cell(current_image+current_watermarked+1,1) = cellstr(name);
                        results_metric1_attacked_cell(current_image+current_watermarked+1,k+1) = num2cell(metric1_value);
                        results_metric1_attacked_struct(j).results = results_metric1_attacked_cell;
                        
                        results_metric2_attacked_cell = results_metric2_attacked_struct(j).results;
                        results_metric2_attacked_cell(current_image,1) = cellstr(name);
                        results_metric2_attacked_cell(current_image,k+1) = num2cell(metric2_value);
                        results_metric2_attacked_struct(j).results = results_metric2_attacked_cell;
                        
                        results_BER_cell = results_BER_struct(j).results;
                        results_BER_cell(current_image,1) = cellstr(name);
                        results_BER_cell(current_image,k+1) = num2cell(metric_BER);
                        results_BER_struct(j).results = results_BER_cell;
                    end
                elseif k == 1 && current_image ~=1
                    results_metric1_attacked_cell = results_metric1_attacked_struct(j).results;
                    results_metric1_attacked_cell(current_image+current_watermarked+1,1) = cellstr(name);
                    results_metric1_attacked_cell(current_image+current_watermarked+1,2) = num2cell(metric1_value);
                    results_metric1_attacked_struct(j).results = results_metric1_attacked_cell;
                    
                    results_metric2_attacked_cell = results_metric2_attacked_struct(j).results;
                    results_metric2_attacked_cell(current_image,1) = cellstr(name);
                    results_metric2_attacked_cell(current_image,2) = num2cell(metric2_value);
                    results_metric2_attacked_struct(j).results = results_metric2_attacked_cell;
                    
                    results_BER_cell = results_BER_struct(j).results;
                    results_BER_cell(current_image,1) = cellstr(name);
                    results_BER_cell(current_image,2) = num2cell(metric_BER);
                    results_BER_struct(j).results = results_BER_cell;
                else
                    results_metric1_attacked_cell = results_metric1_attacked_struct(j).results;
                    results_metric1_attacked_cell(1,k+1) = cellstr(num2str(value));
                    if current_watermarked == 1
                        results_metric1_attacked_cell(current_image+current_watermarked,k+1) = num2cell(metric1_value);
                    else
                        results_metric1_attacked_cell(current_image+current_watermarked+1,k+1) = num2cell(metric1_value);
                    end
                    results_metric1_attacked_struct(j).results = results_metric1_attacked_cell;
                    
                    
                    results_metric2_attacked_cell = results_metric2_attacked_struct(j).results;
                    results_metric2_attacked_cell(1,k+1) = cellstr(num2str(value));
                    if current_watermarked == 1
                        results_metric2_attacked_cell(current_image+current_watermarked,k+1) = num2cell(metric2_value);
                    else
                        results_metric2_attacked_cell(current_image+current_watermarked+1,k+1) = num2cell(metric2_value);
                    end
                    results_metric2_attacked_struct(j).results = results_metric2_attacked_cell;
                    
                    
                    results_BER_cell = results_BER_struct(j).results;
                    results_BER_cell(1,k+1) = cellstr(num2str(value));
                    if current_watermarked == 1
                        results_BER_cell(current_image+current_watermarked,k+1) = num2cell(metric2_value);
                    else
                        results_BER_cell(current_image+current_watermarked+1,k+1) = num2cell(metric_BER);
                    end
                    results_BER_struct(j).results = results_BER_cell;
                end
          end
       end
    end
    
    
    
    
    


