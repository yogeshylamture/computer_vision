function metric_BER = watermark_decoder(iMark_script,attacked_image,single_parameters)

component = iMark_script.name_embedding_component;              %Name of the embedding layer
filename_detect_algo = iMark_script.detect_algorithm;       %Detect algorithm to evaluate
[path name_detect_algo ext vrs] = fileparts(filename_detect_algo);

[detect_original_image detect_working_image] = (calculate_working_image(attacked_image,component));
        
single_detect_parameters = setfield(single_parameters,'original_image',detect_original_image);
single_detect_parameters = setfield(single_detect_parameters,'working_image',detect_working_image);

[decoded_message] = feval(name_detect_algo,single_detect_parameters);

original_message = single_detect_parameters.message;
metric_BER = ber(original_message,decoded_message);
                        