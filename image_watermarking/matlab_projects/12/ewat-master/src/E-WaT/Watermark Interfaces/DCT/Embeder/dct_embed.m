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
%dct_embed: This is the dct gui for embedding the message

function varargout = dct_embed(varargin)
        % DCT_EMBED M-file for dct_embed.fig
        %      DCT_EMBED, by itself, creates a new DCT_EMBED or raises the existing
        %      singleton*.
        %
        %      H = DCT_EMBED returns the handle to a new DCT_EMBED or the handle to
        %      the existing singleton*.
        %
        %      DCT_EMBED('CALLBACK',hObject,eventData,handles,...) calls the local
        %      function named CALLBACK in DCT_EMBED.M with the given input arguments.
        %
        %      DCT_EMBED('Property','Value',...) creates a new DCT_EMBED or raises the
        %      existing singleton*.  Starting from the left, property value pairs are
        %      applied to the GUI before dct_embed_OpeningFunction gets called.  An
        %      unrecognized property name or invalid value makes property application
        %      stop.  All inputs are passed to dct_embed_OpeningFcn via varargin.
        %
        %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
        %      instance to run (singleton)".
        %
        % See also: GUIDE, GUIDATA, GUIHANDLES

        % Edit the above text to modify the response to help dct_embed

        % Last Modified by GUIDE v2.5 07-Jun-2007 00:52:36

        % Begin initialization code - DO NOT EDIT
        gui_Singleton = 1;
        gui_State = struct('gui_Name',       mfilename, ...
                           'gui_Singleton',  gui_Singleton, ...
                           'gui_OpeningFcn', @dct_embed_OpeningFcn, ...
                           'gui_OutputFcn',  @dct_embed_OutputFcn, ...
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
function dct_embed_OpeningFcn(hObject, eventdata, handles, varargin)
        % This function has no output args, see OutputFcn.
        % hObject    handle to figure
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)
        % varargin   command line arguments to dct_embed (see VARARGIN)

        % Choose default command line output for dct_embed
        handles.output = hObject;

        % Update handles structure
        guidata(hObject, handles);

        % UIWAIT makes dct_embed wait for user response (see UIRESUME)
        % uiwait(handles.figure1);

        %load the original image
        attack = get_root_data('attack');
        switch attack
            case 'yes'
                 im_original = get_root_data('plot_watermarked');       %read the image in
            otherwise
                im_original = get_root_data('plot_original');       %read the image in
        end
        
        
        axes(handles.origIm);                               %show the image in the axes 'origIm'
        imshow(im_original);                                %show the image
        axis equal;
        axis tight;
        axis off;

        %hide the unused axes
        set(handles.watIm,'Visible','off');
        set(handles.dct_image,'Visible','off');
        set(handles.dct_block,'Visible','off');
        set(handles.watermark,'Visible','off');
        set(handles.wat_block,'Visible','off');

        if (get(handles.check_fit,'Value') == 1.0)
        switch attack
            case 'yes'
                 cover_work = get_root_data('working_watermarked');       %read the image in
            otherwise
                 cover_work = get_root_data('working_original');       %read the image in
        end    
            
        %determine size of cover work
        Mc=size(cover_work,1);         %Height
        Nc=size(cover_work,2);         %Width

        %initialise the variables
        im_dct = zeros(Mc,Nc);
        blocksize = 8;

        %perform DCT transform on the cover work - block by block
        for i = 1:(Mc/blocksize)
            for j = 1:(Nc/blocksize)
                im_dct(i*blocksize-blocksize+1:i*blocksize,j*blocksize-blocksize+1:j*blocksize) = dct2(cover_work(i*blocksize-blocksize+1:i*blocksize,j*blocksize-blocksize+1:j*blocksize));
            end
        end

        %reduce the pixel values to [0 255]
        [min,max] = get_range(im_dct,Mc,Nc);
        image_dct_dbl = double( (im_dct-min)./(max-min) );
        
        %calculate the average of all pixels in a block except the DC coefficient
        sum = 0;
        for i = 1:blocksize
            for j = 1:blocksize
                sum = sum + image_dct_dbl(i,j);
            end
        end
        sum = sum - image_dct_dbl(1,1);
        average = sum/(blocksize*blocksize -1);

        %calculate the standard deviation of all pixels in a block except the DC
        %coefficient
        variantie = 0;
        for i = 1:blocksize
            for j = 1:blocksize
                variantie = variantie + (image_dct_dbl(i,j)-average)*(image_dct_dbl(i,j)-average);
            end
        end
        variantie = variantie - (image_dct_dbl(1,1)-average)*(image_dct_dbl(1,1)-average);
        variantie = variantie/(blocksize*blocksize-1);
        std_afw = sqrt(variantie);

        axes(handles.dct_image);                                        %show the image in the axes 'dct_image'
        imshow(image_dct_dbl,[average-4*std_afw average+4*std_afw]);    %show the image
        axis equal;
        axis tight;
        axis off;

        axes(handles.dct_block);                                                                    %show the image in the axes 'dct_block'
        imshow(image_dct_dbl(1:blocksize,1:blocksize),[average-4*std_afw average+4*std_afw]);       %show the image
        axis equal;
        axis tight;
        axis off;

        else

        switch attack
            case 'yes'
                 cover_work = get_root_data('working_watermarked');       %read the image in
            otherwise
                 cover_work = get_root_data('working_original');       %read the image in
        end 

        %determine size of cover work
        Mc=size(cover_work,1);         %Height
        Nc=size(cover_work,2);         %Width

        %initialise the variables
        im_dct = zeros(Mc,Nc);
        blocksize = 8;

        %perform DCT transform on the cover work - block by block
        for i = 1:(Mc/blocksize)
            for j = 1:(Nc/blocksize)
                im_dct(i*blocksize-blocksize+1:i*blocksize,j*blocksize-blocksize+1:j*blocksize) = dct2(cover_work(i*blocksize-blocksize+1:i*blocksize,j*blocksize-blocksize+1:j*blocksize));
            end
            workbar(i/(Mc/blocksize),'Performing DCT Transform...','Progress');
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

        end

function varargout = dct_embed_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in check_fit.
function check_fit_Callback(hObject, eventdata, handles)

%% DCT components
function check_low_Callback(hObject, eventdata, handles)
function check_mid_Callback(hObject, eventdata, handles)
function check_high_Callback(hObject, eventdata, handles)

%% Embedding strength
function strength_Callback(hObject, eventdata, handles)
        
        set(handles.text14,'String',round(get(handles.strength,'Value')));

function strength_CreateFcn(hObject, eventdata, handles)
        if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor',[.9 .9 .9]);
        end


%% Button Add
function add_btn_Callback(hObject, eventdata, handles)
        
        if (get(handles.check_fit,'Value') == 1.0)

        attack = get_root_data('attack');
        switch attack
            case 'yes'
                 cover_work = get_root_data('working_watermarked');       %read the image in
            otherwise
                 cover_work = get_root_data('working_original');       %read the image in
        end; 
        
        %determine size of cover work
        Mc=size(cover_work,1);         %Height
        Nc=size(cover_work,2);         %Width

        %initialise the variables
        im_dct = zeros(Mc,Nc);
        blocksize = 8;

        %perform DCT transform on the cover work - block by block
        for i = 1:(Mc/blocksize)
            for j = 1:(Nc/blocksize)
                im_dct(i*blocksize-blocksize+1:i*blocksize,j*blocksize-blocksize+1:j*blocksize) = dct2(cover_work(i*blocksize-blocksize+1:i*blocksize,j*blocksize-blocksize+1:j*blocksize));
            end
        end

        %reduce the pixel values to [0 255]
        [min,max] = get_range(im_dct,Mc,Nc);
        image_dct_dbl = double( (im_dct-min)./(max-min) );
        image_dct_int = uint8(image_dct_dbl.*255);

        %calculate the average of all pixels in a block except the DC coefficient
        sum = 0;
        for i = 1:blocksize
            for j = 1:blocksize
                sum = sum + image_dct_dbl(i,j);
            end
        end
        sum = sum - image_dct_dbl(1,1);
        average = sum/(blocksize*blocksize -1);

        %calculate the standard deviation of all pixels in a block except the DC
        %coefficient
        variantie = 0;
        for i = 1:blocksize
            for j = 1:blocksize
                variantie = variantie + (image_dct_dbl(i,j)-average)*(image_dct_dbl(i,j)-average);
            end
        end
        variantie = variantie - (image_dct_dbl(1,1)-average)*(image_dct_dbl(1,1)-average);
        variantie = variantie/(blocksize*blocksize-1);
        std_afw = sqrt(variantie);

        axes(handles.dct_image);                                        %show the image in the axes 'dct_image'
        imshow(image_dct_dbl,[average-4*std_afw average+4*std_afw]);    %show the image
        axis equal;
        axis tight;
        axis off;

        axes(handles.dct_block);                                                                    %show the image in the axes 'dct_block'
        imshow(image_dct_dbl(1:blocksize,1:blocksize),[average-4*std_afw average+4*std_afw]);       %show the image
        axis equal;
        axis tight;
        axis off;

        attack = get_root_data('attack');
        switch attack
            case 'no'
                type_key = get_root_data('chosen_key');
                switch type_key
                    case 'text'
                        key = get_root_data('chosen_key_text');

                    case 'imag'
                        key = get_root_data('chosen_key_image');
                end;
            otherwise
                type_key = get_root_data('chosen_key');
                switch type_key
                    case 'text'
                        key = get_root_data('chosen_key_text_attack');

                    case 'imag'
                        key = get_root_data('chosen_key_image_attack');
                end;
        end

        switch attack
            case 'no'
                type = get_root_data('chosen_message');
                switch type
                    case 'text'
                        message = get_root_data('chosen_message_text');
                    case 'imag'
                        message = get_root_data('chosen_message_image');
                end;
            otherwise
                type = get_root_data('chosen_message');
                switch type
                    case 'text'
                        message = get_root_data('chosen_message_text_attack');
                    case 'imag'
                        message = get_root_data('chosen_message_image_attack');
                end;
        end

        %read in the selected frequency coefficients
        if (get(handles.check_low,'Value') == 1.0)
            if(get(handles.check_mid,'Value') == 1.0)
                if(get(handles.check_high,'Value') == 1.0)
                    lmh = 111;
                else
                    lmh = 110;
                end
            elseif(get(handles.check_high,'Value') == 1.0)
                lmh = 101;
            else
                lmh = 100;
            end
        else
            if(get(handles.check_mid,'Value') == 1.0)
                if(get(handles.check_high,'Value') == 1.0)
                    lmh = 011;
                else
                    lmh = 010;
                end
            elseif(get(handles.check_high,'Value') == 1.0)
                lmh = 001;
            else
                lmh = 000;
            end
        end

        %make the watermark with blocksize = 8
        watermark = make_watermark_dct(8,image_dct_int,message,type,key,type_key,lmh);

        axes(handles.watermark);                                    %show the image in the axes 'watermark'
        imshow(watermark(1:blocksize,1:blocksize),[-1 1]);          %show the image
        axis equal;
        axis tight;
        axis off;

        %read in the embedding strength
        k = round(get(handles.strength,'Value'));

        watermarked_block = double(image_dct_int(1:blocksize,1:blocksize)) + k*watermark(1:blocksize,1:blocksize);

        %calculate the average of all pixels in a block except the DC coefficient 
        sum = 0;
        for i = 1:blocksize
            for j = 1:blocksize
                sum = sum + watermarked_block(i,j);
            end
        end
        sum = sum - watermarked_block(1,1);
        average = sum/(blocksize*blocksize -1);

        axes(handles.wat_block);                                    %show the image in the axes 'wat_block'
        imshow(watermarked_block,[average-k average+k]);            %show the image
        axis equal;
        axis tight;
        axis off;

        else

        attack = get_root_data('attack');
        switch attack
            case 'yes'
                 cover_work = get_root_data('working_watermarked');       %read the image in
            otherwise
                 cover_work = get_root_data('working_original');       %read the image in
        end; 
        %determine size of cover work
        Mc=size(cover_work,1);         %Height
        Nc=size(cover_work,2);         %Width

        %initialise the variables
        im_dct = zeros(Mc,Nc);
        blocksize = 8;

        %perform DCT transform on the cover work - block by block
        for i = 1:(Mc/blocksize)
            for j = 1:(Nc/blocksize)
                im_dct(i*blocksize-blocksize+1:i*blocksize,j*blocksize-blocksize+1:j*blocksize) = dct2(cover_work(i*blocksize-blocksize+1:i*blocksize,j*blocksize-blocksize+1:j*blocksize));
            end
        end

        %reduce the pixel values to [0 255]
        [min,max] = get_range(im_dct,Mc,Nc);
        image_dct_dbl = double( (im_dct-min)./(max-min) );
        image_dct_int = uint8(image_dct_dbl.*255);

        axes(handles.dct_image);                                      %show the image in the axes 'dct_image'
        imshow(image_dct_int,[0 255]);                                %show the image
        axis equal;
        axis tight;
        axis off;

        axes(handles.dct_block);                                      %show the image in the axes 'dct_block'
        imshow(image_dct_int(1:blocksize,1:blocksize),[0 255]);       %show the image
        axis equal;
        axis tight;
        axis off;

        attack = get_root_data('attack');
        switch attack
            case 'no'
                type_key = get_root_data('chosen_key');
                switch type_key
                    case 'text'
                        key = get_root_data('chosen_key_text');

                    case 'imag'
                        key = get_root_data('chosen_key_image');
                end;
            otherwise
                type_key = get_root_data('chosen_key');
                switch type_key
                    case 'text'
                        key = get_root_data('chosen_key_text_attack');

                    case 'imag'
                        key = get_root_data('chosen_key_image_attack');
                end;
        end

        switch attack
            case 'no'
                type = get_root_data('chosen_message');
                switch type
                    case 'text'
                        message = get_root_data('chosen_message_text');
                    case 'imag'
                        message = get_root_data('chosen_message_image');
                end;
            otherwise
                type = get_root_data('chosen_message');
                switch type
                    case 'text'
                        message = get_root_data('chosen_message_text_attack');
                    case 'imag'
                        message = get_root_data('chosen_message_image_attack');
                end;
        end

        %read the selected frequency components in
        if (get(handles.check_low,'Value') == 1.0)
            if(get(handles.check_mid,'Value') == 1.0)
                if(get(handles.check_high,'Value') == 1.0)
                    lmh = 111;
                else
                    lmh = 110;
                end
            elseif(get(handles.check_high,'Value') == 1.0)
                lmh = 101;
            else
                lmh = 100;
            end
        else
            if(get(handles.check_mid,'Value') == 1.0)
                if(get(handles.check_high,'Value') == 1.0)
                    lmh = 011;
                else
                    lmh = 010;
                end
            elseif(get(handles.check_high,'Value') == 1.0)
                lmh = 001;
            else
                lmh = 000;
            end
        end

        %make the watermark with blocksize = 8
        watermark = make_watermark_dct(8,image_dct_int,message,type,key,type_key,lmh);

        axes(handles.watermark);                                    %show the image in the axes 'watermark'
        imshow(watermark(1:blocksize,1:blocksize),[-1 1]);          %show the image
        axis equal;
        axis tight;
        axis off;

        %read in the embedding strength
        k = round(get(handles.strength,'Value'));

        %construct the watermarked block
        watermarked_block = double(image_dct_int(1:blocksize,1:blocksize)) + k*watermark(1:blocksize,1:blocksize);

        axes(handles.wat_block);                                    %show the image in the axes 'wat_block'
        imshow(watermarked_block,[0 255]);                          %show the image
        axis equal;
        axis tight;
        axis off;

        end

%% Button Embed
function embed_btn_Callback(hObject, eventdata, handles)
        
        attack = get_root_data('attack');
        switch attack
            case 'yes'
                 cover_work = get_root_data('working_watermarked');       %read the image in
            otherwise
                 cover_work = get_root_data('working_original');       %read the image in
        end;
        %determine size of cover work
        Mc=size(cover_work,1);         %Height
        Nc=size(cover_work,2);         %Width

        %initialise the variables
        im_dct = zeros(Mc,Nc);
        blocksize = 8;

        %perform DCT transform on the cover work - block by block
        for i = 1:(Mc/blocksize)
            for j = 1:(Nc/blocksize)
                im_dct(i*blocksize-blocksize+1:i*blocksize,j*blocksize-blocksize+1:j*blocksize) = dct2(cover_work(i*blocksize-blocksize+1:i*blocksize,j*blocksize-blocksize+1:j*blocksize));
            end
        end

        attack = get_root_data('attack');
        switch attack
            case 'no'
                type_key = get_root_data('chosen_key');
                switch type_key
                    case 'text'
                        key = get_root_data('chosen_key_text');

                    case 'imag'
                        key = get_root_data('chosen_key_image');
                end;
            otherwise
                type_key = get_root_data('chosen_key');
                switch type_key
                    case 'text'
                        key = get_root_data('chosen_key_text_attack');

                    case 'imag'
                        key = get_root_data('chosen_key_image_attack');
                end;
        end

        switch attack
            case 'no'
                type = get_root_data('chosen_message');
                switch type
                    case 'text'
                        message = get_root_data('chosen_message_text');
                    case 'imag'
                        message = get_root_data('chosen_message_image');
                end;
            otherwise
                type = get_root_data('chosen_message');
                switch type
                    case 'text'
                        message = get_root_data('chosen_message_text_attack');
                    case 'imag'
                        message = get_root_data('chosen_message_image_attack');
                end;
        end

        %read in the selected frequency coefficients
        if (get(handles.check_low,'Value') == 1.0)
            if(get(handles.check_mid,'Value') == 1.0)
                if(get(handles.check_high,'Value') == 1.0)
                    lmh = 111;
                else
                    lmh = 110;
                end
            elseif(get(handles.check_high,'Value') == 1.0)
                lmh = 101;
            else
                lmh = 100;
            end
        else
            if(get(handles.check_mid,'Value') == 1.0)
                if(get(handles.check_high,'Value') == 1.0)
                    lmh = 011;
                else
                    lmh = 010;
                end
            elseif(get(handles.check_high,'Value') == 1.0)
                lmh = 001;
            else
                lmh = 000;
            end
        end

        %make the watermark with blocksize = 8
        watermark = make_watermark_dct(8,im_dct,message,type,key,type_key,lmh);

        %read in the embedding strength
        k = round(get(handles.strength,'Value'));

        %wrtie the frequency components to file for use by detector
        set_root_data(handles,'dct_components',lmh);

        watermarked_dct_image = double(im_dct) + k*watermark;

        %perform IDCT transform on the watermarked DCT image - block by block
        for i = 1:(Mc/blocksize)
            for j = 1:(Nc/blocksize)
                watermarked_image(i*blocksize-blocksize+1:i*blocksize,j*blocksize-blocksize+1:j*blocksize) = idct2(watermarked_dct_image(i*blocksize-blocksize+1:i*blocksize,j*blocksize-blocksize+1:j*blocksize));
            end
            workbar(i/(Mc/blocksize),'Performing IDCT Transform','Progress');
        end

        %reduce the pixel values to the range [0,255]
        [min,max] = get_range(watermarked_image,Mc,Nc);
        watermarked_image = double( watermarked_image./max );
        watermarked_image_int = uint8(watermarked_image.*255);

        set_root_data(handles,'temp',watermarked_image_int);

        rgb_watermarked = recontruct_from_working_image_for_plotting(watermarked_image_int);

        %calculate the psnr
        psnr_value = PSNR(double(cover_work),double(watermarked_image_int));
        set(handles.edit5,'String',psnr_value);

        axes(handles.watIm);                                        %show the image in the axes 'watIm'
        imshow(rgb_watermarked,[]);                                 %show the image
        axis equal;
        axis tight;
        axis off;

%% PSNR
function edit5_Callback(hObject, eventdata, handles)

function edit5_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end


%% Get range
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
        
%% button done
function pushbutton8_Callback(hObject, eventdata, handles)

        watermarked_image = get_root_data('temp');
        rgb_watermarked = recontruct_from_working_image_for_gui(watermarked_image);

        graph = 'watermarked';
        close;
        fhupdate_axes(graph,rgb_watermarked);

%% Info
function pushbutton_dct_info_Callback(hObject, eventdata, handles)

        msgbox('In the DCT watermarking tehcnique, the watermark is added to the frequency components after the DCT tranform. In this GUI, you can adjust the embedding strength of the watermark.','Help','help');

