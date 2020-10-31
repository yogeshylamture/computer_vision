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
%watermarking: This gui is used as a step between different techniques.

function varargout = watermarking(varargin)
        % WATERMARKING M-file for watermarking.fig
        %      WATERMARKING, by itself, creates a new WATERMARKING or raises the existing
        %      singleton*.
        %
        %      H = WATERMARKING returns the handle to a new WATERMARKING or the handle to
        %      the existing singleton*.
        %
        %      WATERMARKING('CALLBACK',hObject,eventData,handles,...) calls the local
        %      function named CALLBACK in WATERMARKING.M with the given input arguments.
        %
        %      WATERMARKING('Property','Value',...) creates a new WATERMARKING or raises the
        %      existing singleton*.  Starting from the left, property value pairs are
        %      applied to the GUI before watermarking_OpeningFunction gets called.  An
        %      unrecognized property name or invalid value makes property application
        %      stop.  All inputs are passed to watermarking_OpeningFcn via varargin.
        %
        %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
        %      instance to run (singleton)".
        %
        % See also: GUIDE, GUIDATA, GUIHANDLES

        % Edit the above text to modify the response to help watermarking

        % Last Modified by GUIDE v2.5 03-Feb-2008 15:24:35

        % Begin initialization code - DO NOT EDIT
        gui_Singleton = 1;
        gui_State = struct('gui_Name',       mfilename, ...
                           'gui_Singleton',  gui_Singleton, ...
                           'gui_OpeningFcn', @watermarking_OpeningFcn, ...
                           'gui_OutputFcn',  @watermarking_OutputFcn, ...
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


% --- Executes just before watermarking is made visible.
function watermarking_OpeningFcn(hObject, eventdata, handles, varargin)
        handles.output = hObject;

        % Update handles structure
        guidata(hObject, handles);

        % UIWAIT makes watermarking wait for user response (see UIRESUME)
        % uiwait(handles.figure1);

        global image_file;
        global mimage_file;

        image_file = 'key.jpg';
        key = imread(image_file);
        set(handles.keyIm,'Visible','on');
        axes(handles.keyIm);
        imshow(key);
        axis off;

        mimage_file = 'copyright.bmp';
        message = imread(mimage_file);
        set(handles.messageIm,'Visible','on');
        axes(handles.messageIm);
        imshow(message);
        axis off;


        attack = get_root_data('attack');
        switch attack
            case 'yes'        
                im_original = get_root_data('plot_watermarked');
            otherwise
                im_original = get_root_data('plot_original');
        end;
        axes(handles.origIm);
        imshow(im_original);
        axis equal;
        axis tight;
        axis off;

        set(handles.edit1,'Visible','off');
        set(handles.edit2,'Visible','off');
        set(handles.browse_btn1,'Visible','on');
        set(handles.browse_btn2,'Visible','on');
        
%% Calculating capacity

        [H W D] = size(im_original);

        capLSBBITS = floor(H/2)*floor(W/2);
        capLSBCHARS = floor(H/16)*floor(W/21);
        capPatchworkBITS = floor(H/4)*floor(W/4)/2;
        capPatchworkCHARS = floor(H/4)*floor(W/4)/16;
        capCorrelationBITS = floor(H/2)*floor(W/2);
        capCorrelationCHARS = floor(H/2)*floor(W/2)/8;
        capDCTbits = floor(H/8)*floor(W/8);
        capDCTchars = floor(H/8)*floor(W/8)/8;
        capDWTbits = (floor(H/4)*floor(W/4))/(4^2);
        capDWTchars = ((floor(H/4)*floor(W/4))/(4^2))/8;
        capQIMbits = floor(H)*floor(W)/8;
        capQIMchars = floor(H)*floor(W)/64;

%         set(handles.capLSBkey, 'String', [num2str(capLSBBITS), ' bit(s) / ', num2str(capLSBCHARS), ' char(s)']);
%         %set(handles.capLSBnokey, 'String', [num2str(capLSBBITS), ' bit(s) / ', num2str(capLSBCHARS), ' char(s)']);
%         set(handles.capPatchwork, 'String', [num2str(capPatchworkBITS), ' bit(s) / ', num2str(capPatchworkCHARS), ' char(s)']);
%         set(handles.capCorrelation, 'String', [num2str(capCorrelationBITS), ' bit(s) / ', num2str(capCorrelationCHARS), ' char(s)']);
%         set(handles.capDCT, 'String', [num2str(capDCTbits), 'bit(s) / ', num2str(capDCTchars), 'char(s)']);
%         set(handles.capDWT, 'String', [num2str(capDWTbits), 'bit(s) / ', num2str(capDWTchars), 'char(s)']);
%         set(handles.capQIM, 'String', [num2str(capQIMbits), 'bit(s) / ', num2str(capQIMchars), 'char(s)']);

        set(handles.capLSBkey, 'String', [num2str(capLSBBITS), ' bit(s)']);
        set(handles.capPatchwork, 'String', [num2str(capPatchworkBITS), ' bit(s) ']);
        set(handles.capCorrelation, 'String', [num2str(capCorrelationBITS), ' bit(s) ']);
        set(handles.capDCT, 'String', [num2str(capDCTbits), 'bit(s)']);
        set(handles.capDWT, 'String', [num2str(capDWTbits), 'bit(s)']);
        set(handles.capQIM, 'String', [num2str(capQIMbits), 'bit(s)']);

        
        mimage_file = 'copyright.bmp';
        message = imread(mimage_file);
        Mh = size(message,1);
        Mw = size(message,2);
        set(handles.message_size, 'String', [num2str(Mh*Mw), ' bit(s) / ', num2str(floor(Mh*Mw/7)), ' char(s)']);
        
        
% --- Outputs from this function are returned to the command line.
function varargout = watermarking_OutputFcn(hObject, eventdata, handles) 
        varargout{1} = handles.output;

function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function ktextfile_Callback(hObject, eventdata, handles)

function ktextbox_Callback(hObject, eventdata, handles)

function kimage_Callback(hObject, eventdata, handles)

%% Button brwose for selecting a key file
function browse_btn1_Callback(hObject, eventdata, handles)
        global image_file

        if (get(handles.ktextfile,'Value') == 1.0)

            set(handles.edit1,'Visible','on');
            set(handles.browse_btn1,'Visible','on');
            set(handles.keyIm,'Visible','off');

            %Open new GUI to select key file (only text file) and display content
            [tempname, temppath] = uigetfile({'*.txt','Key file(*.txt)'},'Select a key text file');
            if ((~strcmp(num2str(tempname), '0')) && (~strcmp(num2str(temppath), '0')))  
                [filepath ,filename,ext,tempver] = fileparts(strcat(temppath, '\', tempname));
                file_name = [filename ext];
                k = fopen(file_name,'r');
                key_file = fread(k, '*char');
                fclose(k);
                key_file_reshaped = reshape(key_file,1,size(key_file,1));
                set(handles.edit1,'String',key_file_reshaped);
            end

        elseif (get(handles.kimage,'Value') == 1.0)

            set(handles.edit1,'Visible','off');
            set(handles.keyIm,'Visible','on');
            axis off;
            set(handles.browse_btn1,'Visible','on');

            %Open new GUI to select key file (only image file) and display name
            [tempname, temppath] = uigetfile({'*.jpg;*.jpeg;*.gif;*.bmp;*.tif;*.tiff;*.png;','Key file(*.bmp, *.jpg, *.jpeg, *.gif,*.png, *.tif, *.tiff)'},'Select a key image file');
            if ((~strcmp(num2str(tempname), '0')) && (~strcmp(num2str(temppath), '0')))  
                [filepath ,filename,ext,tempver] = fileparts(strcat(temppath, '\', tempname));
                image_file = [filename ext];
                im_key = imread(char(image_file));                  %read the image in
                axes(handles.keyIm);                                %show the image in the axes 'keyIm'
                imshow(im_key);                                     %show the image
                axis equal;
                axis tight;
                axis off;       
            end

        else
        end


%% Options for the key
function uipanel6_SelectionChangeFcn(hObject, eventdata, handles)
        global image_file



        if (get(handles.ktextfile,'Value') == 1.0)

            set(handles.edit1,'Visible','on');
            set(handles.browse_btn1,'Visible','on');
            set(handles.keyIm,'Visible','off');

            %Open new GUI to select key file (only text file) and display content
            [tempname, temppath] = uigetfile({'*.txt','Key file(*.txt)'},'Select a key text file');
            if ((~strcmp(num2str(tempname), '0')) && (~strcmp(num2str(temppath), '0')))  
                [filepath ,filename,ext,tempver] = fileparts(strcat(temppath, '\', tempname));
                file_name = [filename ext];
                k = fopen(file_name,'r');
                key_file = char(fread(k));
                fclose(k);
                key_file_reshaped = reshape(key_file,1,size(key_file,1));
                set(handles.edit1,'String',key_file_reshaped);
            end

        elseif (get(handles.kimage,'Value') == 1.0)

            set(handles.edit1,'Visible','off');
            set(handles.keyIm,'Visible','on');
            axes(handles.keyIm);
            axis off;
            set(handles.browse_btn1,'Visible','on');

            %Open new GUI to select key file (only image file) and display name
            [tempname, temppath] = uigetfile({'*.jpg;*.jpeg;*.gif;*.bmp;*.tif;*.tiff;*.png;','Key file(*.bmp, *.jpg, *.jpeg, *.gif,*.png, *.tif, *.tiff)'},'Select a key image file');
            if ((~strcmp(num2str(tempname), '0')) && (~strcmp(num2str(temppath), '0')))  
                [filepath ,filename,ext,tempver] = fileparts(strcat(temppath, '\', tempname));
                image_file = [filename ext];
                im_key = imread(char(image_file));                  %read the image in
                axes(handles.keyIm);                                %show the image in the axes 'keyIm'
                imshow(im_key);                                     %show the image
                axis equal;
                axis tight;
                axis off;       
            end

        else
        end

%%
function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)

        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

function mtextbox_Callback(hObject, eventdata, handles)

function mtextfile_Callback(hObject, eventdata, handles)

function mimage_Callback(hObject, eventdata, handles)


%% Button browse voor message file
function browse_btn2_Callback(hObject, eventdata, handles)
        global mimage_file

        if (get(handles.mtextfile,'Value') == 1.0)

            set(handles.edit2,'Visible','on');
            set(handles.browse_btn2,'Visible','on');
            set(handles.messageIm,'Visible','off');

            %Open new GUI to select message file (only text file) and display content
            [tempname, temppath] = uigetfile({'*.txt','Message file(*.txt)'},'Select a message text file');
            if ((~strcmp(num2str(tempname), '0')) && (~strcmp(num2str(temppath), '0')))  
                [filepath ,filename,ext,tempver] = fileparts(strcat(temppath, '\', tempname));
                file_name = [filename ext];
                k = fopen(file_name,'r');
                message_file = char(fread(k));
                fclose(k);
                message_file_reshaped = reshape(message_file,1,size(message_file,1));
                set(handles.edit2,'String',message_file_reshaped);
            end

        elseif (get(handles.mimage,'Value') == 1.0)

            set(handles.edit2,'Visible','off');
            set(handles.messageIm,'Visible','on');
            axes(handles.messageIm);
            axis off;
            set(handles.browse_btn2,'Visible','on');

            %Open new GUI to select key file (only image file) and display name
            [tempname, temppath] = uigetfile({'*.jpg;*.jpeg;*.gif;*.bmp;*.tif;*.tiff;*.png;','Message file(*.bmp, *.jpg, *.jpeg, *.gif,*.png, *.tif, *.tiff)'},'Select a message image file');
            if ((~strcmp(num2str(tempname), '0')) && (~strcmp(num2str(temppath), '0')))  
                [filepath ,filename,ext,tempver] = fileparts(strcat(temppath, '\', tempname));
                mimage_file = [filename ext];
                im_message = imread(char(mimage_file));                 %read the image in
                axes(handles.messageIm);                                %show the image in the axes 'keyIm'
                imshow(im_message);                                     %show the image
                axis equal;
                axis tight;
                axis off;       
            end

        else
        end
        
        if ( get(handles.mtextfile,'Value') == 1.0 )
            message = get(handles.edit2, 'String');
            message_binary = dec2bin(message);
            message_string = num2str(message_binary);
            k = size(message_string,1);
            l = size(message_string,2);
            set(handles.message_size, 'String', [num2str(k*l), ' bit(s) / ', num2str(floor(k*l/7)), ' char(s)']);
        else
            message = imread(char(mimage_file));
            Mh = size(message,1);
            Mw = size(message,2);
            set(handles.message_size, 'String', [num2str(Mh*Mw), ' bit(s) / ', num2str(floor(Mh*Mw/7)), ' char(s)']);
        end

            
%% Options message
function uipanel7_SelectionChangeFcn(hObject, eventdata, handles)
        global mimage_file;


        if (get(handles.mtextfile,'Value') == 1.0)

            set(handles.edit2,'Visible','on');
            set(handles.browse_btn2,'Visible','on');
            set(handles.messageIm,'Visible','off');

            %Open new GUI to select message file (only text file) and display content
            [tempname, temppath] = uigetfile({'*.txt','Message file(*.txt)'},'Select a message text file');
            if ((~strcmp(num2str(tempname), '0')) && (~strcmp(num2str(temppath), '0')))  
                [filepath ,filename,ext,tempver] = fileparts(strcat(temppath, '\', tempname));
                file_name = [filename ext];
                k = fopen(file_name,'r');
                message_file = char(fread(k));
                fclose(k);
                message_file_reshaped = reshape(message_file,1,size(message_file,1));
                set(handles.edit2,'String',message_file_reshaped);
            end

        elseif (get(handles.mimage,'Value') == 1.0)

            set(handles.edit2,'Visible','off');
            set(handles.messageIm,'Visible','on');
            axes(handles.messageIm);
            axis off;
            set(handles.browse_btn2,'Visible','on');

            %Open new GUI to select key file (only image file) and display name
            [tempname, temppath] = uigetfile({'*.jpg;*.jpeg;*.gif;*.bmp;*.tif;*.tiff;*.png;','Message file(*.bmp, *.jpg, *.jpeg, *.gif,*.png, *.tif, *.tiff)'},'Select a message image file');
            if ((~strcmp(num2str(tempname), '0')) && (~strcmp(num2str(temppath), '0')))  
                [filepath ,filename,ext,tempver] = fileparts(strcat(temppath, '\', tempname));
                mimage_file = [filename ext];
                im_message = imread(char(mimage_file));                 %read the image in
                axes(handles.messageIm);                                %show the image in the axes 'keyIm'
                imshow(im_message);                                     %show the image
                axis equal;
                axis tight;
                axis off;       
            end

        else
        end
        
        if ( get(handles.mtextfile,'Value') == 1.0 )
            message = get(handles.edit2, 'String');
            message_binary = dec2bin(message);
            message_string = num2str(message_binary);
            k = size(message_string,1);
            l = size(message_string,2);
            set(handles.message_size, 'String', [num2str(k*l), ' bit(s) / ', num2str(floor(k*l/7)), ' char(s)']);
        else
            message = imread(char(mimage_file));
            Mh = size(message,1);
            Mw = size(message,2);
            set(handles.message_size, 'String', [num2str(Mh*Mw), ' bit(s) / ', num2str(floor(Mh*Mw/7)), ' char(s)']);
        end

   

%% button LSB
function lsb_btn_Callback(hObject, eventdata, handles)
        global image_file
        global mimage_file


        attack = get_root_data('attack');
        if (get(handles.ktextfile,'Value') == 1.0)

            chosen_key = 'text';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key',chosen_key);
                otherwise
                    set_root_data(handles,'chosen_key_attack',chosen_key);
            end

            chosen_text = char(get(handles.edit1,'String'));
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key_text',chosen_text);
                otherwise
                    set_root_data(handles,'chosen_key_text_attack',chosen_text);
            end
            
        elseif (get(handles.kimage,'Value') == 1.0)

            chosen_key = 'imag';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key',chosen_key);
                otherwise
                    set_root_data(handles,'chosen_key_attack',chosen_key);
            end
            
            chosen_image = imread(image_file);
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key_image',chosen_image);
                otherwise
                    set_root_data(handles,'chosen_key_image_attack',chosen_image);
            end
       
        else
        end

        if (get(handles.mtextfile,'Value') == 1.0)

            chosen_message = 'text';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message',chosen_message);
                otherwise
                    set_root_data(handles,'chosen_message_attack',chosen_message);
            end
            
            chosen_mtext = char(get(handles.edit2,'String'));
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message_text',chosen_mtext);
                otherwise
                    set_root_data(handles,'chosen_message_text_attack',chosen_mtext);
            end
            

        elseif (get(handles.mimage,'Value') == 1.0)

            chosen_message = 'imag';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message',chosen_message);
                otherwise
                    set_root_data(handles,'chosen_message_attack',chosen_message);
            end
            
            chosen_mimage = imread(mimage_file);
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message_image',chosen_mimage);
                otherwise
                    set_root_data(handles,'chosen_message_image_attack',chosen_mimage);
            end
        else
        end
        
        switch attack
            case 'no'
                set_root_data(handles,'watermarking_methode','lsb');
            otherwise
        end

        close;
        LSB_EMBEDDER;

%% Button patch work
function patch_btn_Callback(hObject, eventdata, handles)
        global image_file
        global mimage_file


        attack = get_root_data('attack');
        if (get(handles.ktextfile,'Value') == 1.0)

            chosen_key = 'text';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key',chosen_key);
                otherwise
                    set_root_data(handles,'chosen_key_attack',chosen_key);
            end

            chosen_text = char(get(handles.edit1,'String'));
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key_text',chosen_text);
                otherwise
                    set_root_data(handles,'chosen_key_text_attack',chosen_text);
            end
            
        elseif (get(handles.kimage,'Value') == 1.0)

            chosen_key = 'imag';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key',chosen_key);
                otherwise
                    set_root_data(handles,'chosen_key_attack',chosen_key);
            end
            
            chosen_image = imread(image_file);
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key_image',chosen_image);
                otherwise
                    set_root_data(handles,'chosen_key_image_attack',chosen_image);
            end
       
        else
        end

        if (get(handles.mtextfile,'Value') == 1.0)

            chosen_message = 'text';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message',chosen_message);
                otherwise
                    set_root_data(handles,'chosen_message_attack',chosen_message);
            end
            
            chosen_mtext = char(get(handles.edit2,'String'));
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message_text',chosen_mtext);
                otherwise
                    set_root_data(handles,'chosen_message_text_attack',chosen_mtext);
            end
            

        elseif (get(handles.mimage,'Value') == 1.0)

            chosen_message = 'imag';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message',chosen_message);
                otherwise
                    set_root_data(handles,'chosen_message_attack',chosen_message);
            end
            
            chosen_mimage = imread(mimage_file);
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message_image',chosen_mimage);
                otherwise
                    set_root_data(handles,'chosen_message_image_attack',chosen_mimage);
            end
        else
        end
        
        switch attack
            case 'no'
                set_root_data(handles,'watermarking_methode','patch');
            otherwise
        end

        close;
        patch_embed;

%% Button Coorelation
function cor_btn_Callback(hObject, eventdata, handles)
        global image_file
        global mimage_file


        attack = get_root_data('attack');
        if (get(handles.ktextfile,'Value') == 1.0)

            chosen_key = 'text';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key',chosen_key);
                otherwise
                    set_root_data(handles,'chosen_key_attack',chosen_key);
            end

            chosen_text = char(get(handles.edit1,'String'));
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key_text',chosen_text);
                otherwise
                    set_root_data(handles,'chosen_key_text_attack',chosen_text);
            end
            
        elseif (get(handles.kimage,'Value') == 1.0)

            chosen_key = 'imag';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key',chosen_key);
                otherwise
                    set_root_data(handles,'chosen_key_attack',chosen_key);
            end
            
            chosen_image = imread(image_file);
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key_image',chosen_image);
                otherwise
                    set_root_data(handles,'chosen_key_image_attack',chosen_image);
            end
       
        else
        end

        if (get(handles.mtextfile,'Value') == 1.0)

            chosen_message = 'text';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message',chosen_message);
                otherwise
                    set_root_data(handles,'chosen_message_attack',chosen_message);
            end
            
            chosen_mtext = char(get(handles.edit2,'String'));
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message_text',chosen_mtext);
                otherwise
                    set_root_data(handles,'chosen_message_text_attack',chosen_mtext);
            end
            

        elseif (get(handles.mimage,'Value') == 1.0)

            chosen_message = 'imag';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message',chosen_message);
                otherwise
                    set_root_data(handles,'chosen_message_attack',chosen_message);
            end
            
            chosen_mimage = imread(mimage_file);
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message_image',chosen_mimage);
                otherwise
                    set_root_data(handles,'chosen_message_image_attack',chosen_mimage);
            end
        else
        end
        
        switch attack
            case 'no'
                set_root_data(handles,'watermarking_methode','correlation');
            otherwise
        end

        close;
        correlation_embed;

%% Button DCT
function dct_btn_Callback(hObject, eventdata, handles)
        
        global image_file
        global mimage_file


        attack = get_root_data('attack');
        if (get(handles.ktextfile,'Value') == 1.0)

            chosen_key = 'text';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key',chosen_key);
                otherwise
                    set_root_data(handles,'chosen_key_attack',chosen_key);
            end

            chosen_text = char(get(handles.edit1,'String'));
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key_text',chosen_text);
                otherwise
                    set_root_data(handles,'chosen_key_text_attack',chosen_text);
            end
            
        elseif (get(handles.kimage,'Value') == 1.0)

            chosen_key = 'imag';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key',chosen_key);
                otherwise
                    set_root_data(handles,'chosen_key_attack',chosen_key);
            end
            
            chosen_image = imread(image_file);
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key_image',chosen_image);
                otherwise
                    set_root_data(handles,'chosen_key_image_attack',chosen_image);
            end
       
        else
        end

        if (get(handles.mtextfile,'Value') == 1.0)

            chosen_message = 'text';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message',chosen_message);
                otherwise
                    set_root_data(handles,'chosen_message_attack',chosen_message);
            end
            
            chosen_mtext = char(get(handles.edit2,'String'));
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message_text',chosen_mtext);
                otherwise
                    set_root_data(handles,'chosen_message_text_attack',chosen_mtext);
            end
            

        elseif (get(handles.mimage,'Value') == 1.0)

            chosen_message = 'imag';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message',chosen_message);
                otherwise
                    set_root_data(handles,'chosen_message_attack',chosen_message);
            end
            
            chosen_mimage = imread(mimage_file);
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message_image',chosen_mimage);
                otherwise
                    set_root_data(handles,'chosen_message_image_attack',chosen_mimage);
            end
        else
        end
        
        switch attack
            case 'no'
                set_root_data(handles,'watermarking_methode','dct');
            otherwise
        end

        close;
        dct_embed;

%% Button DWT
function dwt_btn_Callback(hObject, eventdata, handles)
        
        global image_file
        global mimage_file

        attack = get_root_data('attack');
        if (get(handles.ktextfile,'Value') == 1.0)

            chosen_key = 'text';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key',chosen_key);
                otherwise
                    set_root_data(handles,'chosen_key_attack',chosen_key);
            end

            chosen_text = char(get(handles.edit1,'String'));
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key_text',chosen_text);
                otherwise
                    set_root_data(handles,'chosen_key_text_attack',chosen_text);
            end
            
        elseif (get(handles.kimage,'Value') == 1.0)

            chosen_key = 'imag';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key',chosen_key);
                otherwise
                    set_root_data(handles,'chosen_key_attack',chosen_key);
            end
            
            chosen_image = imread(image_file);
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key_image',chosen_image);
                otherwise
                    set_root_data(handles,'chosen_key_image_attack',chosen_image);
            end
       
        else
        end

        if (get(handles.mtextfile,'Value') == 1.0)

            chosen_message = 'text';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message',chosen_message);
                otherwise
                    set_root_data(handles,'chosen_message_attack',chosen_message);
            end
            
            chosen_mtext = char(get(handles.edit2,'String'));
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message_text',chosen_mtext);
                otherwise
                    set_root_data(handles,'chosen_message_text_attack',chosen_mtext);
            end
            

        elseif (get(handles.mimage,'Value') == 1.0)

            chosen_message = 'imag';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message',chosen_message);
                otherwise
                    set_root_data(handles,'chosen_message_attack',chosen_message);
            end
            
            chosen_mimage = imread(mimage_file);
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message_image',chosen_mimage);
                otherwise
                    set_root_data(handles,'chosen_message_image_attack',chosen_mimage);
            end
        else
        end
        
        switch attack
            case 'no'
                set_root_data(handles,'watermarking_methode','dwt');
            otherwise
        end

        close;
        dwt_embed;

function pushbutton_message_info_Callback(hObject, eventdata, handles)

    msgbox('Please select an image or text file that you want to embed in the selected cover image. This file must be a text file or an image file. You can also type a text yourself.','Help','help');

function pushbutton_key_info_Callback(hObject, eventdata, handles)

    msgbox('Please select an image or text file that you want to use as the key. This file must be a text file or an image file. You can also type a text yourself.','Help','help');

function pushbutton_main_info_Callback(hObject, eventdata, handles)

    msgbox('In this GUI, you can specify the key, the message and the watermarking technique to use. The default key and message provided by this program are shown.', 'Help', 'help'); 



% --- Executes on button press in qim_btn.
function qim_btn_Callback(hObject, eventdata, handles)
% hObject    handle to qim_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

        global image_file
        global mimage_file

        attack = get_root_data('attack');
        if (get(handles.ktextfile,'Value') == 1.0)

            chosen_key = 'text';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key',chosen_key);
                otherwise
                    set_root_data(handles,'chosen_key_attack',chosen_key);
            end

            chosen_text = char(get(handles.edit1,'String'));
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key_text',chosen_text);
                otherwise
                    set_root_data(handles,'chosen_key_text_attack',chosen_text);
            end
            
        elseif (get(handles.kimage,'Value') == 1.0)

            chosen_key = 'imag';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key',chosen_key);
                otherwise
                    set_root_data(handles,'chosen_key_attack',chosen_key);
            end
            
            chosen_image = imread(image_file);
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key_image',chosen_image);
                otherwise
                    set_root_data(handles,'chosen_key_image_attack',chosen_image);
            end
       
        else
        end

        if (get(handles.mtextfile,'Value') == 1.0)

            chosen_message = 'text';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message',chosen_message);
                otherwise
                    set_root_data(handles,'chosen_message_attack',chosen_message);
            end
            
            chosen_mtext = char(get(handles.edit2,'String'));
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message_text',chosen_mtext);
                otherwise
                    set_root_data(handles,'chosen_message_text_attack',chosen_mtext);
            end
            

        elseif (get(handles.mimage,'Value') == 1.0)

            chosen_message = 'imag';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message',chosen_message);
                otherwise
                    set_root_data(handles,'chosen_message_attack',chosen_message);
            end
            
            chosen_mimage = imread(mimage_file);
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message_image',chosen_mimage);
                otherwise
                    set_root_data(handles,'chosen_message_image_attack',chosen_mimage);
            end
        else
        end
        
        switch attack
            case 'no'
                set_root_data(handles,'watermarking_methode','qim');
            otherwise
        end

        close;
        QIM_embed;


% --- Executes on button press in cdma_btn.
function cdma_btn_Callback(hObject, eventdata, handles)
% hObject    handle to cdma_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

        global image_file
        global mimage_file

        attack = get_root_data('attack');
        if (get(handles.ktextfile,'Value') == 1.0)

            chosen_key = 'text';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key',chosen_key);
                otherwise
                    set_root_data(handles,'chosen_key_attack',chosen_key);
            end

            chosen_text = char(get(handles.edit1,'String'));
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key_text',chosen_text);
                otherwise
                    set_root_data(handles,'chosen_key_text_attack',chosen_text);
            end
            
        elseif (get(handles.kimage,'Value') == 1.0)

            chosen_key = 'imag';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key',chosen_key);
                otherwise
                    set_root_data(handles,'chosen_key_attack',chosen_key);
            end
            
            chosen_image = imread(image_file);
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_key_image',chosen_image);
                otherwise
                    set_root_data(handles,'chosen_key_image_attack',chosen_image);
            end
       
        else
        end

        if (get(handles.mtextfile,'Value') == 1.0)

            chosen_message = 'text';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message',chosen_message);
                otherwise
                    set_root_data(handles,'chosen_message_attack',chosen_message);
            end
            
            chosen_mtext = char(get(handles.edit2,'String'));
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message_text',chosen_mtext);
                otherwise
                    set_root_data(handles,'chosen_message_text_attack',chosen_mtext);
            end
            

        elseif (get(handles.mimage,'Value') == 1.0)

            chosen_message = 'imag';
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message',chosen_message);
                otherwise
                    set_root_data(handles,'chosen_message_attack',chosen_message);
            end
            
            chosen_mimage = imread(mimage_file);
            
            switch attack
                case 'no'
                    set_root_data(handles,'chosen_message_image',chosen_mimage);
                otherwise
                    set_root_data(handles,'chosen_message_image_attack',chosen_mimage);
            end
        else
        end
        
        switch attack
            case 'no'
                set_root_data(handles,'watermarking_methode','cdma');
            otherwise
        end

        close;
        cdma_embed;

