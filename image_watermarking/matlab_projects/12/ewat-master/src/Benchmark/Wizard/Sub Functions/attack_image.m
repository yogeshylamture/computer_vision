function attack_image()
tic
%Get required data
image_list = get_root_data('generated_path');
iMark_script = get_root_data('iMark_script');
attack_cell = struct2cell(iMark_script.attack_parameters);
imwrite_path = get_root_data('imwrite_path');        

number_of_images = size(image_list,1);
number_of_attacks = size(attack_cell,1);

for i = 1:number_of_images
    current_image_string = image_list(i,:);
    
    [pathstr, name, ext, versn] = fileparts(current_image_string); 
    image = imread(current_image_string);
    
    for j = 1:number_of_attacks
       attack_names = fieldnames(iMark_script.attack_parameters);
       current_attack = char(attack_names(j,:));
       [status mess messid]=mkdir(strcat(imwrite_path,'\Attacked\',current_attack));
       try
           s = warning('off', messid);
       catch
       end
       
       save_path = strcat(imwrite_path,'\Attacked\',current_attack,'\',name);
       
       string_value = strcat('iMark_script.attack_parameters.',current_attack);
       
       %uncommetn for GUI inteface
       %values_current_attack = eval(eval(string_value)); 
       values_current_attack = eval(string_value); 
        
           
       
       type = size(values_current_attack,1);
       
       if type > 1      %the values are linear
           step = 0;
            while values_current_attack(2,1) >= values_current_attack(1,1)+ step;
                value = values_current_attack(1,1)+step;
                string_eval = strcat(current_attack,'_attack(','image,',num2str(double(value)),')');
                
                attacked_image = eval(string_eval);
                imwrite(attacked_image, strcat(save_path,'_',current_attack,'_',num2str(value),'.tif'),'Compression','none');
                
                %add image to generated path
                [H] = size(image_list,1);
                cell_paths = cellstr(image_list);
                cell_paths(H+1,:) = cellstr(strcat(save_path,'_attack_',num2str(value),'.tif'));
                image_list = char(cell_paths);
                

                step = step+ values_current_attack(3,1);
            end
       else
          count_variables = size(values_current_attack,2);
          for k = 1:count_variables
              value = values_current_attack(1,k);
              string_eval = strcat(current_attack,'_attack(','image,',num2str(value),')');
                
              attacked_image = eval(string_eval);
              imwrite(attacked_image, strcat(save_path,'_',current_attack,'_',num2str(value),'.tif'),'Compression','none');
              
              [H] = size(image_list,1);
                cell_paths = cellstr(image_list);
                cell_paths(H+1,:) = cellstr(strcat(save_path,'_attack_',num2str(value),'.tif'));
                image_list = char(cell_paths);
                
          end
       end
       
        
        
        
    end
    temp = 1;
set_root_data(temp,'image_list',image_list); 
image_list
end

toc






