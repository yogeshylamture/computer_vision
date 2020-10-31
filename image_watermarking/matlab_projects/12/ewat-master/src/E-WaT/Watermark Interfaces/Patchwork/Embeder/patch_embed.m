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
%patch_embed: This is the patch for embedding a watermark

function varargout = patch_embed(varargin)
% PATCH_EMBED M-file for patch_embed.fig
%      PATCH_EMBED, by itself, creates a new PATCH_EMBED or raises the existing
%      singleton*.
%
%      H = PATCH_EMBED returns the handle to a new PATCH_EMBED or the handle to
%      the existing singleton*.
%
%      PATCH_EMBED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PATCH_EMBED.M with the given input arguments.
%
%      PATCH_EMBED('Property','Value',...) creates a new PATCH_EMBED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before patch_embed_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to patch_embed_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help patch_embed

% Last Modified by GUIDE v2.5 04-Nov-2007 12:54:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @patch_embed_OpeningFcn, ...
                   'gui_OutputFcn',  @patch_embed_OutputFcn, ...
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


% --- Executes just before patch_embed is made visible.
function patch_embed_OpeningFcn(hObject, eventdata, handles, varargin)
       
        % Choose default command line output for patch_embed
        handles.output = hObject;

        % Update handles structure
        guidata(hObject, handles);

        % UIWAIT makes patch_embed wait for user response (see UIRESUME)
        % uiwait(handles.figure1);

        %read the image in
        attack = get_root_data('attack');

        switch attack
            case 'yes'
                im_original = get_root_data('plot_watermarked');       
            otherwise
                im_original = get_root_data('plot_original');          
        end
        
        %show the original image
        axes(handles.origIm);                               
        imshow(im_original);                                
        axis equal;
        axis tight;
        axis off;

        %Hide the unused axes
        set(handles.watermark,'Visible','off');
        set(handles.watIm,'Visible','off');

        %Read in the blocksize
        blocksize=round(get(handles.blocksize,'Value'));           

        %Read in the choice for one bit or a complete message
        message_bit = get(handles.message_bit,'Value');

        %read in the cover work
        switch attack
            case 'yes'
                cover_work = get_root_data('working_watermarked');       
            otherwise
                cover_work = get_root_data('working_original');          
        end
        
        %call the function that returns the watermark
        [watermark_mask,sequence] = make_watermark_patch(blocksize,message_bit,cover_work);      

        %show the image in the axes 'watermark'
        axes(handles.watermark);                            
        imshow(watermark_mask,[-1 1]);                      
        axis equal;
        axis tight;
        axis off;

function varargout = patch_embed_OutputFcn(hObject, eventdata, handles) 
        varargout{1} = handles.output;

function blocksize_Callback(hObject, eventdata, handles)
        
        %Get the size of one block in the cover work to be used for each
        %bit in watermark
        blocksize=round(get(handles.blocksize,'Value'));           
        set(handles.text8,'String',num2str(blocksize));

        %Read in the choice for one bit or a complete message
        message_bit = get(handles.message_bit,'Value');

        %read in the cover work
        attack =get_root_data('attack');
        switch attack
            case 'yes'
                 cover_work = get_root_data('working_watermarked');       %read the image in
            otherwise
                cover_work = get_root_data('working_original');       %read the image in
        end

        %call the function that returns the watermark
        [watermark_mask,sequence] = make_watermark_patch(blocksize,message_bit,cover_work);

        axes(handles.watermark);                            
        imshow(watermark_mask,[-1 1]);                      
        axis equal;
        axis tight;
        axis off;

function blocksize_CreateFcn(hObject, eventdata, handles)

    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end


%% Button embed
function embed_btn_Callback(hObject, eventdata, handles)
        
        %get the embedding strength
        strength = round(get(handles.k,'value'));                  

        %get the size of one block in the cover work to be used for each
        %bit in watermark
        blocksize=round(get(handles.blocksize,'Value'));       

        %Get the choice for one bit or a complete message
        message_bit = get(handles.message_bit,'Value');

        %read in the cover work
        attack = get_root_data('attack');
        switch attack
            case 'yes'
                cover_work = get_root_data('working_watermarked');       %read the image in
            otherwise
                cover_work = get_root_data('working_original');       %read the image in
        end
        
        %call the function that returns the watermark
        [watermark_mask,sequence] = make_watermark_patch(blocksize,message_bit,cover_work);      

        %Apply the watermark mask to the original cover work
        watermarked_image = double(cover_work) + strength*watermark_mask;
        watermarked_image_int = uint8(watermarked_image);

        %calculate the psnr
        psnr_value = PSNR(double(cover_work),double(watermarked_image_int));
        set(handles.edit2,'String',psnr_value);

        set_root_data(handles,'temp',watermarked_image_int);

        %Write the parameters to files
        set_root_data(handles,'patch_k',strength);
        set_root_data(handles,'patch_blocksize',blocksize);
        set_root_data(handles,'message_bit',message_bit);
        set_root_data(handles,'sequence',sequence);
        rgb_watermarked = recontruct_from_working_image_for_plotting(watermarked_image_int);

        %show the image in the axes 'watIm'
        axes(handles.watIm);                                
        imshow(rgb_watermarked);                            
        axis equal;
        axis tight;
        axis off;


%% Slider update
function k_Callback(hObject, eventdata, handles)
        
        %Get the embedding strength set by the user
        strength = round(get(handles.k,'value'));                  
        set(handles.text7,'String',num2str(strength));

        %set the size of one block in the cover work to be used for each
        %bit in watermark
        blocksize=round(get(handles.blocksize,'Value'));       

        %Get the choice for one bit or a complete message
        message_bit = get(handles.message_bit,'Value');

        %read in the cover work
        attack = get_root_data('attack');
        switch attack
            case 'yes'
                 cover_work = get_root_data('working_watermarked');       %read the image in
            otherwise
                cover_work = get_root_data('working_original');       %read the image in
        end
        
        %call the function that returns the watermark
        [watermark_mask,sequence] = make_watermark_patch(blocksize,message_bit,cover_work);      

        %Apply the watermark mask to the original cover work
        watermarked_image = double(cover_work) + strength*watermark_mask;
        watermarked_image_int = uint8(watermarked_image);

        %calculate the psnr
        psnr_value = PSNR(double(cover_work),double(watermarked_image_int));
        set(handles.edit2,'String',psnr_value);

        set_root_data(handles,'temp',watermarked_image_int);

        %Write the parameters to files
        set_root_data(handles,'patch_k',strength);
        set_root_data(handles,'patch_blocksize',blocksize);
        set_root_data(handles,'message_bit',message_bit);
        set_root_data(handles,'sequence',sequence);

        rgb_watermarked = recontruct_from_working_image_for_plotting(watermarked_image_int);

        %show the image in the axes 'watIm'
        axes(handles.watIm);                                
        imshow(rgb_watermarked);                            
        axis equal;
        axis tight;
        axis off;

%%
function k_CreateFcn(hObject, eventdata, handles)
        
        if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor',[.9 .9 .9]);
        end


%% Button done
function done_btn_Callback(hObject, eventdata, handles)

        watermarked_image = get_root_data('temp');
        rgb_watermarked = recontruct_from_working_image_for_gui(watermarked_image);

        graph = 'watermarked';
        close;
        fhupdate_axes(graph,rgb_watermarked);
%% PSNR 
function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)

        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
%% Info
function pushbutton_patch_info_Callback(hObject, eventdata, handles)

        msgbox('In this GUI, you can configure the watermark. You can set the blocksize en the percentage of pixels used to patch the selected image. You can also adjust the embedding strength.','Help','help');

        
% --- Executes on button press in message_bit.
function message_bit_Callback(hObject, eventdata, handles)
% hObject    handle to message_bit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of message_bit

        %set the size of one block in the cover work to be used for each
        %bit in watermark
        blocksize=round(get(handles.blocksize,'Value'));           
        set(handles.text8,'String',num2str(blocksize));

        %Get the choice for one bit or a complete message
        message_bit = get(handles.message_bit,'Value');

        %read in the cover work
        attack =get_root_data('attack');
        switch attack
            case 'yes'
                 cover_work = get_root_data('working_watermarked');       %read the image in
            otherwise
                cover_work = get_root_data('working_original');       %read the image in
        end

        %call the function that returns the watermark
        [watermark_mask,sequence] = make_watermark_patch(blocksize,message_bit,cover_work);
        
        %show the watermark
        axes(handles.watermark);                            
        imshow(watermark_mask,[-1 1]);                      
        axis equal;
        axis tight;
        axis off;
