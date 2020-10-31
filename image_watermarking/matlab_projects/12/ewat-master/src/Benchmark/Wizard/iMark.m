%% IMark DO NOT EDIT
function varargout = iMark(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @iMark_OpeningFcn, ...
                   'gui_OutputFcn',  @iMark_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

%% Opening Function
function iMark_OpeningFcn(hObject, eventdata, handles, varargin)
        
        %clc;
        
        handles.output = hObject;
        guidata(hObject, handles);
        
        setappdata(0,'hroot_data',gcf);
        set_root_data(handles,'local_path',cd);
        
        user_interface(handles,'input');    %This function is used to to navigate trough the different steps in the program
        set(handles.tab_axes_image,'Visible','off');
        set(handles.tab_images_dataset,'Visible','off');
        set(handles.tab_summary_input,'Visible','off');
        set(handles.tab_key,'Visible','off');
        
        
        set(handles.popup_spectrum,'Enable','off');
        set(handles.popup_layer,'Enable','off');
        set(handles.popup_key_size,'Enable','off');
        set(handles.checkbox_input_done,'Enable','off');
        set(handles.checkbox_watermark_done,'Enable','off');
        set(handles.checkbox_attack_done,'Enable','off');
        set(handles.input_message,'Enable','off');
        
        iMark_script = struct('path_dataset','','dataset','','name_embedding_component','Red Layer','message','','key_size',64);
        set_root_data(handles,'iMark_script',iMark_script);
        
        disable_watermark(handles);
        
%% Output function
function varargout = iMark_OutputFcn(hObject, eventdata, handles) 

        varargout{1} = handles.output;

%% Buttons Load
function btn_load_Callback(hObject, eventdata, handles)

    [tempname, path] = uigetfile({'*.tif*','TIF images'},'Select a TIF image');
    if tempname ==0;
        msgbox('No image was selected','Warning','warn');
        
        set(handles.tab_axes_image,'Visible','off');
        set(handles.tab_images_dataset,'Visible','off');
        
        set(handles.popup_spectrum,'Enable','off');
        set(handles.popup_layer,'Enable','off');
        set(handles.popup_key_size,'Enable','off');
        set(handles.checkbox_input_done,'Enable','off');
        set(handles.checkbox_watermark_done,'Enable','off');
        set(handles.checkbox_attack_done,'Enable','off');
        set(handles.btn_open_message,'Enable','off');
        set(handles.btn_open_key,'Enable','off');
        
        user_interface(handles,'input'); 
    else
        [filepath ,filename,ext,tempver] = fileparts(strcat(path, '\', tempname));
        set(handles.txt_input_images, 'String', strcat('Image name: ', [filename ext]));                     %displays name of selected image in textbox

        image_info= imfinfo([filepath filename ext]);
        image_type = getfield(image_info,'ColorType');
        switch image_type
            case 'grayscale'
                %read image
                image =imread([filepath filename ext]);
                image = cat(3,image,image,image);
                set(handles.popup_spectrum,'Enable','off');
                set(handles.popup_layer,'Enable','off');
                
                set(handles.popup_spectrum,'String','No Spectrum');
                set(handles.popup_layer,'String','Single layers');
               
            case 'truecolor'
                %read image
                image =imread([filepath filename ext]);
                
                set(handles.popup_spectrum,'String',{'RGB','NTSC(YIQ)','YCbCr*','HSV','Not Specified'});
                set(handles.popup_layer,'String',{'Red layer','Green layer','Blue layer'});

                set(handles.popup_spectrum,'Enable','on');
                set(handles.popup_layer,'Enable','on');
           case 'indexed'
                %read image
                [image_index,image_map] =imread([filepath filename ext]);
                
                set(handles.popup_spectrum,'String',{'RGB','NTSC(YIQ)','YCbCr*','HSV','Not Specified'});
                set(handles.popup_layer,'String',{'Red layer','Green layer','Blue layer'});

                image = ind2rgb(image_index,image_map);
                set(handles.popup_spectrum,'Enable','on');
                set(handles.popup_layer,'Enable','on');
        end
        
         axes(handles.axes_loaded_image);
         imshow(cat(3,image(:,:,1),image(:,:,2),image(:,:,3)));   %Because tif image can have 4 layer only show the first tree
         set(handles.tab_axes_image,'Visible','on');
         set(handles.tab_images_dataset,'Visible','off');
         
         enable_input(handles);
         
        %update the stucture
        iMark_script = get_root_data('iMark_script');
        iMark_script = setfield(iMark_script,'path_dataset',filepath);
        set_root_data(handles,'iMark_script',iMark_script);
        %end updating structure
    end
function btn_image_dataset_Callback(hObject, eventdata, handles)

    [directory] = uigetdir(cd,'Choose your image dataset');
    if isempty(directory);
        warndlg('No directory was selected');
    else
        set(handles.txt_input_images, 'String',strcat('Input directory: ', directory));                     %displays name of selected image in textbox
        files = dir(fullfile(directory , '\*.tif*'));
        if isempty(files)
            warndlg('There were no .tif images found in the selected directory');
        else
            i=1;
            while i<=numel(files)
                current_image = files(i,1);
                name_image(i,1) = {current_image.name};
                i = i + 1;
                
                set(handles.tab_axes_image,'Visible','off');
                set(handles.tab_images_dataset,'Visible','on');
                set(handles.listbox_dataset,'String',name_image);
            
                enable_input(handles);
                
            end
            
            dataset_string = get(handles.listbox_dataset,'String');
            
            %update the stucture
            iMark_script = get_root_data('iMark_script');
            iMark_script = setfield(iMark_script,'path_dataset',directory);
            set_root_data(handles,'iMark_script',iMark_script);
            %end updating structure
            set(handles.popup_spectrum,'String',{'RGB','NTSC(YIQ)','YCbCr*','HSV','Not Specified'});
            set(handles.popup_layer,'String',{'Red layer','Green layer','Blue layer'});    
        end
    end

function listbox_dataset_Callback(hObject, eventdata, handles)
function listbox_dataset_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end    
    
%% Input Settings
function popup_spectrum_Callback(hObject, eventdata, handles)
        
        spectrum = get(handles.popup_spectrum,'Value');
        switch spectrum
            case 1.0    %rgb selected
                string = {'Red layer','Green layer','Blue layer'};
                set(handles.popup_layer,'string',string);
                set(handles.popup_layer,'value',1.0);
                
                %update the stucture
                iMark_script = get_root_data('iMark_script');
                iMark_script = setfield(iMark_script,'name_embedding_component','Red Layer');
                set_root_data(handles,'iMark_script',iMark_script);
                %end updating structure
            case 2.0    %NTSC/YIQ is selected
                string = {'Y-layer','I-layer','Q-layer'};
                set(handles.popup_layer,'string',string);
                set(handles.popup_layer,'value',1.0);
                
                %update the stucture
                iMark_script = get_root_data('iMark_script');
                iMark_script = setfield(iMark_script,'name_embedding_component','NTSC Layer');
                set_root_data(handles,'iMark_script',iMark_script);
                %end updating structure
                
            case 3.0    %YCbCr is selected
                msgbox('This will rescale your color values If you are sure please continue, otherwise NTSC(YIQ) is a beter choise. For more information please check the MatLab help file','Warning','warn') 
                string = {'Y-layer','Cb-layer','Cr-layer'};
                set(handles.popup_layer,'string',string);
                set(handles.popup_layer,'value',1.0);
                
                %update the stucture
                iMark_script = get_root_data('iMark_script');
                iMark_script = setfield(iMark_script,'name_embedding_component','Y Layer');
                set_root_data(handles,'iMark_script',iMark_script);
                %end updating structure
            case 4.0    %HSV is selected
                string = {'Hue layer','Saturation layer','Value layer'};
                set(handles.popup_layer,'string',string);
                set(handles.popup_layer,'value',1.0);
                
                %update the stucture
                iMark_script = get_root_data('iMark_script');
                iMark_script = setfield(iMark_script,'name_embedding_component','Hue Layer');
                set_root_data(handles,'iMark_script',iMark_script);
                %end updating structure
            case 5.0
                string = {'All layers'};
                set(handles.popup_layer,'string',string);
                set(handles.popup_layer,'Enable','off');
                iMark_script = get_root_data('iMark_script');
                iMark_script = setfield(iMark_script,'name_embedding_component','All Layers');
                set_root_data(handles,'iMark_script',iMark_script);
                
        end
function popup_spectrum_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

function popup_layer_Callback(hObject, eventdata, handles)

        spectrum = get(handles.popup_spectrum,'Value');
        layer = get(handles.popup_layer,'Value');
        iMark_script = get_root_data('iMark_script');
        switch layer
            case 1.0    %layer 1 is selected
                if spectrum == 1    %RGB is selected
                    %update the stucture
                    iMark_script = setfield(iMark_script,'name_embedding_component','Red Layer');
                    %end updating structure
                elseif spectrum == 2    %NTSC is selected
                    %update the stucture
                    iMark_script = setfield(iMark_script,'name_embedding_component','NTSC Y Layer');
                    %end updating structure
                elseif spectrum == 3    %YCbCr is selected 
                    %update the stucture
                    iMark_script = setfield(iMark_script,'name_embedding_component','Y Layer');
                    %end updating structure
                elseif spectrum == 4    %YCbCr is selected 
                    %update the stucture
                    iMark_script = setfield(iMark_script,'name_embedding_component','Hue Layer');
                    %end updating structure
                end
            case 2.0    %layer 2 is selected
                if spectrum == 1    %RGB is selected
                    %update the stucture
                    iMark_script = setfield(iMark_script,'name_embedding_component','Green Layer');
                    %end updating structure
                elseif spectrum == 2    %NTSC is selected
                    %update the stucture
                    iMark_script = setfield(iMark_script,'name_embedding_component','I Layer');
                    %end updating structure
                elseif spectrum == 3    %YCbCr is selected 
                    %update the stucture
                    iMark_script = setfield(iMark_script,'name_embedding_component','Cb Layer');
                    %end updating structure
                elseif spectrum == 4    %YCbCr is selected 
                    %update the stucture
                    iMark_script = setfield(iMark_script,'name_embedding_component','Saturation Layer');
                    %end updating structure
                end
            case 3.0    %layer 3 is selected
                if spectrum == 1    %RGB is selected
                    %update the stucture
                    iMark_script = setfield(iMark_script,'name_embedding_component','Blue Layer');
                    %end updating structure
                elseif spectrum == 2    %NTSC is selected
                    %update the stucture
                    iMark_script = setfield(iMark_script,'name_embedding_component','Q Layer');
                    %end updating structure
                elseif spectrum == 3    %YCbCr is selected 
                    %update the stucture
                    iMark_script = setfield(iMark_script,'name_embedding_component','Cr Layer');
                    %end updating structure
                elseif spectrum == 4    %YCbCr is selected 
                    %update the stucture
                    iMark_script = setfield(iMark_script,'name_embedding_component','Value Layer');
                    %end updating structure
                end
       end
                set_root_data(handles,'iMark_script',iMark_script);
function popup_layer_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

%% Key Events.
function popup_key_size_Callback(hObject, eventdata, handles)

        size = get(handles.popup_key_size,'Value');
        
        %update the stucture
        iMark_script = get_root_data('iMark_script');
        iMark_script = setfield(iMark_script,'key_size',2^(5+size));
        set_root_data(handles,'iMark_script',iMark_script);
function popup_key_size_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function input_key_Callback(hObject, eventdata, handles)
function input_key_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% Checkbox Done
function checkbox_input_done_Callback(hObject, eventdata, handles)

        current_state = get(handles.checkbox_input_done,'Value');
        if current_state == 1.0
            disable_input(handles);
            enable_watermark(handles);
            
            iMark_script = get_root_data('iMark_script');
            message = get(handles.input_message,'String');
            if isempty(message)
                msgbox('Error','There is no message present at least 1bit must be embedded');
            else
                iMark_script = setfield(iMark_script,'message',message);
                set_root_data(handles,'iMark_script',iMark_script);
            end
           
             set(handles.txt_input_images,'String', strcat('Input Path: ', iMark_script.path_dataset));
             set(handles.txt_embbeding_layer,'String', strcat('Embedding layer: ', iMark_script.name_embedding_component));
             set(handles.txt_message,'String', strcat('Message:', iMark_script.message));
             set(handles.txt_key_size,'String', strcat('Size:', strcat(num2str(iMark_script.key_size),' bit')));

        else
            enable_input(handles);
            disable_watermark(handles);
        end
        
%% Button Next input
function btn_next_input_Callback(hObject, eventdata, handles)

        user_interface(handles,'watermark');
        
%% Popup Scheme
function popup_scheme_Callback(hObject, eventdata, handles)

        selected = get(handles.popup_scheme,'Value');
        
        set(handles.popup_embed_watermark,'Value',1);  
        set(handles.popup_embed_watermark,'Visible','off');
        set(handles.label_embed_watermark,'Visible','off');
        set(handles.btn_edit_embed_watermark,'Visible','off');
        
        set(handles.popup_detect_watermark,'Value',1);  
        set(handles.popup_detect_watermark,'Visible','off');
        set(handles.label_detect_watermark,'Visible','off');
        set(handles.btn_edit_detect_watermark,'Visible','off');
        
        set(handles.checkbox_algorithm_done,'Enable','off');
        if selected == 1
        else
            set(handles.label_domain_watermark,'Visible','on');
            set(handles.popup_domain,'Visible','on');
            set(handles.popup_domain,'Value',1);
            
            dir_list = get(handles.popup_scheme,'String');
            
            dir_name = dir_list(selected,1);
            local_path = get_root_data('local_path');
            current_path = strcat(local_path,'\Watermarking Algorithms\',char(dir_name));
            files = dir(current_path);
            i=3;                                        %The first and second our . and .. so start at index 3
            j=0;                                        %Variable needed for compensating if there are other files present then directorys
            while i<=numel(files)                            %for every file add it to the popup-menu

                list_of_files = files(i);               %Select a file in the structure

                current_name = list_of_files.name;      %Get the name of the selected file
                if list_of_files.isdir == 1
                    text(1,(i-1)-j) = {current_name};             %Make a cell of the current name so you can store it in an string array
                    i = i+1;
                else
                    i = i+1;
                    j = j+1;
                end

            end
            text(1,1) = {'Choose your domain'};
        
            set(handles.popup_domain,'String',text);
            set(handles.popup_domain,'Enable','on');
            
            iMark_script = get_root_data('iMark_script');
            iMark_script = setfield(iMark_script,'scheme',char(dir_name));
            set_root_data(handles,'iMark_script',iMark_script);
        end
function popup_scheme_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

%% Popup Domain
function popup_domain_Callback(hObject, eventdata, handles)
        selected = get(handles.popup_domain,'Value');
        
        set(handles.popup_embed_watermark,'Value',1);  
        set(handles.popup_embed_watermark,'Visible','off');
        set(handles.label_embed_watermark,'Visible','off');
        set(handles.btn_edit_embed_watermark,'Visible','off');
        
        set(handles.popup_detect_watermark,'Value',1);  
        set(handles.popup_detect_watermark,'Visible','off');
        set(handles.label_detect_watermark,'Visible','off');
        set(handles.btn_edit_detect_watermark,'Visible','off');
        
        set(handles.checkbox_algorithm_done,'Enable','off');
        
        if selected == 1
        else
            set(handles.label_embed_watermark,'Visible','on');
            set(handles.popup_embed_watermark,'Visible','on');
            set(handles.popup_embed_watermark,'Enable','on');
            set(handles.popup_embed_watermark,'Value',1);
            
            set(handles.label_detect_watermark,'Visible','on');
            set(handles.popup_detect_watermark,'Visible','on');
            set(handles.popup_detect_watermark,'Enable','on');
            set(handles.popup_detect_watermark,'Value',1);
            
            iMark_script = get_root_data('iMark_script');
            dir_domain = iMark_script.scheme;
            dir_list = get(handles.popup_domain,'String');
            
            dir_name = dir_list(selected,1);
            local_path = get_root_data('local_path');
            current_path = strcat(local_path,'\Watermarking Algorithms\',dir_domain,'\',char(dir_name),'\*.m');
            files = dir(current_path);
            i=1;                                        %The first and second our . and .. so start at index 3
            index_detect = 0;
            index_embed = 0;
            
            while i<=numel(files)                            %for every file add it to the popup-menu
                list_of_files = files(i);               %Select a file in the structure
                current_name = list_of_files.name;      %Get the name of the selected file
                if strcmp(current_name(1,1),'e')
                    embed_text(1,i+1-index_detect) = {current_name};             %Make a cell of the current name so you can store it in an string array
                    index_embed = index_embed +1;
                elseif strcmp(current_name(1,1),'d')
                    detect_text(1,i+1-index_embed) = {current_name};             %Make a cell of the current name so you can store it in an string array
                    index_detect = index_detect +1;
                end
                i = i+1;
            end
            embed_text(1,1) = {'Choose your embed technique'};
            detect_text(1,1) = {'Choose your detect technique'};
        
            iMark_script = get_root_data('iMark_script');
            iMark_script = setfield(iMark_script,'domain',char(dir_name));
            set_root_data(handles,'iMark_script',iMark_script);
        
            set(handles.popup_embed_watermark,'String',embed_text);
            set(handles.popup_detect_watermark,'String',detect_text);
        end
function popup_domain_CreateFcn(hObject, eventdata, handles)

        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

%% Popup Technique.
function popup_embed_watermark_Callback(hObject, eventdata, handles)

        selected_detect = get(handles.popup_detect_watermark,'Value');
        selected_embed = get(handles.popup_embed_watermark,'Value');
        
        if selected_detect == 1.0 || selected_embed == 1.0
            set(handles.checkbox_algorithm_done,'Enable','off');
        else
            set(handles.checkbox_algorithm_done,'Enable','on');
        end

        selected = get(handles.popup_embed_watermark,'Value');
        list = get(handles.popup_embed_watermark,'String');
        name = list(selected,1);
        
        iMark_script = get_root_data('iMark_script');
        iMark_script = setfield(iMark_script,'embed_algorithm',char(name));
        set_root_data(handles,'iMark_script',iMark_script);

        if selected_embed == 1
            set(handles.btn_edit_embed_watermark,'Visible','off');
        else
            set(handles.btn_edit_embed_watermark,'Visible','on');
            set(handles.btn_edit_embed_watermark,'Enable','on');
        end
function popup_embed_watermark_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
        
function popup_detect_watermark_Callback(hObject, eventdata, handles)


        selected_embed = get(handles.popup_embed_watermark,'Value');
        selected_detect = get(handles.popup_detect_watermark,'Value');
        
        if selected_detect == 1.0 || selected_embed == 1.0
            set(handles.checkbox_algorithm_done,'Enable','off');
        else
            set(handles.checkbox_algorithm_done,'Enable','on');
        end

        selected = get(handles.popup_detect_watermark,'Value');
        list = get(handles.popup_detect_watermark,'String');
        name = list(selected,1);
        
        iMark_script = get_root_data('iMark_script');
        iMark_script = setfield(iMark_script,'detect_algorithm',char(name));
        set_root_data(handles,'iMark_script',iMark_script);
        
        
        if selected_detect == 1
            set(handles.btn_edit_detect_watermark,'Visible','off');
        else
            set(handles.btn_edit_detect_watermark,'Visible','on');
            set(handles.btn_edit_detect_watermark,'Enable','on');
        end
function popup_detect_watermark_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function btn_edit_embed_watermark_Callback(hObject, eventdata, handles)

        selected = get(handles.popup_embed_watermark,'Value');
        list = get(handles.popup_embed_watermark,'String');
        
        name = list(selected,1);
        open(char(name));
function btn_edit_detect_watermark_Callback(hObject, eventdata, handles)        
        selected = get(handles.popup_detect_watermark,'Value');
        list = get(handles.popup_detect_watermark,'String');
        
        name = list(selected,1);
        open(char(name));        

%% Checkbox Algorithm Settings Done
function checkbox_algorithm_done_Callback(hObject, eventdata, handles)

    checked = get(handles.checkbox_algorithm_done,'Value');
    
    if checked == 1
        set(handles.popup_scheme,'Enable','off');
        set(handles.popup_domain,'Enable','off');
        set(handles.popup_embed_watermark,'Enable','off');
        set(handles.popup_detect_watermark,'Enable','off');
        
        set(handles.btn_edit_embed_watermark,'Enable','off');
        set(handles.btn_edit_detect_watermark,'Enable','off');
        
        set(handles.tab_parameters,'Visible','on');
        
        set(handles.txt_embed_parameters,'Enable','on');
        set(handles.txt_embed_parameters,'String','');
        
        set(handles.txt_detect_parameters,'Enable','on');
        set(handles.txt_detect_parameters,'String','');
        
        set(handles.btn_configure_embed_parameters,'Enable','on');
        set(handles.btn_configure_detect_parameters,'Enable','on');
        
        set(handles.checkbox_watermark_done,'Value',0);
        set(handles.checkbox_watermark_done,'Enable','off');
        
    else
        set(handles.popup_scheme,'Enable','on');
        set(handles.popup_domain,'Enable','on');
        set(handles.popup_embed_watermark,'Enable','on');
        set(handles.popup_detect_watermark,'Enable','on');
        
        set(handles.btn_edit_embed_watermark,'Enable','on');
        set(handles.btn_edit_detect_watermark,'Enable','on');
        
        set(handles.tab_parameters,'Visible','off');
    end

%% Configure Embed Parameters
function txt_embed_parameters_Callback(hObject, eventdata, handles)
function txt_embed_parameters_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function btn_configure_embed_parameters_Callback(hObject, eventdata, handles)

        string = get(handles.txt_embed_parameters,'String');
        value = int16(str2num(string));
        
        if isempty(value)
            warndlg('Please enter a valid integer');
        elseif value == 0
            set(handles.txt_detect_parameters,'Enable','on');
            set(handles.btn_configure_detect_parameters,'Enable','on');
            set(handles.label_embed_parameters_summary,'String','No additional embed parameters') 
            
            number_of_embed_arguments = '';
            set_root_data(handles,'number_of_embed_arguments',number_of_embed_arguments);
        else
            set_root_data(handles,'number_of_embed_arguments',value);
            
            set_root_data(handles,'main_figure',handles);
            embed_parameters();
            
        end
        
%% Configure Detect Parameters
function txt_detect_parameters_Callback(hObject, eventdata, handles)
function txt_detect_parameters_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function btn_configure_detect_parameters_Callback(hObject, eventdata, handles)
        string = get(handles.txt_detect_parameters,'String');
        value = int16(str2num(string));
        
        if isempty(value)
            warndlg('Please enter a valid integer');
        elseif value == 0
            set(handles.checkbox_watermark_done,'Enable','on');
            
            iMark_script = get_root_data('iMark_script');
            iMark_script = setfield(iMark_script,'detect_parameters',struct([]));
            set_root_data(handles,'iMark_script',iMark_script);
        else
            set_root_data(handles,'number_of_detect_arguments',value);
            
            detect_parameters();
            
        end

%% Checkbox Done Watermark
function checkbox_watermark_done_Callback(hObject, eventdata, handles)

        current_state = get(handles.checkbox_watermark_done,'Value');
        if current_state == 1.0
            set(handles.checkbox_algorithm_done,'Enable','off');
            set(handles.txt_embed_parameters,'Enable','off');
            set(handles.txt_detect_parameters,'Enable','off');
            
            set(handles.btn_configure_embed_parameters,'Enable','off');
            set(handles.btn_configure_detect_parameters,'Enable','off');
            
            set(handles.tab_watermark_summary,'Visible','on');
            
            set(handles.btn_next_watermark,'Enable','on');
            
            iMark_script = get_root_data('iMark_script');
            if isempty(iMark_script.embed_parameters)
                embed_cell = cellstr('No additional embed parameters');
            else
                cell_embed = struct2cell(iMark_script.embed_parameters);
                [H_embed ] = size(cell_embed,1);
                i = 1;
                while i<H_embed
                    names = fieldnames(iMark_script.embed_parameters);
                    name_parameter = char(names(i,:));
                    value_parameter = eval(strcat('iMark_script.embed_parameters.',name_parameter));
                    [H_parameter] = size(value_parameter,1);
                    new_string = '';
                    if i == 1
                        embed_cell = cell(H_embed/2,1);
                        if isa(value_parameter,'numeric') || isa(value_parameter,'double')
                            if H_parameter > 1
                               for j =1:H_parameter
                                   temp_string = num2str(value_parameter(j,:));
                                   new_string = strcat(new_string,temp_string,',');                             

                                   embed_cell(i,:) = cellstr(strcat(name_parameter,'(Specified):',new_string)); 

                               end
                            else
                                embed_cell(i,:) = cellstr(strcat(name_parameter,':',num2str(value_parameter)));
                            end
                        else
                            if H_parameter > 1
                                for j =1:H_parameter
                                   temp_string = (value_parameter(j,:));
                                   new_string = strcat(new_string,temp_string,',');                             

                                   embed_cell(i,:) = cellstr(strcat(name_parameter,'(Specified):',new_string)); 

                                end
                            else
                                embed_cell(i,:) = cellstr(strcat(name_parameter,':',value_parameter));
                            end
                        end
                    else
                        if isa(value_parameter,'numeric') || isa(value_parameter,'double')

                            for j =1:H_parameter
                                   temp_string = num2str(value_parameter(j,:));
                                   new_string = strcat(new_string,temp_string,',');                             
                                    
                                   if i > 3
                                       embed_cell(i-2,:) = cellstr(strcat(name_parameter,':',new_string));
                                   else
                                       embed_cell(i-1,:) = cellstr(strcat(name_parameter,':',new_string));
                                   end
                            end


                        else
                            embed_cell(i-1,:) = cellstr(strcat(name_parameter,':',value_parameter));
                        end
                    end

                    i=i+2;
                end
            end
         
            
            
            iMark_script = get_root_data('iMark_script');
            if isempty(iMark_script.detect_parameters)
                detect_cell = cellstr('No additional detect parameters');
            else
                cell_detect = struct2cell(iMark_script.detect_parameters);
                [H_detect ] = size(cell_detect,1);
                i = 1;
                while i<H_detect
                    name_parameter = char(strcat('iMark_script.detect_parameters.',cellstr(cell_detect(i,1)),'_value'));
                    value_parameter = eval(name_parameter);
                    [H_parameter] = size(value_parameter,1);
                    new_string = '';
                    if i == 1
                        detect_cell = cell(H_detect/2,1);
                        if isa(value_parameter,'numeric') || isa(value_parameter,'double')
                            if H_parameter > 1
                               for j =1:H_parameter
                                   temp_string = num2str(value_parameter(j,:));
                                   new_string = strcat(new_string,temp_string,',');                             

                                   detect_cell(i,:) = strcat(cellstr(cell_detect(i,1)),'(Specified):',new_string); 

                               end
                            else
                                detect_cell(i,:) = strcat(cellstr(cell_detect(i,1)),':',num2str(value_parameter));
                            end
                        else
                            if H_parameter > 1
                                for j =1:H_parameter
                                   temp_string = (value_parameter(j,:));
                                   new_string = strcat(new_string,temp_string,',');                             

                                   detect_cell(i,:) = strcat(cellstr(cell_detect(i,1)),'(Specified):',new_string); 

                                end
                            else
                                detect_cell(i,:) = strcat(cellstr(cell_detect(i,1)),':',value_parameter);
                            end
                        end
                    else
                        if isa(value_parameter,'numeric') || isa(value_parameter,'double')

                            for j =1:H_parameter
                                   temp_string = num2str(value_parameter(j,:));
                                   new_string = strcat(new_string,temp_string,',');                             
                                    
                                   if i > 3
                                       detect_cell(i-2,:) = strcat(cellstr(cell_detect(i,1)),':',new_string);
                                   else
                                       detect_cell(i-1,:) = strcat(cellstr(cell_detect(i,1)),':',new_string);
                                   end
                            end


                        else
                            detect_cell(i-1,:) = strcat(cellstr(cell_detect(i,1)),':',value_parameter);
                        end
                    end

                    i=i+2;
                end
            end
            
            string_embed = char(embed_cell);
            string_detect = char(detect_cell);
            
            set(handles.label_scheme_summary,'String',iMark_script.scheme);
            set(handles.label_domain_summary,'String',iMark_script.domain); 
            set(handles.label_embed_summary,'String',iMark_script.embed_algorithm); 
            set(handles.label_embed_parameters_summary,'String',string_embed); 
            set(handles.label_detect_summary,'String',iMark_script.detect_algorithm);
            set(handles.label_detect_parameters_summary,'String',string_detect); 
        else
            set(handles.checkbox_algorithm_done,'Enable','on');
            set(handles.txt_embed_parameters,'Enable','on');
            set(handles.txt_detect_parameters,'Enable','on');
            
            set(handles.btn_configure_embed_parameters,'Enable','on');
            set(handles.btn_configure_detect_parameters,'Enable','on');
            
            set(handles.tab_watermark_summary,'Visible','off');
            
            set(handles.btn_next_watermark,'Enable','off');
        end

%% Temp make watermarked images
function btn_watermark_Callback(hObject, eventdata, handles)
    %tic    
    %    watermark();
    %toc
        
%% Button Previous
function btn_previous_watermark_Callback(hObject, eventdata, handles)
    user_interface(handles,'input');

%% Button Next Watermark function
function btn_next_watermark_Callback(hObject, eventdata, handles)
    user_interface(handles,'attack');
    tabs_attack(handles,'initialize');
    set(handles.popup_methode,'Enable','off');
    set(handles.btn_next_attack,'Enable','off');
        %Generate empty attack structure
        attack = struct;
        set_root_data(handles,'attack',attack);
        %End generate struct
    set_profile(handles,'iMark');    
    
    set(handles.checkbox_attack_done,'Enable','on');
    
%% Profile    
function popup_profile_Callback(hObject, eventdata, handles)

profile = get(handles.popup_profile,'Value');
reset_checkboxes(handles);
reset_buttons(handles);
disable_values(handles);

switch profile
    case 1.0
        tabs_attack(handles,'compression');
        set_profile(handles,'iMark');
    case 2.0
        tabs_attack(handles,'color manipulation');
        set_profile(handles,'Color Manipulations');
    case 3.0
        tabs_attack(handles,'noise');
        set_profile(handles,'Noise');
    case 4.0
        tabs_attack(handles,'compression');
        set_profile(handles,'Compression');
    case 5.0
        tabs_attack(handles,'enhancements');
        set_profile(handles,'Enhancements');
    case 6.0
        tabs_attack(handles,'geometric');
        set_profile(handles,'Geometric Distortions');
    case 7.0
        tabs_attack(handles,'compression');
        set_profile(handles,'user_defined');
    otherwise
        
end
set(handles.checkbox_attack_done,'Enable','on');
function popup_profile_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Button tabs attack events
function btn_tab_noise_Callback(hObject, eventdata, handles)

    tabs_attack(handles,'noise');
function btn_tab_geometric_Callback(hObject, eventdata, handles)

    tabs_attack(handles,'geometric');
function btn_tab_enhancements_Callback(hObject, eventdata, handles)

    tabs_attack(handles,'enhancements');
function btn_tab_color_manipulation_Callback(hObject, eventdata, handles)

    tabs_attack(handles,'color manipulation');
function btn_tab_compression_Callback(hObject, eventdata, handles)
    
    tabs_attack(handles,'compression');

%% Optional resize
function checkbox_resize_optional_Callback(hObject, eventdata, handles)

    checked = get(handles.checkbox_resize_optional,'Value');
    
    if checked == 1
        set(handles.popup_methode,'Enable','on');
        iMark_script = get_root_data('iMark_script');
        iMark_script = setfield(iMark_script,'resize_geometrical','on');
        iMark_script = setfield(iMark_script,'interpolation','Nearest');
        set_root_data(handles,'iMark_script',iMark_script);
    else
        set(handles.popup_methode,'Enable','off');
        set(handles.popup_methode,'Value',1.0);
        iMark_script = get_root_data('iMark_script');
        iMark_script = setfield(iMark_script,'resize_geometrical','off');
        iMark_script = setfield(iMark_script,'interpolation','Nearest');
        set_root_data(handles,'iMark_script',iMark_script);
    end
function popup_methode_Callback(hObject, eventdata, handles)

    value = get(handles.popup_methode,'Value');
    switch value
        case 1.0
            iMark_script = get_root_data('iMark_script');
            iMark_script = setfield(iMark_script,'interpolation','Nearest');
            set_root_data(handles,'iMark_script',iMark_script);
        case 2.0
            iMark_script = get_root_data('iMark_script');
            iMark_script = setfield(iMark_script,'interpolation','Bilinear');
            set_root_data(handles,'iMark_script',iMark_script);
        case 3.0
            iMark_script = get_root_data('iMark_script');
            iMark_script = setfield(iMark_script,'interpolation','Bicubic');
            set_root_data(handles,'iMark_script',iMark_script);
    end

function popup_methode_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Checkboxes attack
function checkbox_jpg_Callback(hObject, eventdata, handles)
    
    checked = get(handles.checkbox_jpg,'Value');
    
    if checked == 0.0
        remove_attack(handles,'jpg');
    else
        add_attack(handles,'jpg');
    end
function checkbox_color_reduction_Callback(hObject, eventdata, handles)

checked = get(handles.checkbox_color_reduction,'Value');
    
    if checked == 0.0
        remove_attack(handles,'color_reduction');
    else
        add_attack(handles,'color_reduction');
    end
function checkbox_gaussian_noise_Callback(hObject, eventdata, handles)

    checked = get(handles.checkbox_gaussian_noise,'Value');
    
    if checked == 0.0
        remove_attack(handles,'gaussian_noise');
    else
        add_attack(handles,'gaussian_noise');
    end
function checkbox_salt_pepper_noise_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_salt_pepper_noise,'Value');
    
    if checked == 0.0
        remove_attack(handles,'salt_pepper_noise');
    else
        add_attack(handles,'salt_pepper_noise');
    end
function checkbox_bitplane_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_bitplane,'Value');
    
    if checked == 0.0
        remove_attack(handles,'bitplane');
    else
        add_attack(handles,'bitplane');
    end
function checkbox_blur_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_blur,'Value');
    
    if checked == 0.0
        remove_attack(handles,'blur');
    else
        add_attack(handles,'blur');
    end
function checkbox_sharpen_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_sharpen,'Value');
    
    if checked == 0.0
        remove_attack(handles,'disk');
    else
        add_attack(handles,'disk');
    end
function checkbox_motion_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_motion,'Value');
    
    if checked == 0.0
        remove_attack(handles,'motion');
    else
        add_attack(handles,'motion');
    end
function checkbox_speckle_noise_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_speckle_noise,'Value');
    
    if checked == 0.0
        remove_attack(handles,'speckle_noise');
    else
        add_attack(handles,'speckle_noise');
    end
function checkbox_gamma_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_gamma,'Value');
    
    if checked == 0.0
        remove_attack(handles,'gamma');
    else
        add_attack(handles,'gamma');
    end
function checkbox_rotation_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_rotation,'Value');
    
    if checked == 0.0
        remove_attack(handles,'rotation');
    else
        add_attack(handles,'rotation');
    end
function checkbox_rotation_scale_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_rotation_scale,'Value');
    
    if checked == 0.0
        remove_attack(handles,'rotation_scale');
    else
        add_attack(handles,'rotation_scale');
    end
function checkbox_crop_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_crop,'Value');
    
    if checked == 0.0
        remove_attack(handles,'crop');
    else
        add_attack(handles,'crop');
    end
function checkbox_rotation_crop_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_rotation_crop,'Value');
    
    if checked == 0.0
        remove_attack(handles,'rotation_crop');
    else
        add_attack(handles,'rotation_crop');
    end
function checkbox_scale_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_scale,'Value');
    
    if checked == 0.0
        remove_attack(handles,'scale');
    else
        add_attack(handles,'scale');
    end
function checkbox_shear_y_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_shear_y,'Value');
    
    if checked == 0.0
        remove_attack(handles,'shear_y');
    else
        add_attack(handles,'shear_y');
    end
function checkbox_shear_x_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_shear_x,'Value');
    
    if checked == 0.0
        remove_attack(handles,'shear_x');
    else
        add_attack(handles,'shear_x');
    end
function checkbox_flip_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_flip,'Value');
    if checked == 0.0
        attack = get_root_data('attack');
        attack = rmfield(attack,'flip');
        set_root_data(handles,'attack',attack);
    else
        attack = get_root_data('attack');
        attack = setfield(attack,'flip','');
        set_root_data(handles,'attack',attack);
    end
function checkbox_contrast_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_contrast,'Value');
    
    if checked == 0.0
        remove_attack(handles,'contrast');
    else
        add_attack(handles,'contrast');
    end
function checkbox_brighten_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_brighten,'Value');
    
    if checked == 0.0
        remove_attack(handles,'brighten');
    else
        add_attack(handles,'brighten');
    end
function checkbox_y_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_y,'Value');
    
    if checked == 0.0
        remove_attack(handles,'y');
    else
        add_attack(handles,'y');
    end
function checkbox_cb_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_cb,'Value');
    
    if checked == 0.0
        remove_attack(handles,'cb');
    else
        add_attack(handles,'cb');
    end
function checkbox_cr_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_cr,'Value');
    
    if checked == 0.0
        remove_attack(handles,'cr');
    else
        add_attack(handles,'cr');
    end
function checkbox_red_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_red,'Value');
    
    if checked == 0.0
        remove_attack(handles,'red');
    else
        add_attack(handles,'red');
    end
function checkbox_green_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_green,'Value');
    
    if checked == 0.0
        remove_attack(handles,'green');
    else
        add_attack(handles,'green');
    end
function checkbox_blue_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_blue,'Value');
    
    if checked == 0.0
        remove_attack(handles,'blue');
    else
        add_attack(handles,'blue');
    end
function checkbox_hue_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_hue,'Value');
    
    if checked == 0.0
        remove_attack(handles,'hue');
    else
        add_attack(handles,'hue');
    end
function checkbox_saturation_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_saturation,'Value');
    
    if checked == 0.0
        remove_attack(handles,'saturation');
    else
        add_attack(handles,'saturation');
    end
function checkbox_value_Callback(hObject, eventdata, handles)
    checked = get(handles.checkbox_value,'Value');
    
    if checked == 0.0
        remove_attack(handles,'value');
    else
        add_attack(handles,'value');
    end

%% Editbutton values attack
function btn_edit_gaussian_noise_Callback(hObject, eventdata, handles)
function btn_edit_salt_pepper_noise_Callback(hObject, eventdata, handles)
function btn_edit_speckle_noise_Callback(hObject, eventdata, handles)
function btn_edit_bitplane_Callback(hObject, eventdata, handles)
function btn_edit_jpg_Callback(hObject, eventdata, handles)
function btn_edit_blur_Callback(hObject, eventdata, handles)
function btn_edit_sharpen_Callback(hObject, eventdata, handles)
function btn_edit_motion_Callback(hObject, eventdata, handles)
function btn_edit_gamma_Callback(hObject, eventdata, handles)
function btn_edit_rotation_Callback(hObject, eventdata, handles)
function btn_edit_rotation_scale_Callback(hObject, eventdata, handles)
function btn_edit_crop_Callback(hObject, eventdata, handles)
function btn_edit_rotation_crop_Callback(hObject, eventdata, handles)
function btn_edit_flip_Callback(hObject, eventdata, handles)
function btn_edit_scale_Callback(hObject, eventdata, handles)
function btn_edit_shear_y_Callback(hObject, eventdata, handles)
function btn_edit_shear_x_Callback(hObject, eventdata, handles)
function btn_edit_contrast_Callback(hObject, eventdata, handles)
function btn_edit_brighten_Callback(hObject, eventdata, handles)
function btn_edit_y_Callback(hObject, eventdata, handles)
function btn_edit_cb_Callback(hObject, eventdata, handles)
function btn_edit_cr_Callback(hObject, eventdata, handles)
function btn_edit_red_Callback(hObject, eventdata, handles)
function btn_edit_green_Callback(hObject, eventdata, handles)
function btn_edit_blue_Callback(hObject, eventdata, handles)
function btn_edit_hue_Callback(hObject, eventdata, handles)
function btn_edit_saturation_Callback(hObject, eventdata, handles)
function btn_edit_value_Callback(hObject, eventdata, handles)
function btn_edit_color_reduction_Callback(hObject, eventdata, handles)
function btn_resize_Callback(hObject, eventdata, handles)

%% Edit txt attack
function txt_value_gaussian_noise_Callback(hObject, eventdata, handles)
function txt_value_gaussian_noise_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_salt_pepper_noise_Callback(hObject, eventdata, handles)
function txt_value_salt_pepper_noise_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_speckle_noise_Callback(hObject, eventdata, handles)
function txt_value_speckle_noise_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_bitplane_Callback(hObject, eventdata, handles)
function txt_value_bitplane_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_jpg_Callback(hObject, eventdata, handles)
function txt_value_jpg_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_blur_Callback(hObject, eventdata, handles)
function txt_value_blur_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_sharpen_Callback(hObject, eventdata, handles)
function txt_value_sharpen_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_motion_Callback(hObject, eventdata, handles)
function txt_value_motion_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_gamma_Callback(hObject, eventdata, handles)
function txt_value_gamma_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_rotation_Callback(hObject, eventdata, handles)
function txt_value_rotation_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_rotation_scale_Callback(hObject, eventdata, handles)
function txt_value_rotation_scale_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_crop_Callback(hObject, eventdata, handles)
function txt_value_crop_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_rotation_crop_Callback(hObject, eventdata, handles)
function txt_value_rotation_crop_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_scale_Callback(hObject, eventdata, handles)
function txt_value_scale_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_shear_y_Callback(hObject, eventdata, handles)
function txt_value_shear_y_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_shear_x_Callback(hObject, eventdata, handles)
function txt_value_shear_x_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_brighten_Callback(hObject, eventdata, handles)
function txt_value_brighten_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_contrast_Callback(hObject, eventdata, handles)
function txt_value_contrast_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_y_Callback(hObject, eventdata, handles)
function txt_value_y_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_cb_Callback(hObject, eventdata, handles)
function txt_value_cb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_cr_Callback(hObject, eventdata, handles)
function txt_value_cr_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_red_Callback(hObject, eventdata, handles)
function txt_value_red_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_blue_Callback(hObject, eventdata, handles)
function txt_value_blue_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_hue_Callback(hObject, eventdata, handles)
function txt_value_hue_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_saturation_Callback(hObject, eventdata, handles)
function txt_value_saturation_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_value_Callback(hObject, eventdata, handles)
function txt_value_value_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_color_reduction_Callback(hObject, eventdata, handles)
function txt_value_color_reduction_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function txt_value_green_Callback(hObject, eventdata, handles)
function txt_value_green_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Attack done
function checkbox_attack_done_Callback(hObject, eventdata, handles)

        current_state = get(handles.checkbox_attack_done,'Value');
        if current_state == 1.0
            disable_attack(handles);
 %           enable_benchmark(handles);
            set(handles.btn_next_attack,'Enable','on');
        else
            
%            disable_benchmark(handles);
            enable_attack(handles);
            set(handles.btn_next_attack,'Enable','off');
        end
        
function btn_previous_attack_Callback(hObject, eventdata, handles)
     user_interface(handles,'watermark');
function btn_next_attack_Callback(hObject, eventdata, handles)
    user_interface(handles,'benchmark');
    disable_email(handles); 
    
    set(handles.tab_html,'Visible','off');
    set(handles.checkbox_ftp,'Value',0.0);
    set(handles.input_ftp_site,'Enable','off');
    set(handles.checkbox_anonymous,'Enable','off');
    set(handles.input_username,'Enable','off');
    set(handles.input_ftp_password,'Enable','off');
    
    local_path = get_root_data('local_path');
    current_path = strcat(local_path,'\Metrics\*.m');
    files = dir(current_path);
    i=1;                                        %The first and second our . and .. so start at index 3
    while i<=numel(files)                            %for every file add it to the popup-menu

        list_of_files = files(i);               %Select a file in the structure

        current_name = list_of_files.name;      %Get the name of the selected file
        text(1,i+1) = {current_name};             %Make a cell of the current name so you can store it in an string array
        i = i+1;
    end
    text(1,1) = {'Choose you metric'};


    set(handles.popup_metric1,'String',text);
    set(handles.popup_metric2,'String',text);

    
%% Benchmark & Report
function popup_metric1_Callback(hObject, eventdata, handles)
            
            value = get(handles.popup_metric1,'Value');
            cell_string = get(handles.popup_metric1,'String');
            
            metric_file = cell_string(value,:);
            
            [path file ext vrsn] = fileparts(char(metric_file));
            
            iMark_script = get_root_data('iMark_script');
            iMark_script = setfield(iMark_script,'metric1',file);
            set_root_data(handles,'iMark_script',iMark_script);
function popup_metric1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popup_metric2_Callback(hObject, eventdata, handles)
            value = get(handles.popup_metric2,'Value');
            cell_string = get(handles.popup_metric2,'String');
            
            metric_file = cell_string(value,:);
            
            [path file ext vrsn] = fileparts(char(metric_file));
            
            iMark_script = get_root_data('iMark_script');
            iMark_script = setfield(iMark_script,'metric2',file);
            set_root_data(handles,'iMark_script',iMark_script);
function popup_metric2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function radiobutton_pdf_Callback(hObject, eventdata, handles)

    set(handles.radiobutton_html,'Value',0.0);
    set(handles.radiobutton_rtf,'Value',0.0);
    set(handles.radiobutton_pdf,'Value',1.0);
    
    iMark_script = get_root_data('iMark_script');
    iMark_script = setfield(iMark_script,'file_format','pdf');
    iMark_script = setfield(iMark_script,'upload_results','no');
    set_root_data(handles,'iMark_script',iMark_script);
    
    set(handles.checkbox_notify,'Value',0.0);
    disable_email(handles);  
    
    set(handles.tab_html,'Visible','off');
function radiobutton_html_Callback(hObject, eventdata, handles)

    set(handles.radiobutton_html,'Value',1.0);
    set(handles.radiobutton_rtf,'Value',0.0);
    set(handles.radiobutton_pdf,'Value',0.0);
    
    iMark_script = get_root_data('iMark_script');
    iMark_script = setfield(iMark_script,'file_format','html');
    iMark_script = setfield(iMark_script,'upload_results','no');
    set_root_data(handles,'iMark_script',iMark_script);
    
    set(handles.checkbox_notify,'Value',0.0);
    disable_email(handles);
    
    set(handles.tab_html,'Visible','on');
    set(handles.checkbox_ftp,'Value',0.0);
    set(handles.input_ftp_site,'Enable','off');
    set(handles.checkbox_anonymous,'Enable','off');
    set(handles.input_username,'Enable','off');
    set(handles.input_ftp_password,'Enable','off');

function radiobutton_rtf_Callback(hObject, eventdata, handles)

    set(handles.radiobutton_html,'Value',0.0);
    set(handles.radiobutton_rtf,'Value',1.0);
    set(handles.radiobutton_pdf,'Value',0.0);
    
    iMark_script = get_root_data('iMark_script');
    iMark_script = setfield(iMark_script,'file_format','rtf');
    iMark_script = setfield(iMark_script,'upload_results','no');
    set_root_data(handles,'iMark_script',iMark_script);
    
    set(handles.checkbox_notify,'Value',0.0);
    disable_email(handles);
    
    set(handles.tab_html,'Visible','off');

    
function checkbox_notify_Callback(hObject, eventdata, handles)

selected = get(handles.checkbox_notify,'Value');

if selected == 1
    enable_email(handles);
else
    disable_email(handles);
end
function checkbox_ftp_Callback(hObject, eventdata, handles)

    value = get(handles.checkbox_ftp,'Value');
    if value == 1
        set(handles.checkbox_ftp,'Value',1.0);
        set(handles.input_ftp_site,'Enable','on');
        set(handles.checkbox_anonymous,'Enable','on');
        set(handles.checkbox_anonymous,'Value',0.0);
        set(handles.input_username,'Enable','on');
        set(handles.input_ftp_password,'Enable','on');
        
        iMark_script = get_root_data('iMark_script');
        iMark_script = setfield(iMark_script,'upload_results','yes');
        set_root_data(handles,'iMark_script',iMark_script);
    
    else
        set(handles.checkbox_ftp,'Value',0.0);
        set(handles.input_ftp_site,'Enable','off');
        set(handles.checkbox_anonymous,'Enable','off');
        set(handles.input_username,'Enable','off');
        set(handles.input_ftp_password,'Enable','off');
        
        iMark_script = get_root_data('iMark_script');
        iMark_script = setfield(iMark_script,'upload_results','no');
        set_root_data(handles,'iMark_script',iMark_script);
    end
    
function btn_email_list_Callback(hObject, eventdata, handles)
   
    [tempname, temppath] = uigetfile({'*.txt','Email List(*.txt)'},'Select an email list file');
    if ((~strcmp(num2str(tempname), '0')) && (~strcmp(num2str(temppath), '0')))  
        
        [filepath ,filename,ext,tempver] = fileparts(strcat(temppath, '\', tempname));
        file_name = [filepath filename ext];
        set(handles.txt_email_list,'String',strcat(filename,ext));
     
        
        %update the stucture
        iMark_script = get_root_data('iMark_script');
        iMark_script = setfield(iMark_script,'email_list',strcat(filename,ext));
        set_root_data(handles,'iMark_script',iMark_script);
        %end updating structure
        
        

    else
        msgbox('No email list was selected');
    end
function btn_edit_email_list_Callback(hObject, eventdata, handles)
    email_list = get(handles.txt_email_list,'String');
    open(email_list);
    
function checkbox_anonymous_Callback(hObject, eventdata, handles)

    value = get(handles.checkbox_anonymous,'Value');
    if value == 1.0
        set(handles.input_username,'Enable','off');
        set(handles.input_ftp_password,'Enable','off');
    else
        set(handles.input_username,'Enable','on');
        set(handles.input_ftp_password,'Enable','on');
    end

function txt_value_flip_Callback(hObject, eventdata, handles)
function txt_value_flip_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function input_subject_Callback(hObject, eventdata, handles)
function input_subject_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function input_message_Callback(hObject, eventdata, handles)
function input_message_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function input_email_Callback(hObject, eventdata, handles)
function input_email_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function input_password_Callback(hObject, eventdata, handles)
function input_password_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function checkbox_include_attachment_Callback(hObject, eventdata, handles)

function input_username_Callback(hObject, eventdata, handles)
function input_username_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function input_ftp_password_Callback(hObject, eventdata, handles)
function input_ftp_password_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function input_ftp_site_Callback(hObject, eventdata, handles)
function input_ftp_site_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function input_email_message_Callback(hObject, eventdata, handles)
function input_email_message_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end    
    
function checkbox_report_done_Callback(hObject, eventdata, handles)

iMark_script = get_root_data('iMark_script');

file_format = iMark_script.file_format;
notify_selected = get(handles.checkbox_notify,'Value');
ftp_selected  = get(handles.checkbox_ftp,'Value');
switch file_format
    case 'pdf'
        if notify_selected == 1.0
            email_file = get(handles.txt_email_list,'String');
            account = get(handles.input_email,'String');
            password = get(handles.input_password,'String');
            
            subject = get(handles.input_subject,'String');
            message = get(handles.input_email_message,'String');
            
            attach_report = get(handles.checkbox_include_attachment,'String');
            
            iMark_script = setfield(iMark_script,'notify','on');
            iMark_script = setfield(iMark_script,'email_list',email_file);
            iMark_script = setfield(iMark_script,'account',account);
            iMark_script = setfield(iMark_script,'account_password',password);
            iMark_script = setfield(iMark_script,'subject',subject);
            iMark_script = setfield(iMark_script,'email_message',message);
            iMark_script = setfield(iMark_script,'report_attached',attach_report);
            set_root_data(handles,'iMark_script',iMark_script);
        else
            iMark_script = setfield(iMark_script,'notify','off');
            set_root_data(handles,'iMark_script',iMark_script);
        end
    case 'html'
        if notify_selected == 1.0
            email_file = get(handles.txt_email_list,'String');
            account = get(handles.input_email,'String');
            password = get(handles.input_password,'String');
            
            subject = get(handles.input_subject,'String');
            message = get(handles.input_message,'String');
            
            iMark_script = setfield(iMark_script,'notify','on');
            iMark_script = setfield(iMark_script,'email_list',email_file);
            iMark_script = setfield(iMark_script,'account',account);
            iMark_script = setfield(iMark_script,'account_password',password);
            iMark_script = setfield(iMark_script,'subject',subject);
            iMark_script = setfield(iMark_script,'email_message',message);
            iMark_script = setfield(iMark_script,'report_attached','no');
            set_root_data(handles,'iMark_script',iMark_script);
        else
            iMark_script = setfield(iMark_script,'notify','off');
            set_root_data(handles,'iMark_script',iMark_script);
        end
        
        if ftp_selected == 1.0
            checkbox_anonymous = get(handles.checkbox_anonymous,'Value');
            ftp_url = get(handles.input_ftp_site,'String');
            if checkbox_anonymous == 1.0
                try
                    ftp_dir = ftp(ftp_url);
                    iMark_script = setfield(iMark_script,'ftp_site',ftp_url);
                    set_root_data(handles,'iMark_script',iMark_script);
                catch
                    msgbox('Matlab could not connect to the ftp server please check your settings before you can continue');
                end
            else
                ftp_username = get(handles.input_username,'String');
                ftp_password = get(handles.input_ftp_password,'String');
                try
                    ftp_dir = ftp(ftp_url,ftp_username,ftp_password);
                    iMark_script = setfield(iMark_script,'ftp_site',ftp_url);
                    iMark_script = setfield(iMark_script,'username',ftp_username);
                    iMark_script = setfield(iMark_script,'ftp_password',ftp_password);
                    set_root_data(handles,'iMark_script',iMark_script)
                catch
                    msgbox('Matlab could not connect to the ftp server please check your settings before you can continue');
                end
            end
        else
        end
    case 'rtf'
        if notify_selected == 1.0
            email_file = get(handles.txt_email_list,'String');
            account = get(handles.input_email,'String');
            password = get(handles.input_password,'String');
            
            subject = get(handles.input_subject,'String');
            message = get(handles.input_message,'String');
            
            attach_report = get(handles.checkbox_include_attachment,'String');
            
            iMark_script = setfield(iMark_script,'notify','on');
            iMark_script = setfield(iMark_script,'email_list',email_file);
            iMark_script = setfield(iMark_script,'account',account);
            iMark_script = setfield(iMark_script,'account_password',password);
            iMark_script = setfield(iMark_script,'subject',subject);
            iMark_script = setfield(iMark_script,'email_message',message);
            iMark_script = setfield(iMark_script,'report_attached',attach_report);
            set_root_data(handles,'iMark_script',iMark_script);
        else
            iMark_script = setfield(iMark_script,'notify','off');
            set_root_data(handles,'iMark_script',iMark_script);
        end
end

function btn_previous_benchmark_Callback(hObject, eventdata, handles)
user_interface(handles,'attack');


function btn_benchmark_Callback(hObject, eventdata, handles)
iMark_script = get_root_data('iMark_script');
benchmark(iMark_script);

%% Close.
function btn_close_Callback(hObject, eventdata, handles)

        close();


        
        
        
        
        
        
        
        
        
        
%% old?

        %% Temp attack
function btn_attack_images_Callback(hObject, eventdata, handles)

function listbox4_Callback(hObject, eventdata, handles)
function listbox4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function popupmenu31_Callback(hObject, eventdata, handles)
function popupmenu31_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function pushbutton27_Callback(hObject, eventdata, handles)
function popup_specified_attack_Callback(hObject, eventdata, handles)
function popup_specified_attack_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function btn_add_attack_Callback(hObject, eventdata, handles)
function listbox5_Callback(hObject, eventdata, handles)
function listbox5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function checkbox8_Callback(hObject, eventdata, handles)
function checkbox11_Callback(hObject, eventdata, handles)
function popupmenu33_Callback(hObject, eventdata, handles)
function popupmenu33_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function checkbox18_Callback(hObject, eventdata, handles)
function pushbutton43_Callback(hObject, eventdata, handles)
function edit15_Callback(hObject, eventdata, handles)
function edit15_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function checkbox27_Callback(hObject, eventdata, handles)
function pushbutton52_Callback(hObject, eventdata, handles)
function edit24_Callback(hObject, eventdata, handles)
function edit24_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function checkbox29_Callback(hObject, eventdata, handles)
function pushbutton54_Callback(hObject, eventdata, handles)
function edit26_Callback(hObject, eventdata, handles)
function edit26_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit37_Callback(hObject, eventdata, handles)
function edit37_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function checkbox41_Callback(hObject, eventdata, handles)
function pushbutton67_Callback(hObject, eventdata, handles)
function edit38_Callback(hObject, eventdata, handles)
function edit38_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function checkbox42_Callback(hObject, eventdata, handles)
function pushbutton68_Callback(hObject, eventdata, handles)
function edit39_Callback(hObject, eventdata, handles)
function edit39_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function checkbox40_Callback(hObject, eventdata, handles)
function pushbutton66_Callback(hObject, eventdata, handles)


% --- Executes on selection change in popup_message_size.
function popup_message_size_Callback(hObject, eventdata, handles)
% hObject    handle to popup_message_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popup_message_size contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_message_size


% --- Executes during object creation, after setting all properties.
function popup_message_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_message_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit64_Callback(hObject, eventdata, handles)
% hObject    handle to input_message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_message as text
%        str2double(get(hObject,'String')) returns contents of input_message as a double


% --- Executes during object creation, after setting all properties.
function edit64_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


