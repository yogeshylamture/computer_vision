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
%dwt_embed: This is the dwt gui for embedding the message

function varargout = dwt_embed(varargin)
        % DWT_EMBED M-file for dwt_embed.fig
        %      DWT_EMBED, by itself, creates a new DWT_EMBED or raises the existing
        %      singleton*.
        %
        %      H = DWT_EMBED returns the handle to a new DWT_EMBED or the handle to
        %      the existing singleton*.
        %
        %      DWT_EMBED('CALLBACK',hObject,eventData,handles,...) calls the local
        %      function named CALLBACK in DWT_EMBED.M with the given input arguments.
        %
        %      DWT_EMBED('Property','Value',...) creates a new DWT_EMBED or raises the
        %      existing singleton*.  Starting from the left, property value pairs are
        %      applied to the GUI before dwt_embed_OpeningFunction gets called.  An
        %      unrecognized property name or invalid value makes property application
        %      stop.  All inputs are passed to dwt_embed_OpeningFcn via varargin.
        %
        %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
        %      instance to run (singleton)".
        %
        % See also: GUIDE, GUIDATA, GUIHANDLES

        % Edit the above text to modify the response to help dwt_embed

        % Last Modified by GUIDE v2.5 07-Jun-2007 00:32:49

        % Begin initialization code - DO NOT EDIT
        gui_Singleton = 1;
        gui_State = struct('gui_Name',       mfilename, ...
                           'gui_Singleton',  gui_Singleton, ...
                           'gui_OpeningFcn', @dwt_embed_OpeningFcn, ...
                           'gui_OutputFcn',  @dwt_embed_OutputFcn, ...
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
function dwt_embed_OpeningFcn(hObject, eventdata, handles, varargin)
        
        % Choose default command line output for dwt_embed
        handles.output = hObject;

        % Update handles structure
        guidata(hObject, handles);

        % UIWAIT makes dwt_embed wait for user response (see UIRESUME)
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
        set(handles.dwtIm,'Visible','off');
        set(handles.mesIm,'Visible','off');
        
        switch attack
            case 'yes'
                 cover_work = get_root_data('working_watermarked');       %read the image in
            otherwise
                cover_work = get_root_data('working_original');       %read the image in
        end

        %read the wavelet in from the pop-up menu
        choice = get(handles.popupmenu1,'Value');
        if (choice == 1)
            method = 'db1';
        elseif (choice == 2)
            method = 'bior1.1';
        elseif (choice == 3)
            method = 'rbio1.1';
        else
            method = 'db1';
        end

        %perform DWT transform on the cover work
        [cA1,cH1,cV1,cD1] = dwt2(cover_work,method);
        [cA2,cH2,cV2,cD2] = dwt2(cA1,method);
        [cA3,cH3,cV3,cD3] = dwt2(cA2,method);
        [cA4,cH4,cV4,cD4] = dwt2(cA3,method);
        [cA5,cH5,cV5,cD5] = dwt2(cA4,method);

        %read the level in from the pop-up menu
        level = get(handles.popupmenu2,'Value');

        if (level == 6)
            dwt_level = [cD1,cH1;cV1,[cD2,cH2;cV2,[cD3,cH3;cV3,[cD4,cH4;cV4,[cD5,cH5;cV5,cA5]]]]];
        elseif (level == 5)
            dwt_level = [cD1,cH1;cV1,cA1];
        elseif (level == 4)
            dwt_level = [cD2,cH2;cV2,cA2];
        elseif (level == 3)
            dwt_level = [cD3,cH3;cV3,cA3];
        elseif (level == 2)
            dwt_level = [cD4,cH4;cV4,cA4];
        elseif (level == 1)
            dwt_level = [cD5,cH5;cV5,cA5];
        else
            dwt_level = [cD1,cH1;cV1,[cD2,cH2;cV2,[cD3,cH3;cV3,[cD4,cH4;cV4,[cD5,cH5;cV5,cA5]]]]];
        end

        %display the DWT transformed image
        axes(handles.dwtIm);                                    %show the image in the axes 'dwtIm'
        imshow(dwt_level,[]);                                   %show the image
        axis equal;
        axis tight;
        axis off;

%% Output
function varargout = dwt_embed_OutputFcn(hObject, eventdata, handles) 
        varargout{1} = handles.output;

%% Popupmenu wavelet type
function popupmenu1_Callback(hObject, eventdata, handles)

        attack = get_root_data('attack');
        switch attack
            case 'yes'
                 cover_work = get_root_data('working_watermarked');       %read the image in
            otherwise
                cover_work = get_root_data('working_original');       %read the image in
        end

        %read the wavelet in from the pop-up menu
        choice = get(handles.popupmenu1,'Value');
        if (choice == 1)
            method = 'db1';
        elseif (choice == 2)
            method = 'bior1.1';
        elseif (choice == 3)
            method = 'rbio1.1';
        else
            method = 'db1';
        end

        %perform DWT transform on the cover work
        [cA1,cH1,cV1,cD1] = dwt2(cover_work,method);
        [cA2,cH2,cV2,cD2] = dwt2(cA1,method);
        [cA3,cH3,cV3,cD3] = dwt2(cA2,method);
        [cA4,cH4,cV4,cD4] = dwt2(cA3,method);
        [cA5,cH5,cV5,cD5] = dwt2(cA4,method);

        %read the level in from the pop-up menu
        level = get(handles.popupmenu2,'Value');

        if (level == 6)
            dwt_level = [cD1,cH1;cV1,[cD2,cH2;cV2,[cD3,cH3;cV3,[cD4,cH4;cV4,[cD5,cH5;cV5,cA5]]]]];
        elseif (level == 5)
            dwt_level = [cD1,cH1;cV1,cA1];
        elseif (level == 4)
            dwt_level = [cD2,cH2;cV2,cA2];
        elseif (level == 3)
            dwt_level = [cD3,cH3;cV3,cA3];
        elseif (level == 2)
            dwt_level = [cD4,cH4;cV4,cA4];
        elseif (level == 1)
            dwt_level = [cD5,cH5;cV5,cA5];
        else
            dwt_level = [cD1,cH1;cV1,[cD2,cH2;cV2,[cD3,cH3;cV3,[cD4,cH4;cV4,[cD5,cH5;cV5,cA5]]]]];
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


%% Popupmenu level for transforming
function popupmenu2_Callback(hObject, eventdata, handles)

        attack = get_root_data('attack');
        switch attack
            case 'yes'
                 cover_work = get_root_data('working_watermarked');       %read the image in
            otherwise
                cover_work = get_root_data('working_original');       %read the image in
        end
        
        %read the wavelet in from the pop-up menu
        choice = get(handles.popupmenu1,'Value');
        if (choice == 1)
            method = 'db1';
        elseif (choice == 2)
            method = 'bior1.1';
        elseif (choice == 3)
            method = 'rbio1.1';
        else
            method = 'db1';
        end

        %perform DWT transform on the cover work
        [cA1,cH1,cV1,cD1] = dwt2(cover_work,method);
        [cA2,cH2,cV2,cD2] = dwt2(cA1,method);
        [cA3,cH3,cV3,cD3] = dwt2(cA2,method);
        [cA4,cH4,cV4,cD4] = dwt2(cA3,method);
        [cA5,cH5,cV5,cD5] = dwt2(cA4,method);

        %read the level in from the pop-up menu
        level = get(handles.popupmenu2,'Value');

        if (level == 6)
            dwt_level = [cD1,cH1;cV1,[cD2,cH2;cV2,[cD3,cH3;cV3,[cD4,cH4;cV4,[cD5,cH5;cV5,cA5]]]]];
        elseif (level == 5)
            dwt_level = [cD1,cH1;cV1,cA1];
        elseif (level == 4)
            dwt_level = [cD2,cH2;cV2,cA2];
        elseif (level == 3)
            dwt_level = [cD3,cH3;cV3,cA3];
        elseif (level == 2)
            dwt_level = [cD4,cH4;cV4,cA4];
        elseif (level == 1)
            dwt_level = [cD5,cH5;cV5,cA5];
        else
            dwt_level = [cD1,cH1;cV1,[cD2,cH2;cV2,[cD3,cH3;cV3,[cD4,cH4;cV4,[cD5,cH5;cV5,cA5]]]]];
        end

        %display the DWT transformed image
        axes(handles.dwtIm);                                    %show the image in the axes 'dwtIm'
        imshow(dwt_level,[]);                                   %show the image
        axis equal;
        axis tight;
        axis off;
        
function popupmenu2_CreateFcn(hObject, eventdata, handles)

        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end


%% Button Add message
function add_btn_Callback(hObject, eventdata, handles)
        
        attack = get_root_data('attack');
        switch attack
            case 'yes'
                 cover_work = get_root_data('working_watermarked');       %read the image in
            otherwise
                cover_work = get_root_data('working_original');       %read the image in
        end
        %read the wavelet in from the pop-up menu
        choice = get(handles.popupmenu1,'Value');
        if (choice == 1)
            method = 'db1';
        elseif (choice == 2)
            method = 'bior1.1';
        elseif (choice == 3)
            method = 'rbio1.1';
        else
            method = 'db1';
        end

        %perform DWT transform on the cover work
        [cA1,cH1,cV1,cD1] = dwt2(cover_work,method);
        [cA2,cH2,cV2,cD2] = dwt2(cA1,method);
        [cA3,cH3,cV3,cD3] = dwt2(cA2,method);
        [cA4,cH4,cV4,cD4] = dwt2(cA3,method);
        [cA5,cH5,cV5,cD5] = dwt2(cA4,method);

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

        %read the level in from the pop-up menu
        level = get(handles.popupmenu3,'Value');
        if (level == 1)
            cA = cA2;
            cH = cH2;
            cV = cV2;
            cD = cD2;
            blocksize = 4;
        elseif (level == 2)
            cA = cA3;
            cH = cH3;
            cV = cV3;
            cD = cD3;
            blocksize = 2;
        else
            cA = cA2;
            cH = cH2;
            cV = cV2;
            cD = cD2;
            blocksize = 4;
        end

        %make the watermark
        watermark = make_watermark_dwt(blocksize,cA,message,type,key,type_key);

        %read in the embedding strength
        k = round(get(handles.strength,'Value'));

        %if the checkbox is checked, the watermark will be applied to that
        %component
        if (get(handles.check_a,'Value') == 1.0)
            cAm = cA + k*watermark;
        else
            cAm = cA;
        end
        if (get(handles.check_h,'Value') == 1.0)
            cHm = cH + k*watermark;
        else
            cHm = cH;
        end
        if (get(handles.check_v,'Value') == 1.0)
            cVm = cV + k*watermark;
        else
            cVm = cV;
        end
        if (get(handles.check_d,'Value') == 1.0)
            cDm = cD + k*watermark;
        else
            cDm = cD;
        end

        dwtm = [cDm,cHm;cVm,cAm];

        axes(handles.mesIm);                                   %show the image in the axes 'mesIm'
        imshow(dwtm,[]);                                       %show the image
        axis equal;
        axis tight;
        axis off;


%% DWT decompositions
function check_a_Callback(hObject, eventdata, handles)
function check_h_Callback(hObject, eventdata, handles)
function check_v_Callback(hObject, eventdata, handles)
function check_d_Callback(hObject, eventdata, handles)


%% Popup menu level for watermarking
function popupmenu3_Callback(hObject, eventdata, handles)
 
    
function popupmenu3_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

%% Embedding strength
function strength_Callback(hObject, eventdata, handles)
        %read the embedding strength in
        k = round(get(handles.strength,'Value'));
        set(handles.text9,'String',k);

function strength_CreateFcn(hObject, eventdata, handles)

        if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor',[.9 .9 .9]);
        end

%% Button embed
function embed_btn_Callback(hObject, eventdata, handles)
        attack = get_root_data('attack');
        switch attack
            case 'yes'
                 cover_work = get_root_data('working_watermarked');       %read the image in
            otherwise
                cover_work = get_root_data('working_original');       %read the image in
        end
        %determine size of cover work
        Mc=size(cover_work,1);         %Height
        Nc=size(cover_work,2);         %Width

        %read the wavelet in from the pop-up menu
        choice = get(handles.popupmenu1,'Value');
        if (choice == 1)
            method = 'db1';
        elseif (choice == 2)
            method = 'bior1.1';
        elseif (choice == 3)
            method = 'rbio1.1';
        else
            method = 'db1';
        end

        %write the used method to file for use by detector
        set_root_data(handles,'dwt_method',method);

        %perform DWT transform on the cover work
        [cA1,cH1,cV1,cD1] = dwt2(cover_work,method);
        [cA2,cH2,cV2,cD2] = dwt2(cA1,method);
        [cA3,cH3,cV3,cD3] = dwt2(cA2,method);
        [cA4,cH4,cV4,cD4] = dwt2(cA3,method);
        [cA5,cH5,cV5,cD5] = dwt2(cA4,method);

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

        %read the level in from the pop-up menu
        level = get(handles.popupmenu3,'Value');
        if (level == 1)
            cA = cA2;
            cH = cH2;
            cV = cV2;
            cD = cD2;
            blocksize = 4;
        elseif (level == 2)
            cA = cA3;
            cH = cH3;
            cV = cV3;
            cD = cD3;
            blocksize = 2;
        else
            cA = cA2;
            cH = cH2;
            cV = cV2;
            cD = cD2;
            blocksize = 4;
        end

        set_root_data(handles,'dwt_level',level+1);

        %make the watermark with blocksize = 8
        watermark = make_watermark_dwt(blocksize,cA,message,type,key,type_key);

        %read in the embedding strength
        k = round(get(handles.strength,'Value'));

        %if the checkbox is checked, the watermark will be applied to that
        %component
        if (get(handles.check_a,'Value') == 1.0)
            cAm = cA + k*watermark;
            component = 'a';
        else
            cAm = cA;
        end
        if (get(handles.check_h,'Value') == 1.0)
            cHm = cH + k*watermark;
            component = 'h';
        else
            cHm = cH;
        end
        if (get(handles.check_v,'Value') == 1.0)
            cVm = cV + k*watermark;
            component = 'v';
        else
            cVm = cV;
        end
        if (get(handles.check_d,'Value') == 1.0)
            cDm = cD + k*watermark;
            component = 'd';
        else
            cDm = cD;
        end

        %write the selected component to file
        set_root_data(handles,'dwt_component',component);


        %recompose the watermarked components to an image
        if (level == 1) 
            cA2 = cAm;
            cH2 = cHm;
            cV2 = cVm;
            cD2 = cDm;

            %perform Inverse DWT Transform on the modified components
            cA1 = idwt2(cA2,cH2,cV2,cD2,method);
            watermarked_image = idwt2(cA1,cH1,cV1,cD1,method);

        elseif (level == 2)
            cA3 = cAm;
            cH3 = cHm;
            cV3 = cVm;
            cD3 = cDm;

            %perform Inverse DWT Transform on the modified components
            cA2 = idwt2(cA3,cH3,cV3,cD3,method);
            cA1 = idwt2(cA2,cH2,cV2,cD2,method);
            watermarked_image = idwt2(cA1,cH1,cV1,cD1,method);

        else
            cA2 = cAm;
            cH2 = cHm;
            cV2 = cVm;
            cD2 = cDm;

            %perform Inverse DWT Transform on the modified components
            cA1 = idwt2(cA2,cH2,cV2,cD2,method);
            watermarked_image = idwt2(cA1,cH1,cV1,cD1,method);

        end

        %calculate the psnr
        psnr_value = PSNR(double(cover_work),double(watermarked_image));
        set(handles.edit5,'String',psnr_value);

        %transform the range of the watermarked image from [min max] to [0 255]
        [min,max] = get_range(watermarked_image,Mc,Nc);
        watermarked_image_dbl = double( (watermarked_image-min)./(max-min) );
        watermarked_image_int = uint8(watermarked_image_dbl.*255);

        set_root_data(handles,'temp',watermarked_image_int);

        rgb_watermarked = recontruct_from_working_image_for_plotting(watermarked_image_int);

        axes(handles.watIm);                                   %show the image in the axes 'messageIm'
        imshow(rgb_watermarked,[]);                            %show the image
        axis equal;
        axis tight;
        axis off;

%% PSNR
function edit5_Callback(hObject, eventdata, handles)

function edit5_CreateFcn(hObject, eventdata, handles)
        
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end


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

function figure1_DeleteFcn(hObject, eventdata, handles)

%% Button done
function pushbutton15_Callback(hObject, eventdata, handles)

        watermarked_image = get_root_data('temp');
        rgb_watermarked = recontruct_from_working_image_for_gui(watermarked_image);

        graph = 'watermarked';
        close;
        fhupdate_axes(graph,rgb_watermarked);

%% Info
function pushbutton_dwt_info_Callback(hObject, eventdata, handles)

        msgbox('In this GUI, a watermark is added in the DWT domain. You can select the level of DWT and configure in which components the watermark has to be embed. You can also determine the embedding strength.','Help','help');
