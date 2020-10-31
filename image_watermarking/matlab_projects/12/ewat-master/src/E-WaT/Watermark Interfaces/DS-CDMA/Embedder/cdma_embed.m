function varargout = cdma_embed(varargin)
% CDMA_EMBED M-file for cdma_embed.fig
%      CDMA_EMBED, by itself, creates a new CDMA_EMBED or raises the existing
%      singleton*.
%
%      H = CDMA_EMBED returns the handle to a new CDMA_EMBED or the handle to
%      the existing singleton*.
%
%      CDMA_EMBED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CDMA_EMBED.M with the given input arguments.
%
%      CDMA_EMBED('Property','Value',...) creates a new CDMA_EMBED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cdma_embed_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cdma_embed_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cdma_embed

% Last Modified by GUIDE v2.5 10-Jan-2008 11:53:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cdma_embed_OpeningFcn, ...
                   'gui_OutputFcn',  @cdma_embed_OutputFcn, ...
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


% --- Executes just before cdma_embed is made visible.
function cdma_embed_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cdma_embed (see VARARGIN)

% Choose default command line output for cdma_embed
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cdma_embed wait for user response (see UIRESUME)
% uiwait(handles.figure1);

        %load the image
        
        attack = get_root_data('attack');
        switch attack
            case 'yes'        
                im_plot = get_root_data('plot_watermarked');
            otherwise
                im_plot = get_root_data('plot_original');
        end;
        
        axes(handles.origIm);
        imshow(im_plot);   
        axis equal;
        axis tight;
        axis off;

        %Hide the unused axes
        set(handles.rpIm,'Visible','off');
        set(handles.patIm,'Visible','off');
        set(handles.watIm,'Visible','off');

        attack = get_root_data('attack');
        switch attack
            case 'no'
                messageType = get_root_data('chosen_message');
                switch messageType
                    case 'text'
                        message = get_root_data('chosen_message_text');
                    case 'imag'
                        message = get_root_data('chosen_message_image');
                end;
            otherwise
                messageType = get_root_data('chosen_message');
                switch messageType
                    case 'text'
                        message = get_root_data('chosen_message_text_attack');
                    case 'imag'
                        message = get_root_data('chosen_message_image_attack');
                end;
        end;
        
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
        
        cover_work = double(get_root_data('working_original'));
        
        [watermark, random_noise_pattern] = make_watermark_cdma(cover_work,message,messageType,key,type_key);
        
        axes(handles.rpIm);                                             %show the image in the axes 'rpIm'
        imshow(random_noise_pattern,[-1 1]);                            %show the image
        axis equal;
        axis tight;
        axis off;
        
        axes(handles.patIm);                                            %show the image in the axes 'patIm'
        imshow(watermark,[min(min(watermark)) max(max(watermark))]);    %show the image
        axis equal;
        axis tight;
        axis off;

% --- Outputs from this function are returned to the command line.
function varargout = cdma_embed_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in embed_btn.
function embed_btn_Callback(hObject, eventdata, handles)
% hObject    handle to embed_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

        attack = get_root_data('attack');
        switch attack
            case 'no'
                messageType = get_root_data('chosen_message');
                switch messageType
                    case 'text'
                        message = get_root_data('chosen_message_text');
                    case 'imag'
                        message = get_root_data('chosen_message_image');
                end;
            otherwise
                messageType = get_root_data('chosen_message');
                switch messageType
                    case 'text'
                        message = get_root_data('chosen_message_text_attack');
                    case 'imag'
                        message = get_root_data('chosen_message_image_attack');
                end;
        end;
        
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
        
        cover_work = double(get_root_data('working_original'));
        
        [watermark, random_noise_pattern] = make_watermark_cdma(cover_work,message,messageType,key,type_key);
        
        % add watermark to the cover work 
        watermarked_image=uint8(cover_work + watermark);

        %calculate the psnr
        psnr_value = PSNR(double(cover_work),double(watermarked_image));
        set(handles.text_psnr,'String',psnr_value);

        set_root_data(handles,'temp',watermarked_image);

        rgb_watermarked = recontruct_from_working_image_for_plotting(watermarked_image);

        axes(handles.watIm);                                %show the image in the axes 'watIm'
        imshow(rgb_watermarked);                            %show the image
        axis equal;
        axis tight;
        axis off;

% --- Executes on button press in done_btn.
function done_btn_Callback(hObject, eventdata, handles)
% hObject    handle to done_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

        watermarked_image = get_root_data('temp');
        rgb_watermarked = recontruct_from_working_image_for_gui(watermarked_image);

        graph = 'watermarked';
        close;
        fhupdate_axes(graph,rgb_watermarked);
