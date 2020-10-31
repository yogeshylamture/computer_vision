function varargout = detect_parameters(varargin)

        gui_Singleton = 1;
        gui_State = struct('gui_Name',       mfilename, ...
                           'gui_Singleton',  gui_Singleton, ...
                           'gui_OpeningFcn', @detect_parameters_OpeningFcn, ...
                           'gui_OutputFcn',  @detect_parameters_OutputFcn, ...
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
% End initialization code - DO NOT EDIT

%% Opening function
function detect_parameters_OpeningFcn(hObject, eventdata, handles, varargin)

        handles.output = hObject;
        guidata(hObject, handles);
        
        number_of_detect_arguments = get_root_data('number_of_detect_arguments');
        if number_of_detect_arguments == 1
            set(handles.btn_next,'String','Done');
        else
            set(handles.btn_next,'String','Next');
        end
        current_argument = 1;
        
        detect_parameters = struct();
        set_root_data(handles,'detect_parameters',detect_parameters);
        
        set_root_data(handles,'current_argument',current_argument);
        set_ui(handles,'initialize');
        set(handles.tab_parameter, 'Title', ['Detecting paramater 1 of ',int2str(number_of_detect_arguments)]);
        
%% Varargout
function varargout = detect_parameters_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;

%% Name Done
function checkbox_name_done_Callback(hObject, eventdata, handles)
    
    input_name = get(handles.txt_parameter_name,'String');
    checked = get(handles.checkbox_name_done,'Value');
    
    control_name = str2num(input_name(1,1));     % convert this to a number 
    
    if isempty(control_name)        % is conversion was succesful the name was a number
        if checked == 1.0
            if isempty(input_name)
                set(handles.checkbox_name_done,'Value',0.0);
                warndlg('First enter a parameter name','Warning');

            else
                 set_ui(handles,'done_name');
            end
        else
            set_ui(handles,'reset');
        end
    else
        warndlg('The name can not start with a numerical value');
        set_ui(handles,'reset');
        set(handles.checkbox_name_done,'Value',0.0);
    end

%% Type event
function popup_type_Callback(hObject, eventdata, handles)

    selected_type = get(handles.popup_type,'Value');
    selected_value = get(handles.popup_value,'Value');
    
    set_ui(handles,'clear values');                
    switch selected_value
        case 1.0    %Static
            switch selected_type
                case 1.0    %Integer
                    set_ui(handles,'fixed integer');
                    set(handles.popup_value,'string',strvcat('Static','Linear','Specified'));
    
                case 2.0    %Double
                    set_ui(handles,'fixed double');
                    set(handles.popup_value,'string',strvcat('Static','Linear','Specified'));
    
                case 3.0    %String
                    set_ui(handles,'fixed string');
                    set(handles.popup_value,'string',strvcat('Static','Specified'));
            end
        case 2.0    %Linear
            switch selected_type
                case 1.0    %Integer
                    set_ui(handles,'linear integer');
                    set(handles.popup_value,'string',strvcat('Static','Linear','Specified'));
                case 2.0    %Double
                    set_ui(handles,'linear double');
                    set(handles.popup_value,'string',strvcat('Static','Linear','Specified'));
                case 3.0    %String
                    set_ui(handles,'linear double');
                    set(handles.popup_value,'string',strvcat('Static','Specified'));
            end
        case 3.0    %Specified
            switch selected_type
                case 1.0    %Integer
                    set_ui(handles,'specified integer');
                    set(handles.popup_value,'string',strvcat('Static','Linear','Specified'));
                case 2.0    %Double
                    set_ui(handles,'specified double');
                    set(handles.popup_value,'string',strvcat('Static','Linear','Specified'));
                case 3.0    %String
                    set_ui(handles,'specified string');
                    set(handles.popup_value,'string',strvcat('Static','Specified'),'Value',1);
        end
    end
function popup_type_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Value event
function popup_value_Callback(hObject, eventdata, handles)

    selected_type = get(handles.popup_type,'Value');
    selected_value = get(handles.popup_value,'Value');
    
    set_ui(handles,'clear values');
    
    switch selected_type
        case 1.0    %Integer
            switch selected_value
                case 1.0    %Fixed
                    set_ui(handles,'fixed integer');
                    set(handles.popup_type,'string',strvcat('Integer','Double','String'));
               case 2.0    %Linear
                    set_ui(handles,'linear integer');
                    set(handles.popup_type,'string',strvcat('Integer','Double'));
                case 3.0    %Specified
                    set_ui(handles,'specified integer');
                    set(handles.popup_type,'string',strvcat('Integer','Double','String'));
            end
        case 2.0    %Double
            switch selected_value
                case 1.0    %Integer
                    set_ui(handles,'fixed double');
                    set(handles.popup_type,'string',strvcat('Integer','Double','String'));
                case 2.0    %Double
                    set_ui(handles,'linear double');
                    set(handles.popup_type,'string',strvcat('Integer','Double'));
                case 3.0    %String
                    set_ui(handles,'specified double');
                    set(handles.popup_type,'string',strvcat('Integer','Double','String'));
           end
        case 3.0    %String
            switch selected_value
                case 1.0    %Integer
                    set_ui(handles,'fixed string');
                    set(handles.popup_type,'string',strvcat('Integer','Double','String'));
                case 2.0    %Double
                    set_ui(handles,'specified string');
                    set(handles.popup_type,'string',strvcat('Integer','Double','String'));
            end
    end
function popup_value_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Add Fixed Integer
function btn_add_fixed_integer_Callback(hObject, eventdata, handles)
    
    parameter_name = get(handles.txt_parameter_name,'String');
    input_string = get(handles.txt_fixed_integer,'String');
    
    int16_value = int16(str2num(input_string));
    [H W] = size(int16_value);
    
    if W == 1       % if a comma value is used this will not be 1
        if isempty(int16_value)
            warndlg('The value you have entered does not seem to be an integer. Please check and enter a new value','Warning');
            set(handles.label_fixed_integer,'Visible','off');
            set(handles.btn_next,'Enable','off');
        else
            if isinteger(int16_value)
                set(handles.label_fixed_integer,'Visible','on');
                set(handles.label_fixed_integer,'String',[parameter_name, ': ', int2str(int16_value)]);
                set(handles.btn_next,'Enable','on');
                
                set_root_data(handles,'parameter_name',parameter_name);
                set_root_data(handles,'parameter_value',int16_value);
            else
                set(handles.label_fixed_integer,'Visible','off');
                warndlg('The value you have entered does not seem to be an integer. Please check and enter a new value','Warning');
                set(handles.btn_next,'Enable','off');
            end
        end
    else
        warndlg('The value you have entered is not valid. Please check and enter a new value.','Warning');
    end

%% Add fixed Double
function btn_add_fixed_double_Callback(hObject, eventdata, handles)
    parameter_name = get(handles.txt_parameter_name,'String');
    
    input_string = get(handles.txt_fixed_double,'String');
    double_value = str2double(input_string);
    
    [H W] = size(double_value);
    
    if W == 1   % if a comma value is used this will not be 1
        if isempty(double_value)
            warndlg('The value you have entered does not seem to be a double. Please check and enter a new value','Warning');
            set(handles.label_fixed_double,'Visible','off');
            set(handles.btn_next,'Enable','off');
        else
            if isa(double_value,'double')
                set(handles.label_fixed_double,'Visible','on');
                set(handles.label_fixed_double,'String',[parameter_name, ': ', num2str(double_value)]);
                set(handles.btn_next,'Enable','on');
                
                set_root_data(handles,'parameter_name',parameter_name);
                set_root_data(handles,'parameter_value',double_value);
            else
                set(handles.label_fixed_double,'Visible','off');
                warndlg('The value you have entered does not seem to be a double. Please check and enter a new value','Warning');
                set(handles.btn_next,'Enable','off');
            end
        end
    else
        warndlg('The value you have entered is not valid. Use a point instead of a comma.','Warning');
    end
%% Add Fixed Text
function btn_add_fixed_string_Callback(hObject, eventdata, handles)

    parameter_name = get(handles.txt_parameter_name,'String');
    
    input_string = get(handles.txt_fixed_string,'String');
    
    
        if isempty(input_string)
            warndlg('The value you have entered does not seem to be a string. Please check and enter a new value','Warning');
            set(handles.label_fixed_string,'Visible','off');
            set(handles.btn_next,'Enable','off');
        else
            if isa(input_string,'char')
                set(handles.label_fixed_string,'Visible','on');
                set(handles.label_fixed_string,'String',[parameter_name, ': ', input_string]);
                set(handles.btn_next,'Enable','on');
                
                set_root_data(handles,'parameter_name',parameter_name);
                set_root_data(handles,'parameter_value',input_string);
            else
                set(handles.label_fixed_string,'Visible','off');
                warndlg('The value you have entered does not seem to be a string. Please check and enter a new value','Warning');
                set(handles.btn_next,'Enable','off');
            end
        end
    
%% Add Linear Integer
function bnt_add_linear_integer_Callback(hObject, eventdata, handles)
    parameter_name = get(handles.txt_parameter_name,'String');
    input_string_start = get(handles.txt_start_integer,'String');
    input_string_step = get(handles.txt_step_integer,'String');
    input_string_end = get(handles.txt_end_integer,'String');
    
    input_name = get(handles.txt_parameter_name,'String');
    
    int16_value_start = int16(str2num(input_string_start));
    int16_value_step = int16(str2num(input_string_step));
    int16_value_end = int16(str2num(input_string_end));
     
    
        if isempty(int16_value_start) || isempty(int16_value_step) || isempty(int16_value_end)
            warndlg('One or more of the values you have entered does not seem to be an integer. Please check and enter new values','Warning');
            set(handles.label_linear_integer,'Visible','off');
            set(handles.btn_next,'Enable','off');
        else
            if isinteger(int16_value_start) && isinteger(int16_value_step) && isinteger(int16_value_end)
                check = check_linear(int16_value_start,int16_value_step,int16_value_end);
                if strcmp(check,'ok')
                    set(handles.label_linear_integer,'String',[input_name ' starts at value ' int2str(int16_value_start) ' with a stepsize of ' int2str(int16_value_step) ' until the value ', int2str(int16_value_end),' is reached.']);
                    set(handles.label_linear_integer,'Visible','on');
                    set(handles.btn_next,'Enable','on');
                    
                    set_root_data(handles,'parameter_name',parameter_name);
                    set_root_data(handles,'parameter_value',[int16_value_start int16_value_step int16_value_end]);
                else
                    warndlg('One or more of the values you have entered does not seem to be an integer. Please check and enter new values','Warning');
                    set(handles.label_linear_integer,'Visible','off');
                    set(handles.btn_next,'Enable','off');
                end
            else
                warndlg('One or more of the values you have entered does not seem to be an integer. Please check and enter new values','Warning');
                set(handles.label_linear_integer,'Visible','off');
                set(handles.btn_next,'Enable','off');
            end
        end
        
%% Add Linear Double
function btn_add_linear_double_Callback(hObject, eventdata, handles)
    parameter_name = get(handles.txt_parameter_name,'String');
    input_string_start = get(handles.txt_start_double,'String');
    input_string_step = get(handles.txt_step_double,'String');
    input_string_end = get(handles.txt_end_double,'String');
    
    input_name = get(handles.txt_parameter_name,'String');
    
    double_value_start = str2double(input_string_start);
    double_value_step = str2double(input_string_step);
    double_value_end = str2double(input_string_end);
     
    
        if isempty(double_value_start) || isempty(double_value_step) || isempty(double_value_end)
            warndlg('One or more of the values you have entered does not seem to be an integer. Please check and enter new values','Warning');
            set(handles.label_linear_double,'Visible','off');
            set(handles.btn_next,'Enable','off');
        else
            if isa(double_value_start,'double') && isa(double_value_step,'double') && isa(double_value_end,'double')
                check = check_linear(double_value_start,double_value_step,double_value_end);
                if strcmp(check,'ok')
                    set(handles.label_linear_double,'String',[input_name ' starts at value ' num2str(double_value_start) ' with a stepsize of ' num2str(double_value_step) ' until the value ', num2str(double_value_end),' is reached.']);
                    set(handles.label_linear_double,'Visible','on');
                    set(handles.btn_next,'Enable','on');
                    
                    set_root_data(handles,'parameter_name',parameter_name);
                    set_root_data(handles,'parameter_value',[double_value_start double_value_step double_value_end]);
                else
                    warndlg('One or more of the values you have entered does not seem to be an integer. Please check and enter new values','Warning');
                    set(handles.label_linear_double,'Visible','off');
                    set(handles.btn_next,'Enable','off');
                end
            else
                warndlg('One or more of the values you have entered does not seem to be an integer. Please check and enter new values','Warning');
                set(handles.label_linear_double,'Visible','off');
                set(handles.btn_next,'Enable','off');
            end
        end

%% Add Specified Integer
function btn_add_specified_integer_Callback(hObject, eventdata, handles)
    parameter_name = get(handles.txt_parameter_name,'String');
    current_list = get(handles.listbox_integer,'String');
    
    input_string = get(handles.txt_specified_integer,'String');
    int16_value = int16((str2num(input_string)));
    
    [H W] = size(int16_value);
    
    if W == 1 
        if isempty(int16_value)
            warndlg('The value you have entered does not seem to be an integer. Please check and enter a new value','Warning');
            set(handles.btn_next,'Enable','off');
            set(handles.btn_remove_specified_integer,'Enable','off');
            set(handles.btn_up_specified_integer,'Enable','off');
            set(handles.btn_down_specified_integer,'Enable','off');
        else
            if isinteger(int16_value)
                complete_list = strvcat(current_list,num2str(int16_value));
                set(handles.listbox_integer,'String',complete_list,'Value',1);
                set(handles.btn_remove_specified_integer,'Enable','on');
                set(handles.btn_up_specified_integer,'Enable','on');
                set(handles.btn_down_specified_integer,'Enable','on');
                set(handles.btn_next,'Enable','on');
                
                set_root_data(handles,'parameter_name',parameter_name);
                set_root_data(handles,'parameter_value',int16(str2num(complete_list)));
                
            else
                warndlg('The value you have entered does not seem to be an integer. Please check and enter a new value','Warning');
                set(handles.btn_next,'Enable','off');
            end
        end
    else
        warndlg('The value you have entered is not valid.','Warning');
    end
    
%% Remove Specified Integer
function btn_remove_specified_integer_Callback(hObject, eventdata, handles)

selected = get(handles.listbox_integer,'Value');
list = get(handles.listbox_integer,'String');
[width height] = size(list);
new_list = {};

for i=1:width
    if selected == i && selected ~=width && selected ~= 1
        i = i+2;
    else
            if  selected == 1 && selected ~= width
                
                if i ~= width 
                    new_value = list(i+1,:);
                    new_list = strvcat(new_list,new_value);
                else
                end
                
            elseif selected == width && selected ~= 1
                
                if i ~= width 
                    new_value = list(i,:);
                    new_list = strvcat(new_list,new_value);
                else
                    
                end
            elseif selected == 1 && width == 1
                new_list = {};
                set(handles.btn_remove_specified_integer,'Enable','off');
                set(handles.btn_up_specified_integer,'Enable','off');
                set(handles.btn_down_specified_integer,'Enable','off');
                
                set(handles.btn_next,'Enable','off');
            else
                new_value = list(i,:);
                new_list = strvcat(new_list,new_value);
            end
     end
end

set(handles.listbox_integer,'String',new_list,'Value',1);    

%% Down Specified Integer
function btn_down_specified_integer_Callback(hObject, eventdata, handles)

    list = get(handles.listbox_integer,'String');
    selected = get(handles.listbox_integer,'Value');
    
    [width height] = size(list);
    
    new_list = {};
    i=1.0;
    if selected == width
        msgbox('The selected value is already at the bottom');
        new_list = list;
    else
        while i <= width
            if selected == i
                new_value_up = list(i,:);
                new_value_down = list(i+1,:);
                new_list = strvcat(new_list,new_value_down,new_value_up);
                i = i + 2;
            else
                new_value = list(i,:);
                new_list = strvcat(new_list,new_value);
                i = i +1;
            end
        end
    end
    
    set(handles.listbox_integer,'String',new_list);

%% Up Specified Integer
function btn_up_specified_integer_Callback(hObject, eventdata, handles)
list = get(handles.listbox_integer,'String');
    selected = get(handles.listbox_integer,'Value');
    
    [width height] = size(list);
    
    new_list = {};
    
    i=1.0;
    if selected == 1
        msgbox('The selected value is already at the top');
        new_list = list;
    else
        while i <= width
            if (selected-1) == i
                new_value_up = list(i,:);
                new_value_down = list(i+1,:);
                new_list = strvcat(new_list,new_value_down,new_value_up);
                i = i + 2;
            else
                new_value = list(i,:);
                new_list = strvcat(new_list,new_value);
                i = i +1;
            end
        end
    end
    
    set(handles.listbox_integer,'String',new_list);

%% Add Specified Double 
function btn_add_specified_double_Callback(hObject, eventdata, handles)
    parameter_name = get(handles.txt_parameter_name,'String');
    
    current_list = get(handles.listbox_double,'String');
    
    input_string = get(handles.txt_specified_double,'String');
    double_value = str2double(input_string);
    
    [H W] = size(input_string);
    
    for i = 1:W 
        if strcmp(input_string(1,i),',');
            warndlg('The value you have entered contains a comma. This comma will be deleted. Use a point instead of a comma.','Warning');
        else
            
        end
    end
        if isnan(double_value)
            warndlg('The value you have entered does not seem to be a double. Please check and enter a new value','Warning');
            set(handles.label_fixed_integer,'Visible','off');
            set(handles.btn_next,'Enable','off');
            set(handles.btn_remove_specified_double,'Enable','off');
            set(handles.btn_up_specified_double,'Enable','off');
            set(handles.btn_down_specified_double,'Enable','off');
        else
            if isa(double_value,'double')
                complete_list = strvcat(current_list,num2str(double_value));
                set(handles.listbox_double,'String',complete_list,'Value',1);
                set(handles.btn_remove_specified_double,'Enable','on');
                set(handles.btn_up_specified_double,'Enable','on');
                set(handles.btn_down_specified_double,'Enable','on');
                set(handles.btn_next,'Enable','on');
                
                set_root_data(handles,'parameter_name',parameter_name);
                set_root_data(handles,'parameter_value',str2double(complete_list));
                
            else
                warndlg('The value you have entered does not seem to be a double. Please check and enter a new value','Warning');
                set(handles.btn_next,'Enable','off');
            end
        end

%% Remove Specified Double
function btn_remove_specified_double_Callback(hObject, eventdata, handles)
selected = get(handles.listbox_double,'Value');
list = get(handles.listbox_double,'String');
[width height] = size(list);
new_list = {};

for i=1:width
    if selected == i && selected ~=width && selected ~= 1
        i = i+2;
    else
            if  selected == 1 && selected ~= width
                
                if i ~= width 
                    new_value = list(i+1,:);
                    new_list = strvcat(new_list,new_value);
                else
                end
                
            elseif selected == width && selected ~= 1
                
                if i ~= width 
                    new_value = list(i,:);
                    new_list = strvcat(new_list,new_value);
                else
                    
                end
            elseif selected == 1 && width == 1
                new_list = {};
                set(handles.btn_remove_specified_double,'Enable','off');
                set(handles.btn_up_specified_double,'Enable','off');
                set(handles.btn_down_specified_double,'Enable','off');
                
                set(handles.btn_next,'Enable','off');
            else
                new_value = list(i,:);
                new_list = strvcat(new_list,new_value);
            end
     end
end

set(handles.listbox_double,'String',new_list,'Value',1);   

%% Down Specified Double
function btn_down_specified_double_Callback(hObject, eventdata, handles)
list = get(handles.listbox_double,'String');
    selected = get(handles.listbox_double,'Value');
    
    [width height] = size(list);
    
    new_list = {};
    i=1.0;
    if selected == width
        msgbox('The selected value is already at the bottom');
        new_list = list;
    else
        while i <= width
            if selected == i
                new_value_up = list(i,:);
                new_value_down = list(i+1,:);
                new_list = strvcat(new_list,new_value_down,new_value_up);
                i = i + 2;
            else
                new_value = list(i,:);
                new_list = strvcat(new_list,new_value);
                i = i +1;
            end
        end
    end
    
    set(handles.listbox_double,'String',new_list);

%% Up Specified Double
function btn_up_specified_double_Callback(hObject, eventdata, handles)
    list = get(handles.listbox_double,'String');
    selected = get(handles.listbox_double,'Value');
    
    [width height] = size(list);
    
    new_list = {};
    
    i=1.0;
    if selected == 1
        msgbox('The selected value is already at the top');
        new_list = list;
    else
        while i <= width
            if (selected-1) == i
                new_value_up = list(i,:);
                new_value_down = list(i+1,:);
                new_list = strvcat(new_list,new_value_down,new_value_up);
                i = i + 2;
            else
                new_value = list(i,:);
                new_list = strvcat(new_list,new_value);
                i = i +1;
            end
        end
    end
    
    set(handles.listbox_double,'String',new_list);
 
%% Add Specified String
function btn_add_specified_string_Callback(hObject, eventdata, handles)
    parameter_name = get(handles.txt_parameter_name,'String');
    
    current_list = get(handles.listbox_string,'String');
    
    input_string = get(handles.txt_specified_string,'String');
        
        if isempty(input_string)
            warndlg('The value you have entered does not seem to be a string. Please check and enter a new value','Warning');
            set(handles.btn_next,'Enable','off');
            set(handles.btn_remove_specified_string,'Enable','off');
            set(handles.btn_up_specified_string,'Enable','off');
            set(handles.btn_down_specified_string,'Enable','off');
        else
            
                complete_list = strvcat(current_list,input_string);
                set(handles.listbox_string,'String',complete_list,'Value',1);
                set(handles.btn_remove_specified_string,'Enable','on');
                set(handles.btn_up_specified_string,'Enable','on');
                set(handles.btn_down_specified_string,'Enable','on');
                set(handles.btn_next,'Enable','on');
                
                set_root_data(handles,'parameter_name',parameter_name);
                set_root_data(handles,'parameter_value',complete_list);
                
            
        end
    
%% Remove Specified String
function btn_remove_specified_string_Callback(hObject, eventdata, handles)
selected = get(handles.listbox_string,'Value');
list = get(handles.listbox_string,'String');
[width height] = size(list);
new_list = {};

for i=1:width
    if selected == i && selected ~=width && selected ~= 1
        i = i+2;
    else
            if  selected == 1 && selected ~= width
                
                if i ~= width 
                    new_value = list(i+1,:);
                    new_list = strvcat(new_list,new_value);
                else
                end
                
            elseif selected == width && selected ~= 1
                
                if i ~= width 
                    new_value = list(i,:);
                    new_list = strvcat(new_list,new_value);
                else
                    
                end
            elseif selected == 1 && width == 1
                new_list = {};
                set(handles.btn_remove_specified_double,'Enable','off');
                set(handles.btn_up_specified_double,'Enable','off');
                set(handles.btn_down_specified_double,'Enable','off');
                
                set(handles.btn_next,'Enable','off');
            else
                new_value = list(i,:);
                new_list = strvcat(new_list,new_value);
            end
     end
end

set(handles.listbox_string,'String',new_list,'Value',1);   

%% Down Specified String
function btn_down_specified_string_Callback(hObject, eventdata, handles)
list = get(handles.listbox_string,'String');
    selected = get(handles.listbox_string,'Value');
    
    [width height] = size(list);
    
    new_list = {};
    i=1.0;
    if selected == width
        msgbox('The selected value is already at the bottom');
        new_list = list;
    else
        while i <= width
            if selected == i
                new_value_up = list(i,:);
                new_value_down = list(i+1,:);
                new_list = strvcat(new_list,new_value_down,new_value_up);
                i = i + 2;
            else
                new_value = list(i,:);
                new_list = strvcat(new_list,new_value);
                i = i +1;
            end
        end
    end
    
    set(handles.listbox_string,'String',new_list);

%% Up specified String
function btn_up_specified_string_Callback(hObject, eventdata, handles)
    list = get(handles.listbox_string,'String');
    selected = get(handles.listbox_string,'Value');
    
    [width height] = size(list);
    
    new_list = {};
    
    i=1.0;
    if selected == 1
        msgbox('The selected value is already at the top');
        new_list = list;
    else
        while i <= width
            if (selected-1) == i
                new_value_up = list(i,:);
                new_value_down = list(i+1,:);
                new_list = strvcat(new_list,new_value_down,new_value_up);
                i = i + 2;
            else
                new_value = list(i,:);
                new_list = strvcat(new_list,new_value);
                i = i +1;
            end
        end
    end
    
    set(handles.listbox_string,'String',new_list);    
    
function btn_next_Callback(hObject, eventdata, handles)

next = get(handles.btn_next,'String');

if strcmp(next,'Next')
    parameter_name = get_root_data('parameter_name');
    parameter_value = get_root_data('parameter_value');

    current_argument = get_root_data('current_argument');
    arguments = get_root_data('number_of_detect_arguments');
    
    detect_parameters = get_root_data('detect_parameters');
    detect_parameters = setfield(detect_parameters, strcat('parameter_',num2str(current_argument),'_name'),parameter_name);
    detect_parameters = setfield(detect_parameters, strcat(parameter_name,'_value'),parameter_value);
    
    current_argument = current_argument+1;
    set_root_data(handles,'current_argument',current_argument);

    set(handles.tab_parameter,'Title', ['Setting paramater ',int2str(current_argument),' of ',int2str(arguments)]);

    set_ui(handles,'initialize');
    set_ui(handles,'clear values');
    set(handles.txt_parameter_name,'String','');

    set_root_data(handles,'detect_parameters',detect_parameters);
    
    if current_argument == arguments
        set(handles.btn_next,'String','Done');
    else
    end
else
        parameter_name = get_root_data('parameter_name');
        parameter_value = get_root_data('parameter_value');
        arguments = get_root_data('number_of_detect_arguments');
    
        detect_parameters = get_root_data('detect_parameters');
        detect_parameters = setfield(detect_parameters, strcat('parameter_',num2str(arguments),'_name'),parameter_name);
        detect_parameters = setfield(detect_parameters, strcat(parameter_name,'_value'),parameter_value);
      
        set_root_data(handles,'detect_parameters',detect_parameters);
    
        iMark_script = get_root_data('iMark_script');
        iMark_script = setfield(iMark_script,'detect_parameters',detect_parameters);
        set_root_data(handles,'iMark_script',iMark_script);
        close;
        
        handles = get_root_data('main_figure');
        set(handles.checkbox_watermark_done,'Enable','on');
        
end

function btn_back_Callback(hObject, eventdata, handles)
    
    
    











    
    
    
    
    
    
%% Not Specified Functions    
function listbox_integer_Callback(hObject, eventdata, handles)
function listbox_integer_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end       
    
function txt_parameter_name_Callback(hObject, eventdata, handles)
function txt_parameter_name_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
 
function txt_specified_string_Callback(hObject, eventdata, handles)
function txt_specified_string_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function listbox_string_Callback(hObject, eventdata, handles)
function listbox_string_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txt_fixed_string_Callback(hObject, eventdata, handles)
function txt_fixed_string_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txt_start_double_Callback(hObject, eventdata, handles)
function txt_start_double_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txt_step_double_Callback(hObject, eventdata, handles)
function txt_step_double_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txt_end_double_Callback(hObject, eventdata, handles)
function txt_end_double_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txt_fixed_integer_Callback(hObject, eventdata, handles)
function txt_fixed_integer_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function txt_start_integer_Callback(hObject, eventdata, handles)
function txt_start_integer_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txt_step_integer_Callback(hObject, eventdata, handles)
function txt_step_integer_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txt_end_integer_Callback(hObject, eventdata, handles)
function txt_end_integer_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txt_specified_integer_Callback(hObject, eventdata, handles)
function txt_specified_integer_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txt_specified_double_Callback(hObject, eventdata, handles)
function txt_specified_double_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function listbox_double_Callback(hObject, eventdata, handles)
function listbox_double_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txt_fixed_double_Callback(hObject, eventdata, handles)
function txt_fixed_double_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end