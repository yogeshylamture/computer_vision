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
%patch_detect: This is the patch gui for detecting a watermark

function varargout = patch_detect(varargin)
% PATCH_DETECT M-file for patch_detect.fig
%      PATCH_DETECT, by itself, creates a new PATCH_DETECT or raises the existing
%      singleton*.
%
%      H = PATCH_DETECT returns the handle to a new PATCH_DETECT or the handle to
%      the existing singleton*.
%
%      PATCH_DETECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PATCH_DETECT.M with the given input arguments.
%
%      PATCH_DETECT('Property','Value',...) creates a new PATCH_DETECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before patch_detect_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to patch_detect_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help patch_detect

% Last Modified by GUIDE v2.5 04-Nov-2007 14:22:22

% Begin initialization code - DO NOT EDIT
        gui_Singleton = 1;
        gui_State = struct('gui_Name',       mfilename, ...
                           'gui_Singleton',  gui_Singleton, ...
                           'gui_OpeningFcn', @patch_detect_OpeningFcn, ...
                           'gui_OutputFcn',  @patch_detect_OutputFcn, ...
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

%% Opening function
function patch_detect_OpeningFcn(hObject, eventdata, handles, varargin)
        
        handles.output = hObject;

        % Update handles structure
        guidata(hObject, handles);

        %Read the plotting image in
        rgb_watermarked = get_root_data('plot_attacked_decode');                 
        
        %Show the image in the axes 'watIm'
        axes(handles.watIm);                                    
        imshow(rgb_watermarked);                                
        axis equal;
        axis tight;
        axis off;

        %Hide the axes differences
        set(handles.differences,'Visible','off');
        
        %Read the working image in 
        im_watermarked = get_root_data('working_attacked_decode');
        im_watermarked = double(im_watermarked);
        
        %determine the size of the watermarked_image
        Mw = size(im_watermarked, 1);       %Height
        Nw = size(im_watermarked, 2);       %Width
        Numberofpixels = Mw*Nw;
        
        %Read the blocksize in from the root data
        blocksize = get_root_data('patch_blocksize');
        
        %Read the watermarking sequence in from the root data
        sequence = get_root_data('sequence');

        %Read the type of message in
        message_bit = get_root_data('message_bit');
        
        if (message_bit == 1)
            %Hide the panel for a complete message
            set(handles.panel_bit,'Visible','on');
            set(handles.panel_message,'Visible','off');
        else
            set(handles.panel_message,'Visible','on');
            set(handles.panel_bit,'Visible','off');
            
            %hide the text detecting...
            set(handles.text14,'Visible','off');
            
            %hide the unused axes for the messages
            set(handles.orig_Message,'Visible','off');
            set(handles.recovered_message,'Visible','off');
            
            %Read the original message in
            type = get_root_data('chosen_message');
            switch type
            case 'text'
                message = get_root_data('chosen_message_text');
                set(handles.text11,'String',message);

                set(handles.orig_Message,'Visible','off');
                set(handles.text11,'Visible','on');
            case 'imag'
                message = get_root_data('chosen_message_image');
                set(handles.orig_Message,'Visible','on');
                axes(handles.orig_Message);
                imshow(message);
                axis equal;
                axis tight;
                axis off;

                set(handles.text11,'Visible','off');
            end
        end
        
        if (message_bit == 0)
            type = get_root_data('chosen_message');
            switch type
                case 'text'
                    message = get_root_data('chosen_message_text');
                    %show the text detecting...
                    set(handles.text14,'Visible','on');
                    %hide the textbox recovered message
                    set(handles.text12,'Visible','off');

                case 'imag'
                    message = get_root_data('chosen_message_image');
                    %show the text detecting...
                    set(handles.text14,'Visible','on');
                    %hide the axes recovered_message
                    set(handles.recovered_message,'Visible','off');
            end;

            %calculate the sizes of the messages
            if(strcmp(type,'text'))
                message_binary = dec2bin(message);
                Mo=size(message_binary,1);                     %Height
                No=size(message_binary,2);                     %Width
            else
                Mo=size(message,1);
                No=size(message,2);
            end
            
            %Calculate the length of the message to detect and create an
            %empty message vector
            watermark_length = Mo*No;
            message_vector= ones(Mo*No,1);
            
        else
            %Determine the length of the patch sequence
            watermark_length = length(sequence)/4;
        end

        %Read in the type of key and the key itself
        type_key = get_root_data('chosen_key');
        switch type_key
            case 'text'
                key = get_root_data('chosen_key_text');

            case 'imag'
                key = get_root_data('chosen_key_image');
        end;

        if(type_key == 'text')
            key_text = key;

            %calculate the average of all values in the key text file
            m = size(key_text,1);
            sum = 0;
            for i = 1:m
                sum = sum + key_text(i,1);
            end
            average = round(sum/m);
        else
            key_image = key;

            %determine size of key image
            Mm=size(key_image,1);	%Height
            Nm=size(key_image,2);	%Width

            %calculate the average of all values in the key image file
            sum = 0;
            for i = 1:Mm
                for j = 1:Nm
                    sum = sum + key_image(i,j);
                end
            end
            average = round(sum/(Mm*Nm));
        end

        %reset Matlab's Pseudo Random Number Generator (PRNG) to state with initial
        %value average
        rand('state', double(average));

        %Declare variables to calculate differences between pixels
        sum = int32(0);
        
        %Make figure to visualize the differences between pixels
        difference_image = zeros(Mw,Nw);
        j = 1;

        for i = 1:watermark_length
            workbar(i/watermark_length,'Detecting message...','Progress');
            if (message_bit == 1)
               %Retrieve the first random block
               ax = sequence(1,j);
               ay = sequence(1,j+1);

               %Retrieve the second selected block
               bx = sequence(1,j+2);
               by = sequence(1,j+3);
               
               j = j + 4;

               %Calculate the difference between the selected pair of blocks
               for f = 0:blocksize-1
                   for g = 0:blocksize-1
                       difference = int32(im_watermarked(ax*blocksize-f,ay*blocksize-g) - im_watermarked(bx*blocksize-f,by*blocksize-g));
                       sum = sum + difference;
                       difference_image(ax*blocksize-f,ay*blocksize-g) = difference;
                   end
               end
            else 
               %Retrieve the first random block
               ax = sequence(1,j);
               ay = sequence(1,j+1);

               %Retrieve the second selected block
               bx = sequence(1,j+2);
               by = sequence(1,j+3);
               
               j = j + 4;

               %Calculate the difference between the selected pair of blocks
               for f = 0:blocksize-1
                   for g = 0:blocksize-1
                       difference = int32(im_watermarked(ax*blocksize-f,ay*blocksize-g) - im_watermarked(bx*blocksize-f,by*blocksize-g));
                       sum = sum + difference;
                       difference_image(ax*blocksize-f,ay*blocksize-g) = difference;
                       
                   end
               end

               %Calculate the average difference per pixel of the blocks
               average = double(sum)/double(blocksize^2);

               %average number determines if the message bit is 1
               %or 0
               if (average > 0)              
                   message_vector(i,1) = 1;
               else
                   message_vector(i,1) = 0;
               end
               
               sum = 0;
               
            end
        end

        %Read the embedding strength in from the file
        k = get_root_data('patch_k');
        
        axes(handles.differences);                              %show the image in the axes 'differences'
        imshow(difference_image,[-50 50]);                      %show the image
        set(handles.differences,'Visible','on');
        axis equal;
        axis tight;
        axis off;

        if (message_bit == 1)
            set(handles.panel_bit,'Visible','on');
            
            %Calculate the average difference between all modified pixels
            average = double(sum)/double(watermark_length*blocksize^2);

            %Display the value average in the first Edit-box
            set(handles.outEdit1,'String',average);
            set(handles.outEdit1,'Value',average);

            average = get(handles.outEdit1,'Value');

            %Read the embedding strength in from the file
            k = get_root_data('patch_k');

            %Read the threshold percentage set by the user
            threshold = round(get(handles.threshold,'Value'))/100;
            set(handles.value_threshold,'String',threshold*100);

            %average number must be around 2*k, twice the embedding strength
            if (average > 2*k*threshold)              
                if(average < 2*k*(2-threshold) )
                    watermark_present = 'yes';
                else 
                    watermark_present = 'no';
                end
            else
                watermark_present = 'no';
            end

            %Display the presence of the watermark in the second Edit-box
            set(handles.outEdit2,'String',watermark_present);
        else
            % reshape the message
            message=reshape(message_vector(1:Mo*No),Mo,No);

            if(strcmp(type,'text'))
                message(1:Mo,1:No);
                %hide the text/image detecting...
                set(handles.text14,'Visible','off');
                set(handles.recovered_message,'Visible','off');
                %show the textbox recovered message
                set(handles.text12,'Visible','on');
                %first transform the O's and 1's to characters, then reshape the the
                %characters to a horizontal string
                message_reshaped = reshape( char(bin2dec(num2str(message(1:Mo,1:No)))), 1, Mo); 
                set(handles.text12,'String',message_reshaped);

                set_root_data(handles,'detected_message',message_reshaped);
            else
                %hide the text detecting...
                set(handles.text14,'Visible','off');
                set(handles.text12,'Visible','off');
                %show the axes recovered_message
                set(handles.recovered_message,'Visible','on');
                axes(handles.recovered_message);                             %show the image in the axes 'recovered_message'
                imshow(message);                                             %show the image
                axis equal;
                axis tight;
                axis off;

                set_root_data(handles,'detected_message',message);
            end
        end


%% Output
function varargout = patch_detect_OutputFcn(hObject, eventdata, handles) 

        varargout{1} = handles.output;

%% Average difference
function outEdit1_Callback(hObject, eventdata, handles)

function outEdit1_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

%% Watermark detected
function outEdit2_Callback(hObject, eventdata, handles)

function outEdit2_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
%% Done
function done_btn_Callback(hObject, eventdata, handles)
    if (get_root_data('message_bit') == 1)
        watermark_found = get(handles.outEdit2,'String');
        switch watermark_found
            case 'yes'
                image = imread('copyrighted_yes.jpg');
                
                set_root_data(handles,'embedded_image',image);
                set_root_data(handles,'detected_image',image);
                
                close();
                fhupdate_axes('image',image);
                
            case 'no'
                image_embed = imread('copyrighted_yes.jpg');
                image_dsc = imread('copyrighted_no.jpg');
                
                set_root_data(handles,'embedded_image',image_embed);
                set_root_data(handles,'detected_image',image_dsc);
                
                close();
                fhupdate_axes('image',image_dsc);
        end;
    else
        watermark_found = get(handles.text11,'Visible');
        switch watermark_found
            case 'on'       % Text was the message
                text = get(handles.text12,'String');
                original_message = get(handles.text11,'String');
                
                set_root_data(handles,'embedded_text',original_message);
                set_root_data(handles,'detected_text',text);
                
                close();
                fhupdate_axes('text',text);
                
            case 'off'
                image_recovered = getimage(handles.recovered_message);
                original_image = getimage(handles.orig_Message);
                
                set_root_data(handles,'embedded_image',original_image);
                set_root_data(handles,'detected_image',image_recovered);
                
                close();
                fhupdate_axes('image',image_recovered);
        end;
    end

% --- Executes on slider movement.
function threshold_Callback(hObject, eventdata, handles)
% hObject    handle to threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

        average = get(handles.outEdit1,'Value');

        %Read the embedding strength in from the file
        k = get_root_data('patch_k');
        
        %Read the threshold percentage set by the user
        threshold = round(get(handles.threshold,'Value'))/100;
        set(handles.value_threshold,'String',threshold*100);

        %average number must be around 2*k, twice the embedding strength
        if (average > 2*k*threshold)              
            if(average < 2*k*(2-threshold) )
                watermark_present = 'yes';
            else 
                watermark_present = 'no';
            end
        else
            watermark_present = 'no';
        end

        %Display the presence of the watermark in the second Edit-box
        set(handles.outEdit2,'String',watermark_present);

% --- Executes during object creation, after setting all properties.
function threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function panel_bit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to panel_bit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

