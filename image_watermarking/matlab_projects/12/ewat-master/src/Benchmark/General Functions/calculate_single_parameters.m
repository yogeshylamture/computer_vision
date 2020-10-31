function [single_embedding_parameters ,name_specified_parameter,name_linear_parameter, start_value,step_value,end_value,specified] =  calculate_single_parameters(iMark_script,input_parameters,names_variables)

%initialization
        i = 1;              %used in the for loop to get the name en values
        specified = 1;      %standard 1 if otherwise the values are not fixed
        start_value = 1;    %standard 1 
        step_value = 1;     %standard 1
        end_value = 1;      %standard 1(if not same as start_value the while lus while repeat
        name_specified_parameter = '';
        name_linear_parameter ='';
        
        %set_root_data('NaN','input_parameters',input_parameters);
        single_embedding_parameters = struct([]);
        number_of_var = size(names_variables,1);
        
        
        while i <= number_of_var
            
            variable = char(names_variables(i,1));
            
            name_parameter = char(strcat('iMark_script.embed_parameters.',variable));       %name value
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