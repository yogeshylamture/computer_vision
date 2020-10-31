function selected = check_selected_component_attacked_decode(handles)

rgb_selected = get(handles.radiobutton_icon_rgb_attacked_decode,'Value');
ycbcr_selected = get(handles.radiobutton_icon_ycbcr_attacked_decode,'Value');

y_selected = get(handles.radiobutton_layer_y_attacked_decode,'Value');
cb_selected = get(handles.radiobutton_layer_cb_attacked_decode,'Value');
cr_selected = get(handles.radiobutton_layer_cr_attacked_decode,'Value');

red_selected = get(handles.radiobutton_layer_red_attacked_decode,'Value');
green_selected = get(handles.radiobutton_layer_green_attacked_decode,'Value');
blue_selected = get(handles.radiobutton_layer_blue_attacked_decode,'Value');

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