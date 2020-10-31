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
%dct_detect: This is the dct gui for detecting the message

function varargout = dct_detect(varargin)
% DCT_DETECT M-file for dct_detect.fig
%      DCT_DETECT, by itself, creates a new DCT_DETECT or raises the existing
%      singleton*.
%
%      H = DCT_DETECT returns the handle to a new DCT_DETECT or the handle to
%      the existing singleton*.
%
%      DCT_DETECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DCT_DETECT.M with the given input arguments.
%
%      DCT_DETECT('Property','Value',...) creates a new DCT_DETECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dct_detect_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dct_detect_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dct_detect

% Last Modified by GUIDE v2.5 02-Jun-2007 11:26:38

% Begin initialization code - DO NOT EDIT
        gui_Singleton = 1;
        gui_State = struct('gui_Name',       mfilename, ...
                           'gui_Singleton',  gui_Singleton, ...
                           'gui_OpeningFcn', @dct_detect_OpeningFcn, ...
                           'gui_OutputFcn',  @dct_detect_OutputFcn, ...
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
function dct_detect_OpeningFcn(hObject, eventdata, handles, varargin)

        handles.output = hObject;

        % Update handles structure
        guidata(hObject, handles);

        % UIWAIT makes dct_detect wait for user response (see UIRESUME)
        % uiwait(handles.figure1);

        %read in the watermarked image
        
        
        watermarked_image = get_root_data('plot_attacked_decode');
        %rgb_watermarked = recontruct_from_working_image_for_plotting(watermarked_image);

        axes(handles.watIm);                                %show the image in the axes 'watIm'
        imshow(watermarked_image);                            %show the image
        axis equal;
        axis tight;
        axis off;

        %hide the text detecting...
        set(handles.text10,'Visible','on');
        set(handles.recovered_Message,'Visible','off');
        set(handles.text8,'Visible','off');


        %hide the unused axes
        set(handles.dct_image,'Visible','off');
        set(handles.dct_block,'Visible','off');


        type = get_root_data('chosen_message');
        switch type
            case 'text'
                message = get_root_data('chosen_message_text');
                set(handles.text7,'String',message);

                set(handles.text7,'Visible','on');
                set(handles.orig_Message,'Visible','off');

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
        
        im_original = get_root_data('working_attacked_decode');             %read the image in
        %determine size of cover work
        Mc=size(im_original,1);         %Height
        Nc=size(im_original,2);         %Width

        %initialise the variables
        im_dct = zeros(Mc,Nc);
        blocksize = 8;

        %perform DCT transform on the cover work - block by block
        for i = 1:(Mc/blocksize)
            for j = 1:(Nc/blocksize)
                im_dct(i*blocksize-blocksize+1:i*blocksize,j*blocksize-blocksize+1:j*blocksize) = dct2(im_original(i*blocksize-blocksize+1:i*blocksize,j*blocksize-blocksize+1:j*blocksize));
            end
        end

        %reduce the pixel values to [0 255]
        [min,max] = get_range(im_dct,Mc,Nc);
        image_dct_dbl = double( (im_dct-min)./(max-min) );
        image_dct_int = uint8(image_dct_dbl.*255);

        axes(handles.dct_image);                                    %show the image in the axes 'dct_image'
        imshow(image_dct_int,[0 255]);                              %show the image
        axis equal;
        axis tight;
        axis off;

        axes(handles.dct_block);                                    %show the image in the axes 'dct_block'
        imshow(image_dct_int(1:blocksize,1:blocksize),[0 255]);     %show the image
        axis equal;
        axis tight;
        axis off;



        type = get_root_data('chosen_message');
        switch type
            case 'text'
                message = get_root_data('chosen_message_text');
                %show the text detecting...
                set(handles.text10,'Visible','on');
                %hide the textbox recovered message
                set(handles.text8,'Visible','off');
                set(handles.recovered_Message,'Visible','off');

            case 'imag'
                message = get_root_data('chosen_message_image');
                %show the text detecting...
                set(handles.text10,'Visible','on');
                %hide the axes recovered_message
                set(handles.recovered_Message,'Visible','off');
                set(handles.text8,'Visible','off');
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

        blocksize = 8;

        watermarked_image = get_root_data('working_attacked_decode');          %read the image in

        % determine size of watermarked image
        Mw=size(watermarked_image,1);	%Height
        Nw=size(watermarked_image,2);	%Width

        %perform DCT transform on the watermarked image - block by block
        for i = 1:(Mw/blocksize)
            for j = 1:(Nw/blocksize)
                im_dct(i*blocksize-blocksize+1:i*blocksize,j*blocksize-blocksize+1:j*blocksize) = dct2(watermarked_image(i*blocksize-blocksize+1:i*blocksize,j*blocksize-blocksize+1:j*blocksize));
            end
        end

        %reduce the pixel values to [0 255]
        [min,max] = get_range(im_dct,Mw,Nw);
        image_dct_dbl = double( (im_dct-min)./(max-min) );
        image_dct_int = uint8(image_dct_dbl.*255);

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

        %read the used frequency components in
        lmh = get_root_data('dct_components');

        if (lmh == 100)
            mask =[ 0,1,1,1,1,0,0,0;    % defines the low-band frequencies of an 8x8 dct
                    1,1,1,1,0,0,0,0;
                    1,1,1,0,0,0,0,0;
                    1,1,0,0,0,0,0,0;
                    1,0,0,0,0,0,0,0;
                    0,0,0,0,0,0,0,0;
                    0,0,0,0,0,0,0,0;
                    0,0,0,0,0,0,0,0 ];
            pn_sequence_one = pn_sequence_one.*mask;
            pn_sequence_zero = pn_sequence_zero.*mask;
        elseif (lmh == 010)
            mask =[ 0,0,0,0,0,1,1,1;    % defines the middle-band frequencies of an 8x8 dct
                    0,0,0,0,1,1,1,1;
                    0,0,0,1,1,1,1,1;
                    0,0,1,1,1,1,1,0;
                    0,1,1,1,1,1,0,0;
                    1,1,1,1,1,0,0,0;
                    1,1,1,1,0,0,0,0;
                    1,1,1,0,0,0,0,0 ];
            pn_sequence_one = pn_sequence_one.*mask;
            pn_sequence_zero = pn_sequence_zero.*mask;
        elseif (lmh == 001)
            mask =[ 0,0,0,0,0,0,0,0;    % defines the high-band frequencies of an 8x8 dct
                    0,0,0,0,0,0,0,0;
                    0,0,0,0,0,0,0,0;
                    0,0,0,0,0,0,0,1;
                    0,0,0,0,0,0,1,1;
                    0,0,0,0,0,1,1,1;
                    0,0,0,0,1,1,1,1;
                    0,0,0,1,1,1,1,1 ];
            pn_sequence_one = pn_sequence_one.*mask;
            pn_sequence_zero = pn_sequence_zero.*mask;
        elseif (lmh == 110)
            mask =[ 0,1,1,1,1,1,1,1;    % defines the low-band and middle-band frequencies of an 8x8 dct
                    1,1,1,1,1,1,1,1;
                    1,1,1,1,1,1,1,1;
                    1,1,1,1,1,1,1,0;
                    1,1,1,1,1,1,0,0;
                    1,1,1,1,1,0,0,0;
                    1,1,1,1,0,0,0,0;
                    1,1,1,0,0,0,0,0 ];
            pn_sequence_one = pn_sequence_one.*mask;
            pn_sequence_zero = pn_sequence_zero.*mask;
        elseif (lmh == 101)
            mask =[ 0,1,1,1,1,0,0,0;    % defines the low-band and high-band frequencies of an 8x8 dct
                    1,1,1,1,0,0,0,0;
                    1,1,1,0,0,0,0,0;
                    1,1,0,0,0,0,0,1;
                    1,0,0,0,0,0,1,1;
                    0,0,0,0,0,1,1,1;
                    0,0,0,0,1,1,1,1;
                    0,0,0,1,1,1,1,1 ];
            pn_sequence_one = pn_sequence_one.*mask;
            pn_sequence_zero = pn_sequence_zero.*mask;
        elseif (lmh == 011)
            mask =[ 0,0,0,0,0,1,1,1;    % defines the middle-band and high-band frequencies of an 8x8 dct
                    0,0,0,0,1,1,1,1;
                    0,0,0,1,1,1,1,1;
                    0,0,1,1,1,1,1,1;
                    0,1,1,1,1,1,1,1;
                    1,1,1,1,1,1,1,1;
                    1,1,1,1,1,1,1,1;
                    1,1,1,1,1,1,1,1 ];
            pn_sequence_one = pn_sequence_one.*mask;
            pn_sequence_zero = pn_sequence_zero.*mask;
        elseif (lmh == 111)
            mask =[ 0,1,1,1,1,1,1,1;    % defines the low-band, middle-band and high-band frequencies of an 8x8 dct
                    1,1,1,1,1,1,1,1;
                    1,1,1,1,1,1,1,1;
                    1,1,1,1,1,1,1,1;
                    1,1,1,1,1,1,1,1;
                    1,1,1,1,1,1,1,1;
                    1,1,1,1,1,1,1,1;
                    1,1,1,1,1,1,1,1 ];
            pn_sequence_one = pn_sequence_one.*mask;
            pn_sequence_zero = pn_sequence_zero.*mask;
        else
            mask =[ 0,0,0,0,0,0,0,0;    % defines no frequencies of an 8x8 dct
                    0,0,0,0,0,0,0,0;
                    0,0,0,0,0,0,0,0;
                    0,0,0,0,0,0,0,0;
                    0,0,0,0,0,0,0,0;
                    0,0,0,0,0,0,0,0;
                    0,0,0,0,0,0,0,0;
                    0,0,0,0,0,0,0,0 ];
            pn_sequence_one = pn_sequence_one.*mask;
            pn_sequence_zero = pn_sequence_zero.*mask;
        end

        % pad message out to maximum message size with ones
        message_vector=ones(max_message,1);

        % process the image in blocks
        % for each block determine it's correlation with base pn sequence
        x=1;
        y=1;
        for kk = 1:length(message_vector)

            workbar(kk/length(message_vector),'Detecting the message...','Progress');

            % calculate correlations for both PN sequences
            correlation_one(kk)=corr2(image_dct_int(y:y+blocksize-1,x:x+blocksize-1),pn_sequence_one);
            correlation_zero(kk)=corr2(image_dct_int(y:y+blocksize-1,x:x+blocksize-1),pn_sequence_zero);

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
            set(handles.text10,'Visible','off');
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
            set(handles.text10,'Visible','off');
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
%% get_range
function [min,max] = get_range(cX,Mc,Nc)

        %Initialise two variables min and max
        min = cX(1,1);
        max = cX(1,1);

        for i = 1:Mc
            for j = 1:Nc
                if(cX(i,j) < min)
                    min = cX(i,j);          %determine the minimum value of all pixels
                end
                if(cX(i,j) > max)
                    max = cX(i,j);          %determine the maximum value of all pixels
                end
            end
        end

%% Output
function varargout = dct_detect_OutputFcn(hObject, eventdata, handles) 
        varargout{1} = handles.output;

%% Check vit
function check_fit_Callback(hObject, eventdata, handles)

%% Make sequences
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
        %all values are -1, 0 or 1
        pn_sequence_one=round(2*(rand(blocksize,blocksize)-0.5));
        pn_sequence_zero=round(2*(rand(blocksize,blocksize)-0.5));

        %find two highly un-correlated PN sequences
        while (corr2(pn_sequence_one,pn_sequence_zero) > -0.1)
            pn_sequence_one=round(2*(rand(blocksize,blocksize)-0.5));
            pn_sequence_zero=round(2*(rand(blocksize,blocksize)-0.5));
        end

        sequence_zero = pn_sequence_zero;
        sequence_one = pn_sequence_one;
%% Button done
function done_btn_Callback(hObject, eventdata, handles)

        watermark_found = get(handles.text7,'Visible');
        
        switch watermark_found
            case 'on'       % Text was the message
                text_detect = get(handles.text8,'String');
                text_original = get(handles.text7,'String');
                
                set_root_data(handles,'embedded_text',text_original);
                set_root_data(handles,'detected_text',text_detect);
                
                close();
                fhupdate_axes('text',text_detect);
                
            case 'off'
                image_recovered = getimage(handles.recovered_Message);
                original_image = getimage(handles.orig_Message);
                
                set_root_data(handles,'embedded_image',original_image);
                set_root_data(handles,'detected_image',image_recovered);
                
                close();
                fhupdate_axes('image',image_recovered);
        end;
        
        