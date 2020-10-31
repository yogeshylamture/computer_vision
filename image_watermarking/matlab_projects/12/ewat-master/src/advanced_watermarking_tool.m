function varargout = advanced_watermarking_tool(varargin)
% ADVANCED_WATERMARKING_TOOL M-file for advanced_watermarking_tool.fig
%      ADVANCED_WATERMARKING_TOOL, by itself, creates a new ADVANCED_WATERMARKING_TOOL or raises the existing
%      singleton*.
%
%      H = ADVANCED_WATERMARKING_TOOL returns the handle to a new ADVANCED_WATERMARKING_TOOL or the handle to
%      the existing singleton*.
%
%      ADVANCED_WATERMARKING_TOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADVANCED_WATERMARKING_TOOL.M with the given input arguments.
%
%      ADVANCED_WATERMARKING_TOOL('Property','Value',...) creates a new ADVANCED_WATERMARKING_TOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before advanced_watermarking_tool_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to advanced_watermarking_tool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help advanced_watermarking_tool

% Last Modified by GUIDE v2.5 13-Jun-2008 12:42:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @advanced_watermarking_tool_OpeningFcn, ...
                   'gui_OutputFcn',  @advanced_watermarking_tool_OutputFcn, ...
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


%% Opening Function
function advanced_watermarking_tool_OpeningFcn(hObject, eventdata, handles, varargin)

        handles.output = hObject;
        guidata(hObject, handles);

        clc;                            %Clear the command window
        
        local_path = cd;                %local_path now contains the current directory
        addpath(genpath(local_path));   %Add every folder bellow the current directory to the workspace
        
        setappdata(0,'hroot_data',gcf);
        set_root_data(handles,'local_path',local_path);

%% Output 
function varargout = advanced_watermarking_tool_OutputFcn(hObject, eventdata, handles) 

        varargout{1} = handles.output;
        
%% Button iMark
function btn_imark_Callback(hObject, eventdata, handles)

        iMark();
        
function btn_script_Callback(hObject, eventdata, handles)
    
        script();

%% Button E-WaT
function btn_ewat_Callback(hObject, eventdata, handles)

        ewat();

%% Button Close
function btn_close_Callback(hObject, eventdata, handles)

        close();
        
%% Button Help.
function btn_help_Callback(hObject, eventdata, handles)

        msgbox('Help','Welcome to the Advanced Watermarking Tool. Inside every program an help file can be found that wil help you guide through every step');



