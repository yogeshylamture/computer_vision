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
%correlation_detect: This is the correlation gui for detecting the message

function varargout = correlation_detect(varargin)
% CORRELATION_DETECT M-file for correlation_detect.fig
%      CORRELATION_DETECT, by itself, creates a new CORRELATION_DETECT or raises the existing
%      singleton*.
%
%      H = CORRELATION_DETECT returns the handle to a new CORRELATION_DETECT or the handle to
%      the existing singleton*.
%
%      CORRELATION_DETECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CORRELATION_DETECT.M with the given input arguments.
%
%      CORRELATION_DETECT('Property','Value',...) creates a new CORRELATION_DETECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before correlation_detect_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to correlation_detect_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help correlation_detect

% Last Modified by GUIDE v2.5 02-Jun-2007 09:35:30

% Begin initialization code - DO NOT EDIT
        gui_Singleton = 1;
        gui_State = struct('gui_Name',       mfilename, ...
                           'gui_Singleton',  gui_Singleton, ...
                           'gui_OpeningFcn', @correlation_detect_OpeningFcn, ...
                           'gui_OutputFcn',  @correlation_detect_OutputFcn, ...
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
function correlation_detect_OpeningFcn(hObject, eventdata, handles, varargin)

        handles.output = hObject;

        % Update handles structure
        guidata(hObject, handles);

        % UIWAIT makes correlation_detect wait for user response (see UIRESUME)
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
        set(handles.bit0,'Visible','off');
        set(handles.bit1,'Visible','off');
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

        %read in the blocksize
        blocksize = get_root_data('cor_blocksize');

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

        axes(handles.bit0);                                 %show the image in the axes 'bit0'
        imshow(pn_sequence_zero,[0 1]);                     %show the image
        axis equal;
        axis tight;
        axis off;

        axes(handles.bit1);                                 %show the image in the axes 'bit1'
        imshow(pn_sequence_one,[0 1]);                      %show the image
        axis equal;
        axis tight;
        axis off;

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

        %read in the blocksize
        blocksize = get_root_data('cor_blocksize');

        % read in the watermarked object
        watermarked_image = get_root_data('working_attacked_decode');

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
        function varargout = correlation_detect_OutputFcn(hObject, eventdata, handles) 
        % varargout  cell array for returning output args (see VARARGOUT);
        % hObject    handle to figure
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)

        % Get default command line output from handles structure
        varargout{1} = handles.output;


        function [sequence_zero,sequence_one] = make_sequences(blocksize,key,type_key)

        if(strcmp(type_key,'text'))
            %Read the key in from a text file
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
        pn_sequence_one=round( rand(blocksize,blocksize) );
        pn_sequence_zero=ones(blocksize,blocksize) - pn_sequence_one;
        %pn_sequence_zero=round( rand(blocksize,blocksize) );

        %find two highly un-correlated PN sequences
        %while (corr2(pn_sequence_one,pn_sequence_zero) > -0.5)
        %    pn_sequence_one=round( rand(blocksize,blocksize) );
        %    pn_sequence_zero=round( rand(blocksize,blocksize) );
        %end

        sequence_zero = pn_sequence_zero;
        sequence_one = pn_sequence_one;
%% Button Done
function done_btn_Callback(hObject, eventdata, handles)
    

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
        
        
