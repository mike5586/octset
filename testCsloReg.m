function varargout = testCsloReg(varargin)
% TESTCSLOREG MATLAB code for testCsloReg.fig
%      TESTCSLOREG, by itself, creates a new TESTCSLOREG or raises the existing
%      singleton*.
%
%      H = TESTCSLOREG returns the handle to a new TESTCSLOREG or the handle to
%      the existing singleton*.
%
%      TESTCSLOREG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTCSLOREG.M with the given input arguments.
%
%      TESTCSLOREG('Property','Value',...) creates a new TESTCSLOREG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testCsloReg_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testCsloReg_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testCsloReg

% Last Modified by GUIDE v2.5 08-Mar-2016 17:21:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testCsloReg_OpeningFcn, ...
                   'gui_OutputFcn',  @testCsloReg_OutputFcn, ...
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


% --- Executes just before testCsloReg is made visible.
function testCsloReg_OpeningFcn(hObject, eventdata, handles, varargin)
% axis off
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testCsloReg (see VARARGIN)

% Choose default command line output for testCsloReg
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testCsloReg wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testCsloReg_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function read_file_Callback(hObject, eventdata, handles)%菜单——读入文件
  [filename, pathname,filterindex] = uigetfile( ...
       {'*.bmp;*.jpg;*.tiff;*.tif', '图片文件 (*.bmp;*.jpg;*.tiff;*.tif)'; ...
        '*.*','All Files (*.*)'},...
        'Pick a file','MultiSelect','on');

%     if ~exist('all_file','var')     

        all_file=getappdata(gcf,'all_file');
        all_path=getappdata(gcf,'all_path');
        if isempty (all_file)
            all_file={};
            all_path={};
        end

    if filterindex==1
%         add_times=length(all_file);
%         length_file=length(filename);
%         all_file{add_times+1:add_times+length_file}=filename;
%         all_path{add_times+1:add_times+length_file}=pathname;
        all_file=[all_file,filename];
        all_path=[all_path,repmat({pathname},[1 length(filename)])];
        setappdata(gcf,'all_file',all_file);
        setappdata(gcf,'all_path',all_path);
        setappdata(gcf,'filterindex',filterindex);
        set(handles.listbox1,'String',all_file);
    end
% hObject    handle to read_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function quitmeu_Callback(hObject, eventdata, handles)%菜单——退出
% close(gcf)
button=questdlg('是否确认关闭','关闭确认','是','否','是');
if strcmp(button,'是')
    close(gcf);
else
    return;
end
% hObject    handle to quitmeu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)%listbox——显示图像
      
        list_value= get(handles.listbox1,'value'); 
        if length(list_value)<2
            all_file=getappdata(gcf,'all_file');
            all_path=getappdata(gcf,'all_path');
            if ~isempty(all_path)
                file_name=char([all_path(list_value),all_file(list_value)]);
                axes1=imread([file_name(1,:),file_name(2,:)]);
                axes(handles.axes1);
                imshow(axes1);
            end
        end
       
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)%按钮删除——剔除原始数据文件名
        all_file=getappdata(gcf,'all_file');
        all_path=getappdata(gcf,'all_path');
        if ~isempty(all_file)
            list_value= get(handles.listbox1,'value');
            set(handles.listbox1,'value',max(min(list_value)-1,1));
            all_file=getappdata(gcf,'all_file');
            all_path=getappdata(gcf,'all_path');
            all_file(list_value)=[];
            all_path(list_value)=[];
            setappdata(gcf,'all_file',all_file);
            setappdata(gcf,'all_path',all_path);
            %         setappdata(gcf,'filterindex',filterindex);
            set(handles.listbox1,'String',all_file);
        end
        
        


% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on listbox1 and none of its controls.

%         list_value= get(handles.listbox1,'value'); 
%         all_file=getappdata(gcf,'all_file');
%         all_path=getappdata(gcf,'all_path');
%         file_name=char([all_path(list_value),all_file(list_value)]);
%         axes1=imread([file_name(1,:),file_name(2,:)]);
%         axes(handles.axes1);
%         imshow(axes1); 

% hObject    handle to listbox1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.


% --- Executes on key press with focus on listbox1 and none of its controls.
function listbox1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function listbox1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
%         all_file=getappdata(gcf,'all_file');
%         all_path=getappdata(gcf,'all_path');
% %         ffrom=1;
% %         nf=50
%         for list_value=1:length(all_file)
%             file_name=char([all_path(list_value),all_file(list_value)]);
%             img_r(:,:,list_value)=im2double(imread([file_name(1,:),file_name(2,:)]));
%         end
%         setappdata(gcf,'img_r',img_r);
            
            
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)%按钮配准
        
        all_file=getappdata(gcf,'all_file');
        all_path=getappdata(gcf,'all_path');
        method=getappdata(gcf,'method');
        if isempty(method)
            method='translation';
        end
            
        if ~isempty(all_file)
        for list_value=1:length(all_file)
            file_name=char([all_path(list_value),all_file(list_value)]);
            img_r(:,:,list_value)=im2double(imread([file_name(1,:),file_name(2,:)]));
        end
        setappdata(gcf,'img_r',img_r);
        [optimizer, metric] = imregconfig('monomodal');
        img_t=img_r(:,:,1);       
        img_c=img_r;
        parfor i=2:length(all_file)
                   img_c(:,:,i) = imregister(img_r(:,:,i), img_t, ...
        method, optimizer, metric); 
        end
        img_t=sum(img_c,3);
        axes(handles.axes3);imagesc((img_t(21:474,21:492)));axis equal;axis off;colormap(gray);
        cor_avr=mat2gray(img_t(21:474,21:492));
        set(handles.listbox5,'Value',1);
        set(handles.listbox5,'String',num2cell(1:length(all_file)-1));
        setappdata(gcf,'img_c_num',num2cell(1:length(all_file)-1));
        setappdata(gcf,'img_c',img_c);
        set(handles.Untitled_1,'Enable','on');
        end
        
        
         
        
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox5.
function listbox5_Callback(hObject, eventdata, handles)%listbox——显示配准结果
       img_c_num=cell2mat(getappdata(gcf,'img_c_num'));
       img_c=getappdata(gcf,'img_c');
       list_value= get(handles.listbox5,'value'); 
       if length(list_value)<2
           if ~isempty(img_c)
               axes(handles.axes2); imshowpair(img_c(21:474,21:492,img_c_num(list_value)+1),img_c(21:474,21:492,1));
           end
       end
       
       
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox5


% --- Executes during object creation, after setting all properties.
function listbox5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)%按钮剔除
        img_c_num=getappdata(gcf,'img_c_num');
        if ~isempty(img_c_num)
            list_value= get(handles.listbox5,'value');
            img_c_num(list_value)=[];
            set(handles.listbox5,'value',max(min(list_value)-1,1));
            
            axis equal;axis off;colormap(gray);
            set(handles.listbox5,'String',img_c_num);
            img_c=getappdata(gcf,'img_c');
            img_t=img_c(:,:,[1,cell2mat(img_c_num)+1]);
            img_t=sum(img_t,3);
            axes(handles.axes2);imagesc((img_c(:,:,max(min(list_value)-1,1))));
            axes(handles.axes4);imagesc((img_t(21:474,21:492)));axis equal;axis off;colormap(gray);   
            setappdata(gcf,'img_c_num',img_c_num);
        end
        
        
        
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
         all_file=getappdata(gcf,'all_file');         
         img_c=getappdata(gcf,'img_c');
         if ~isempty(all_file)
             set(handles.listbox5,'String',num2cell(1:length(all_file)-1));
             setappdata(gcf,'img_c_num',num2cell(1:length(all_file)-1));
             img_t=sum(img_c,3);
             axes(handles.axes4);imagesc((img_t(21:474,21:492)));axis equal;axis off;colormap(gray);
         end


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
 setappdata(gcf,'method','translation');


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
setappdata(gcf,'method','rigid');


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5
setappdata(gcf,'method','affine');


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
        img_c_num=getappdata(gcf,'img_c_num');
        [filename,pathname,filterindex]=uiputfile('*.tif','存储配准结果');
        if filterindex==1
            if ~isempty(img_c_num)
                img_c=getappdata(gcf,'img_c');
                img_t=img_c(:,:,[1,cell2mat(img_c_num)+1]);
                img_t=sum(img_t,3);
                cor_avr=mat2gray(img_t(21:474,21:492));
                imwrite(cor_avr,[pathname,filename]);
                %             axes(handles.axes4);imagesc((img_t(21:474,21:492)));axis equal;axis off;colormap(gray);
                %             setappdata(gcf,'img_c_num',img_c_num);
                %             [filename,pathname]=uiputfile('*.tif','存储配准结果');
                %             imwrite(cor_avr,sprintf('avr_rr09_%d_ from%d.tif',nf,ffrom));
            end
        end


% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
