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
%dwt_detect: This is the dct gui for detecting the message

function varargout = dwt_detect(varargin)
% DWT_DETECT M-file for dwt_detect.fig
%      DWT_DETECT, by itself, creates a new DWT_DETECT or raises the existing
%      singleton*.
%
%      H = DWT_DETECT returns the handle to a new DWT_DETECT or the handle to
%      the existing singleton*.
%
%      DWT_DETECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DWT_DETECT.M with the given input arguments.
%
%      DWT_DETECT('Property','Value',...) creates a new DWT_DETECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dwt_detect_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dwt_detect_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dwt_detect

% Last Modified by GUIDE v2.5 02-Jun-2007 12:26:49

% Begin initialization code - DO NOT EDIT
        gui_Singleton = 1;
        gui_State = struct('gui_Name',       mfilename, ...
                           'gui_Singleton',  gui_Singleton, ...
                           'gui_OpeningFcn', @dwt_detect_OpeningFcn, ...
                           'gui_OutputFcn',  @dwt_detect_OutputFcn, ...
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
function dwt_detect_OpeningFcn(hObject, eventdata, handles, varargin)

        handles.output = hObject;

        % Update handles structure
        guidata(hObject, handles);

        % UIWAIT makes dwt_detect wait for user response (see UIRESUME)
        % uiwait(handles.figure1);

        %read in the watermarked image
        watermarked_image = get_root_data('plot_attacked_decode');
        
        axes(handles.watIm);                                %show the image in the axes 'watIm'
        imshow(watermarked_image);                             %show the image
        axis equal;
        axis tight;
        axis off;

        %hide the unused axes
        set(handles.dwtIm,'Visible','off');
        set(handles.orig_Message,'Visible','off');
        set(handles.recovered_Message,'Visible','off');

        type = get_root_data('chosen_message');
        switch type
            case 'text'
                message = get_root_data('chosen_message_text');
                set(handles.text7,'String',message);
                set(handles.orig_Message,'Visible','off');
                set(handles.text7,'Visible','on');

            case 'imag'
                message = get_root_data('chosen_message_image');
                set(handles.orig_Message,'Visible','on');
                axes(handles.orig_Message);
                imshow(message);
                axis equal;
                axis tight;
                axis off;
                set(handles.text7,'Visible','off');

        end;

        im_watermarked = get_root_data('working_attacked_decode');          %read the image in

        %open the file with the used wavelet method
        method = get_root_data('dwt_method');


        
        %perform DWT transform on the watermarked image
        [cA1,cH1,cV1,cD1] = dwt2(im_watermarked,method);
        [cA2,cH2,cV2,cD2] = dwt2(cA1,method);
        [cA3,cH3,cV3,cD3] = dwt2(cA2,method);
        [cA4,cH4,cV4,cD4] = dwt2(cA3,method);
        [cA5,cH5,cV5,cD5] = dwt2(cA4,method);
        dwt = [[[[[cA5,cH5;cV5,cD5],cH4;cV4,cD4],cH3;cV3,cD3],cH2;cV2,cD2],cH1;cV1,cD1];

        %read the level in from the pop-up menu
        level = get(handles.popupmenu1,'Value');

        if (level == 1)
            dwt_level = [cD2,cH2;cV2,cA2];
        else
            dwt_level = [cD3,cH3;cV3,cA3];

        end

        %display the DWT transformed image
        axes(handles.dwtIm);                                    %show the image in the axes 'dwtIm'
        imshow(dwt_level,[]);                                   %show the image
        axis equal;
        axis tight;
        axis off;

        type = get_root_data('chosen_message');
        switch type
            case 'text'
                message = get_root_data('chosen_message_text');
                %show the text detecting...
                set(handles.text9,'Visible','on');
                %hide the textbox recovered message
                set(handles.text8,'Visible','off');
                set(handles.recovered_Message,'Visible','off');

            case 'imag'
                message = get_root_data('chosen_message_image');
                %show the text detecting...
                set(handles.text9,'Visible','on');
                %hide the axes recovered_message
                set(handles.text8,'Visible','off');
                set(handles.recovered_Message,'Visible','off');
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

        %read in the watermarked level and corresponding blocksize
        level = get_root_data('dwt_level');
        if (level == 2)
            blocksize = 4;
        elseif (level == 3)
            blocksize = 2;
        else
            blocksize = 4;
        end

        im_watermarked = get_root_data('working_attacked_decode');          %read the image in

        %read the used wavelet method in
        method = get_root_data('dwt_method');

        %reshape the method to a string
        m_size = size(method,1);
        %method_reshaped = reshape(method,1,m_size);

        %perform DWT transform on the watermarked image
        [cA1,cH1,cV1,cD1] = dwt2(im_watermarked,method);
        [cA2,cH2,cV2,cD2] = dwt2(cA1,method);
        [cA3,cH3,cV3,cD3] = dwt2(cA2,method);
        [cA4,cH4,cV4,cD4] = dwt2(cA3,method);
        [cA5,cH5,cV5,cD5] = dwt2(cA4,method);

        %read the watermarked component(s) in
        component = get_root_data('dwt_component');

        %select the component to look for a watermark
        if (level == 2)
            if (strcmp(component,'a'))
                watermarked_image = cA2;
            elseif (strcmp(component,'h'))
                watermarked_image = cH2;
            elseif (strcmp(component,'v'))
                watermarked_image = cV2;
            elseif (strcmp(component,'d'))
                watermarked_image = cD2;
            else
                watermarked_image = cA2;
            end
        elseif (level == 3)
            if (strcmp(component,'a'))
                watermarked_image = cA3;
            elseif (strcmp(component,'h'))
                watermarked_image = cH3;
            elseif (strcmp(component,'v'))
                watermarked_image = cV3;
            elseif (strcmp(component,'d'))
                watermarked_image = cD3;
            else
                watermarked_image = cA3;
            end
        else
            if (strcmp(component,'a'))
                watermarked_image = cA2;
            elseif (strcmp(component,'h'))
                watermarked_image = cH2;
            elseif (strcmp(component,'v'))
                watermarked_image = cV2;
            elseif (strcmp(component,'d'))
                watermarked_image = cD2;
            else
                watermarked_image = cA2;
            end
        end

        % determine size of watermarked image
        Mw=size(watermarked_image,1);	%Height
        Nw=size(watermarked_image,2);	%Width

        % determine maximum possible message size in object
        max_message=floor(Mw*Nw/(blocksize^2));

        type_key = get_root_data('chosen_key');
        switch type_key
            case 'text'
                key = get_root_data('chosen_key_text');

            case 'imag'
                key = get_root_data('chosen_key_image');
        end;

        %the called function make_sequences will calculate both PRNG sequences for 0
        %and 1
        [pn_sequence_zero,pn_sequence_one] = make_sequences(blocksize,key,type_key);

        % pad message out to maximum message size with ones
        message_vector=ones(max_message,1);

        % process the image in blocks
        % for each block determine it's correlation with base pn sequence
        x=1;
        y=1;
        for kk = 1:length(message_vector)

            workbar(kk/length(message_vector),'Detecting the message...','Progress');

            % calculate correlations for both PN sequences
            correlation_one(kk)=corr2(watermarked_image(y:y+blocksize-1,x:x+blocksize-1),pn_sequence_one);
            correlation_zero(kk)=corr2(watermarked_image(y:y+blocksize-1,x:x+blocksize-1),pn_sequence_zero);

            % choose which ever correlation is higher
            if (correlation_one(kk) > correlation_zero(kk))
                message_vector(kk)=1;
            else
                message_vector(kk)=0;
            end

            % move on to next block. At and of row move to next row
            if (x+2*blocksize-1) > Nw
                x = 1;
                if(y+2*blocksize-1) > Mw
                    y = y;
                else
                    y = y + blocksize;
                end
            else
                x = x + blocksize;
            end
        end

        % reshape the message
        message=reshape(message_vector(1:Mo*No),Mo,No);

        if(strcmp(type,'text'))
            message(1:Mo,1:No);
            %hide the text detecting...
            set(handles.text9,'Visible','off');
            %show the textbox recovered message
            set(handles.text8,'Visible','on');
            set(handles.recovered_Message,'Visible','off');
            %first transform the O's and 1's to characters, then reshape the the
            %characters to a horizontal string
            message_reshaped = reshape( char(bin2dec(num2str(message(1:Mo,1:No)))), 1, Mo); 
            set(handles.text8,'String',message_reshaped);

            set_root_data(handles,'detected_message',message_reshaped);
        else
            %hide the text detecting...
            set(handles.text9,'Visible','off');
            %show the axes recovered_message
            set(handles.text8,'Visible','off');
            set(handles.recovered_Message,'Visible','on');  
            axes(handles.recovered_Message);                             
            imshow(message);                                             
            axis equal;
            axis tight;
            axis off;

            set_root_data(handles,'detected_message',message);
        end

%% Output
function varargout = dwt_detect_OutputFcn(hObject, eventdata, handles) 
        varargout{1} = handles.output;
        
%% Popup menu update
function popupmenu1_Callback(hObject, eventdata, handles)

        im_watermarked = get_root_data('working_attacked_decode');          %read the image in

        %open the file with the used wavelet method
        method = get_root_data('dwt_method');


        %reshape the text to a string

        %perform DWT transform on the watermarked image
        [cA1,cH1,cV1,cD1] = dwt2(im_watermarked,method);
        [cA2,cH2,cV2,cD2] = dwt2(cA1,method);
        [cA3,cH3,cV3,cD3] = dwt2(cA2,method);

        %read the level in from the pop-up menu
        level = get(handles.popupmenu1,'Value');
        if (level == 1)
            dwt_level = [cD2,cH2;cV2,cA2];
        else
            dwt_level = [cD3,cH3;cV3,cA3];
        end

        %display the DWT transformed image
        axes(handles.dwtIm);                                    %show the image in the axes 'dwtIm'
        imshow(dwt_level,[]);                                   %show the image
        axis equal;
        axis tight;
        axis off;

function popupmenu1_CreateFcn(hObject, eventdata, handles)

        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

%% Make sequence
function [sequence_zero,sequence_one] = make_sequences(blocksize,key,type_key)

        if(strcmp(type_key,'text'))
            key_text = key;

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

            sum = 0;
            for i = 1:Mm
                for j = 1:Nm
                    sum = sum + key_image(i,j);
                end
            end
            average = round(sum/(Mm*Nm));
        end

        %reset MATLAB's PN generator to state with value 'average'
        rand('state',double(average));

        %generate PN sequences to implement "1" and "0"
        %all values are 0 or 1
        pn_sequence_one = round( rand(blocksize,blocksize) );
        pn_sequence_zero = ones(blocksize,blocksize) - pn_sequence_one; 
        %pn_sequence_one=round(2*(rand(blocksize,blocksize)-0.5));
        %pn_sequence_zero=round(2*(rand(blocksize,blocksize)-0.5));

        %find two highly un-correlated PN sequences
        %while (corr2(pn_sequence_one,pn_sequence_zero) > -0.1)
        %    pn_sequence_one=round(2*(rand(blocksize,blocksize)-0.5));
        %    pn_sequence_zero=round(2*(rand(blocksize,blocksize)-0.5));
        %end

        sequence_zero = pn_sequence_zero;
        sequence_one = pn_sequence_one;
%% Get range
function [min,max] = get_range(cX,Mc,Nc)

        min = cX(1,1);
        max = cX(1,1);
        for i = 1:Mc/2
            for j = 1:Nc/2
                if(cX(i,j) < min)
                    min = cX(i,j);
                end
                if(cX(i,j) > max)
                    max = cX(i,j);
                end
            end
        end

function done_btn_Callback(hObject, eventdata, handles)

        watermark_found = get(handles.text7,'Visible');
        switch watermark_found
            case 'on'       % Text was the message
                original_text = get(handles.text7,'String');
                detected_text = get(handles.text8,'String');
                
                set_root_data(handles,'embedded_text',original_text);
                set_root_data(handles,'detected_text',detected_text);
                
                close();
                
                fhupdate_axes('text',detected_text);
                
            case 'off'
                image_recovered = getimage(handles.recovered_Message);
                original_image = getimage(handles.orig_Message);
                
                set_root_data(handles,'embedded_image',original_image);
                set_root_data(handles,'detected_image',image_recovered);
                
                close();
                fhupdate_axes('image',image_recovered);
        end;
        
        
