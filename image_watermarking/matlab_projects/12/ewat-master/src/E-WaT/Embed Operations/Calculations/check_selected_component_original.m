function selected = check_selected_component_original(handles)

rgb_selected = get(handles.radiobutton_icon_rgb_original,'Value');
ycbcr_selected = get(handles.radiobutton_icon_ycbcr_original,'Value');

y_selected = get(handles.radiobutton_layer_y_original,'Value');
cb_selected = get(handles.radiobutton_layer_cb_original,'Value');
cr_selected = get(handles.radiobutton_layer_cr_original,'Value');

red_selected = get(handles.radiobutton_layer_red_original,'Value');
green_selected = get(handles.radiobutton_layer_green_original,'Value');
blue_selected = get(handles.radiobutton_layer_blue_original,'Value');

presentation_state = get(handles.radiobutton_rgb,'Value');

if rgb_selected == 1.0
    selected = 'rgb';
elseif ycbcr_selected == 1.0
    selected = 'ycbcr';
    
elseif y_selected == 1.0
    selected = 'y';
elseif cb_selected == 1.0
    selected = 'cb';
elseif cr_selected == 1.0
    selected = 'cr';
    
elseif red_selected == 1.0
    selected = 'red';
elseif green_selected == 1.0
    selected = 'green';
elseif blue_selected == 1.0
    selected = 'blue';
else
    if presentation_state == 1.0
        selected = 'rgb';
    else
        selected = 'ycbcr';
    end;
end;   