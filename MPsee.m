function varargout = MPsee(varargin)
% This is the MPsee GUI function of MPsee toolbox by S. Tajeddin,
% This code comes with no guarantee or warranty of any kind
%
%MPSEE M-file for MPsee.fig
%      MPSEE, by itself, creates a new MPSEE or raises the existing
%      singleton*.
%
%      H = MPSEE returns the handle to a new MPSEE or the handle to
%      the existing singleton*.
%
%      MPSEE('Property','Value',...) creates a new MPSEE using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to MPsee_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      MPSEE('CALLBACK') and MPSEE('CALLBACK',hObject,...) call the
%      local function named CALLBACK in MPSEE.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MPsee

% Last Modified by GUIDE v2.5 18-May-2017 18:10:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MPsee_OpeningFcn, ...
                   'gui_OutputFcn',  @MPsee_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before MPsee is made visible.
function MPsee_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for MPsee
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MPsee wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MPsee_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Generate.
function Generate_Callback(hObject, eventdata, handles)
% hObject    handle to Generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
h = findobj('Tag', 'def_shooting');
contents = get(h,'Value');
switch contents
    case 1
        shooting='single';
    case 2
        shooting='multiple';
end

h = findobj('Tag', 'def_continuation');
contents = get(h,'Value');
switch contents
    case 1
        continuation='yes';
    case 2
        continuation='no';
end

h = findobj('Tag', 'def_Kmax');
Kmax=get(h,'String');

h = findobj('Tag', 'def_errtol');
errtol=get(h,'String');

h = findobj('Tag', 'def_iterout');
iterout=get(h,'String');

display('________________________________________________________________')
% hObject    handle to Generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file100=fopen('go.m','w');
text=fileread('go_sizes.m');
fprintf(file100,text);
text=fileread('go_params.m');
fprintf(file100,text);
text=fileread('go_syms.m');
fprintf(file100,text);
text=fileread('go_problem.m');
fprintf(file100,text);

if strcmp(shooting,'single')
formatspec=['shooting=''%s'';\n'...
            'continuation=''%s'';\n'...
            'Kmax=%s;\n'...
            'errtol=%s;\n'...
            'iter_out=%s-1;\n'...
            'Usize=N*(dimu+dimec);\n'...
            'U0=0*ones(Usize,1);\n'...
            'assignin(''base'', ''U0'', U0);\n'...
            'dU0=0*ones(Usize,1);\n'...
            'assignin(''base'', ''dU0'', dU0);\n'...
            'Coder(shooting,continuation,N,dimx,dimu,dimec,dimic,TVP,TVP_f,Xk,Uk,Lmdk,Muk,fxu,Gxu,Cxu,Lk,Phi,R_value,Kmax,errtol,iter_out);\n'];
else
    formatspec=['shooting=''%s'';\n'...
            'continuation=''%s'';\n'...
            'Kmax=%s;\n'...
            'errtol=%s;\n'...
            'iter_out=%s-1;\n'...
            'Usize=N*(dimu+dimec+dimx+dimx);\n'...
            'U0=0*ones(Usize,1);\n'...
            'assignin(''base'', ''U0'', U0);\n'...
            'dU0=0*ones(Usize,1);\n'...
            'assignin(''base'', ''dU0'', dU0);\n'...
            'Coder(shooting,continuation,N,dimx,dimu,dimec,dimic,TVP,TVP_f,Xk,Uk,Lmdk,Muk,fxu,Gxu,Cxu,Lk,Phi,R_value,Kmax,errtol,iter_out);\n'];
end
fprintf(file100,formatspec,shooting,continuation,Kmax,errtol,iterout);
fclose('all');
run('go.m')
display('_________________________________________________________________')
disp('NMPC was successfully built:')
disp(['Continuation= ',continuation])
disp(['Shooting Method= ',shooting])
disp(['Error tolerance= ',num2str(errtol)])
disp(['Max. inner iterations= ',num2str(Kmax)])
disp(['Max. outer iterations= ',num2str(iterout)])
display('_________________________________________________________________')
open('NMPCLib.slx')


% --- Executes on button press in def_sizes.
function def_sizes_Callback(hObject, eventdata, handles)
% hObject    handle to def_sizes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('go_sizes.m');


% --- Executes on button press in def_params.
function def_params_Callback(hObject, eventdata, handles)
% hObject    handle to def_params (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('go_params.m');

% --- Executes on button press in def_problem.
function def_problem_Callback(hObject, eventdata, handles)
% hObject    handle to def_problem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('go_problem.m');


% --- Executes on button press in help.
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('MPsee_help.pdf')