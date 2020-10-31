function varargout = QIM_embed(varargin)
% QIM_EMBED M-file for QIM_embed.fig
%      QIM_EMBED, by itself, creates a new QIM_EMBED or raises the existing
%      singleton*.
%
%      H = QIM_EMBED returns the handle to a new QIM_EMBED or the handle to
%      the existing singleton*.
%
%      QIM_EMBED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in QIM_EMBED.M with the given input arguments.
%
%      QIM_EMBED('Property','Value',...) creates a new QIM_EMBED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before QIM_embed_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to QIM_embed_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help QIM_embed

% Last Modified by GUIDE v2.5 02-Nov-2007 11:40:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @QIM_embed_OpeningFcn, ...
                   'gui_OutputFcn',  @QIM_embed_OutputFcn, ...
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


% --- Executes just before QIM_embed is made visible.
function QIM_embed_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to QIM_embed (see VARARGIN)

% Choose default command line output for QIM_embed
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes QIM_embed wait for user response (see UIRESUME)
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
        set(handles.orig_block,'Visible','off');
        set(handles.dither_block,'Visible','off');
        set(handles.quant_block,'Visible','off');
        set(handles.wat_block,'Visible','off');
        set(handles.watIm,'Visible','off');
        

% --- Outputs from this function are returned to the command line.
function varargout = QIM_embed_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function delta_Callback(hObject, eventdata, handles)
% hObject    handle to delta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

        delta = round(get(handles.delta,'Value')); 
        set(handles.text9,'String',delta);

% --- Executes during object creation, after setting all properties.
function delta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in embed_btn.
function embed_btn_Callback(hObject, eventdata, handles)
% hObject    handle to embed_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

        %protection against false delta value of 0 
        if(round(get(handles.delta,'Value')) == 0)
            delta = 1;
        else
            delta = round(get(handles.delta,'Value'));           %set the size of one block in the cover work to be used for each bit in watermark
        end
        
        set_root_data(handles,'delta',delta);

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

        %read in the cover work
        cover_work = double(get_root_data('working_original'));

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
        
        [watermarked_image, orig_block, dither_block, quant_block, wat_block] = make_watermark_qim(delta, cover_work, message, type, key, type_key);
        
        psnr_value = PSNR(double(cover_work),double(watermarked_image));
        set(handles.text2,'String',psnr_value);
        
        watermarked_image_int = uint8(watermarked_image);
        set_root_data(handles,'temp',watermarked_image_int);   
        rgb_watermarked = recontruct_from_working_image_for_plotting(watermarked_image_int);

        axes(handles.watIm);                                %show the image in the axes 'watIm'
        imshow(rgb_watermarked);                        %show the image
        axis equal;
        axis tight;
        axis off;
        
% --- Executes on button press in show_btn.
function show_btn_Callback(hObject, eventdata, handles)
% hObject    handle to show_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

        %protection against false delta value of 0 
        if(round(get(handles.delta,'Value')) == 0)
            delta = 1;
        else
            delta = round(get(handles.delta,'Value'));           %set the size of one block in the cover work to be used for each bit in watermark
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

        %read in the cover work
        cover_work = double(get_root_data('working_original'));

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
        
        [watermarked_image, orig_block, dither_block, quant_block, wat_block] = make_watermark_qim(delta, cover_work, message, type, key, type_key);
        
        axes(handles.orig_block);
        imshow(orig_block,[min(orig_block)-5 max(orig_block)+5]);
        axis equal;
        axis tight;
        axis off;
        
        axes(handles.dither_block);
        imshow(dither_block);
        axis equal;
        axis tight;
        axis off;
        
        axes(handles.quant_block);
        imshow(quant_block,[min(quant_block)-5 max(quant_block)+5]);
        axis equal;
        axis tight;
        axis off;
        
        axes(handles.wat_block);
        imshow(wat_block,[min(wat_block)-5 max(wat_block)+5]);
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
        
        