%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %  
%                           Hogeschool Antwerpen                          %
%                Industriële Wetenschappen: Elektronica-ICT               %
%                      MultiMediaGroep - Watermarking                     %
%                                                                         %
%                                                                         %
%                             Bachelorproef 3.2                           %
%              Kevin Heylen - Tom Meesters - Luc Verstrepen               %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%%
function user_interface(handles,step)

switch step
    case 'input'
        set(handles.tab_input,'Visible','on');
        set(handles.tab_watermark,'Visible','off');
        set(handles.tab_attack,'Visible','off');
        set(handles.tab_benchmark,'Visible','off');
        
        set(handles.tab_visualeffect_input,'Visible','off');
        set(handles.tab_visualeffect_watermark_top,'Visible','off');
        set(handles.tab_visualeffect_attack_top,'Visible','off');
        
        set(handles.tab_visualeffect_watermark_bottom,'Visible','on');
        set(handles.tab_visualeffect_attack_bottom,'Visible','on');
        set(handles.tab_visualeffect_benchmark,'Visible','on');
        
        
    case 'watermark'
        set(handles.tab_input,'Visible','off');
        set(handles.tab_watermark,'Visible','on');
        set(handles.tab_attack,'Visible','off');
        set(handles.tab_benchmark,'Visible','off');
        
        set(handles.tab_visualeffect_input,'Visible','on');
        set(handles.tab_visualeffect_watermark_top,'Visible','off');
        set(handles.tab_visualeffect_attack_top,'Visible','off');
        
        set(handles.tab_visualeffect_watermark_bottom,'Visible','off');
        set(handles.tab_visualeffect_attack_bottom,'Visible','on');
        set(handles.tab_visualeffect_benchmark,'Visible','on');
        
        set(handles.btn_next_watermark,'Enable','off');
        
        set(handles.popup_scheme, 'Enable','on');
        
        local_path = get_root_data('local_path');
        string = strcat(local_path,'\Watermarking Algorithms');
        %list the directories present under watermarking algorithms
        files = dir(string);
        i=3;
        j=0;
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
        text(1,1) = {'Choose your scheme'};
        
        set(handles.popup_scheme,'Value',1);  
        set(handles.popup_scheme,'string',text);  %Add all the files to the popupmenu

        set(handles.popup_domain,'Value',1);  
        set(handles.popup_domain,'Visible','off');
        set(handles.label_domain_watermark,'Visible','off');
        
        set(handles.popup_embed_watermark,'Value',1);  
        set(handles.popup_embed_watermark,'Visible','off');
        set(handles.label_embed_watermark,'Visible','off');
        
        set(handles.popup_detect_watermark,'Value',1);  
        set(handles.popup_detect_watermark,'Visible','off');
        set(handles.label_detect_watermark,'Visible','off');
        
        set(handles.btn_edit_embed_watermark,'Visible','off');
        set(handles.btn_edit_detect_watermark,'Visible','off');
        
        set(handles.tab_watermark_summary,'Visible','off');
        
        set(handles.checkbox_algorithm_done,'Enable','off');
        set(handles.checkbox_algorithm_done,'Value',0);
        set(handles.checkbox_watermark_done,'Enable','off');
        set(handles.checkbox_watermark_done,'Value',0);
        
        
        set(handles.checkbox_algorithm_done,'Enable','off');
        set(handles.tab_parameters,'Visible','off');
        set(handles.tab_watermark_summary,'Visible','off');
        
        set(handles.btn_next_watermark,'Enable','off');
    case 'attack'
        
        
        
        
        
        
        set(handles.tab_input,'Visible','off');
        set(handles.tab_watermark,'Visible','off');
        set(handles.tab_attack,'Visible','on');
        set(handles.tab_benchmark,'Visible','off');
        
        set(handles.tab_visualeffect_input,'Visible','on');
        set(handles.tab_visualeffect_watermark_top,'Visible','on');
        set(handles.tab_visualeffect_attack_top,'Visible','off');
        
        set(handles.tab_visualeffect_watermark_bottom,'Visible','off');
        set(handles.tab_visualeffect_attack_bottom,'Visible','off');
        set(handles.tab_visualeffect_benchmark,'Visible','on');
    case 'benchmark'
        set(handles.tab_input,'Visible','off');
        set(handles.tab_watermark,'Visible','off');
        set(handles.tab_attack,'Visible','off');
        set(handles.tab_benchmark,'Visible','on');
        
        set(handles.tab_visualeffect_input,'Visible','on');
        set(handles.tab_visualeffect_watermark_top,'Visible','on');
        set(handles.tab_visualeffect_attack_top,'Visible','on');
        
        set(handles.tab_visualeffect_watermark_bottom,'Visible','off');
        set(handles.tab_visualeffect_attack_bottom,'Visible','off');
        set(handles.tab_visualeffect_benchmark,'Visible','off');
end