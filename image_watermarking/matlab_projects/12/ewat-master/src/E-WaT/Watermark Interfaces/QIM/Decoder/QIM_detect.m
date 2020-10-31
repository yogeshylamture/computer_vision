function varargout = QIM_detect(varargin)
% QIM_DETECT M-file for QIM_detect.fig
%      QIM_DETECT, by itself, creates a new QIM_DETECT or raises the existing
%      singleton*.
%
%      H = QIM_DETECT returns the handle to a new QIM_DETECT or the handle to
%      the existing singleton*.
%
%      QIM_DETECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in QIM_DETECT.M with the given input arguments.
%
%      QIM_DETECT('Property','Value',...) creates a new QIM_DETECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before QIM_detect_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to QIM_detect_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help QIM_detect

% Last Modified by GUIDE v2.5 02-Nov-2007 13:50:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @QIM_detect_OpeningFcn, ...
                   'gui_OutputFcn',  @QIM_detect_OutputFcn, ...
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


% --- Executes just before QIM_detect is made visible.
function QIM_detect_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to QIM_detect (see VARARGIN)

% Choose default command line output for QIM_detect
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes QIM_detect wait for user response (see UIRESUME)
% uiwait(handles.figure1);

        %read in the watermarked image
        rgb_watermarked = get_root_data('plot_attacked_decode');
        
        axes(handles.origIm);                               %show the image in the axes 'origIm'
        imshow(rgb_watermarked);                            %show the image
        axis equal;
        axis tight;
        axis off;

        %hide the text detecting...
        set(handles.text14,'Visible','off');

        %hide the unused axes
        set(handles.dither0,'Visible','off');
        set(handles.dither1,'Visible','off');
        set(handles.orig_Message,'Visible','off');
        set(handles.recovered_message,'Visible','off');

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
        end;

        %fetch the value of delta in the root data
        delta = get_root_data('delta');
        
        blocksize = 8;

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

        % read in the watermarked object
        watermarked_image = double(get_root_data('working_attacked_decode'));

        % determine size of watermarked image
        Mw=size(watermarked_image,1);	%Height
        Nw=size(watermarked_image,2);	%Width

        % determine maximum possible message size in object
        max_message=floor(Mw*Nw/blocksize);

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

        %reset MATLAB's PN generator to state with value 'average'
        rand('state',double(average));

        %generate dither vectors dither[0] and dither[1]
        dither0 = zeros(1, blocksize); %#ok<NASGU>
        dither1 = zeros(1, blocksize);
        
        dither0 = rand(1, blocksize)*delta - delta/2;
        for j = 1:blocksize
            if (dither0(1,j) < 0 == 1)
                dither1(1,j) = 5 + dither0(1,j);
            else
                dither1(1,j) = -5 + dither0(1,j);
            end
        end
        
        axes(handles.dither0);
        imshow(dither0);
        axis equal;
        axis tight;
        axis off;
        
        axes(handles.dither1);
        imshow(dither1);
        axis equal;
        axis tight;
        axis off;

        % pad message out to maximum message size with ones
        message_vector=ones(max_message,1);

        % process the image in blocks
        % for each block determine it's correlation with base pn sequence
        x=1;
        y=1;
        detector = zeros(1,blocksize);
        sum = 0;
        
        for kk = 1:length(message_vector)

            workbar(kk/length(message_vector),'Detecting the message...','Progress');

            %reapply the dither vector dither0 and quantize
            
            detect_quantized0(y,x:(x+blocksize-1)) = round( ( watermarked_image(y,x:(x+blocksize-1)) - dither0(1,1:8) )/ delta) * delta; %#ok<AGROW>
            detect0(y,x:(x+blocksize-1)) = detect_quantized0(y,x:(x+blocksize-1)) + dither0(1,1:8); %#ok<AGROW>
            
            %check if the difference is less than delta/4
            for l = 0:blocksize-1
                if ( detect0(y,x:(x+l)) - watermarked_image(y,x:(x+l)) < delta/4 )
                    detector(1,l+1) = 0;
                else
                    detector(1,l+1) = 1;
                end
            end
            
            %calculate the sum of all detected differences 
            for m = 1:blocksize
                sum = sum + detector(1,m);
            end
            
            %assign the correct bit to the detected message
            if ( sum < blocksize/2 )
                message_vector(kk) = 0;
            else
                message_vector(kk) = 1;
            end
            
            sum = 0;

            % move on to next block. At and of row move to next row
            if (x+2*blocksize-1) > Nw
                x = 1;
                if(y+1) > Mw
                    y = y;
                else
                    y = y + 1;
                end
            else
                x = x + blocksize;
            end
        end

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

% --- Outputs from this function are returned to the command line.
function varargout = QIM_detect_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in done_btn.
function done_btn_Callback(hObject, eventdata, handles)
% hObject    handle to done_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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
