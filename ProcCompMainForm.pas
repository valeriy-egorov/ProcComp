unit ProcCompMainForm;

interface

uses System.Classes, Vcl.Controls, Vcl.ComCtrls, VCL.Forms;

type
  TForm1 = class(TForm)
    SBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
   private
   public
    end;

var
  Form1: TForm1;

implementation

uses System.SysUtils, System.IniFiles, Svn.Constants, Svn.Ini, Svn.Inform;

ResourceString
  coApplication = 'Application';

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
Var
  AIni: TIniFile;
begin
ReportMemoryLeaksOnShutdown    := True;
Caption                        := coApplication;
Application.HintHidePause      := 8000;
FormatSettings.DateSeparator   := '-';
FormatSettings.TimeSeparator   := ':';
FormatSettings.ShortDateFormat := 'yyyy-mm-dd';
FormatSettings.LongDateFormat  := FormatSettings.ShortDateFormat;
FormatSettings.ShortTimeFormat := 'hh:mm:ss';
FormatSettings.LongTimeFormat  := FormatSettings.ShortTimeFormat;

SvnInfStsVer(SBar1);
SvnInfPrsCreate(SBar1);

AIni                 := TIniFile.Create(ChangeFileExt(Application.ExeName, coFileExtIni));
With AIni Do
  Try
    Top                  := ReadInteger(Self.ClassName, coTop, Top);
    Left                 := ReadInteger(Self.ClassName, coLeft, Left);
    Width                := ReadInteger(Self.ClassName, coWidth, Width);
    Height               := ReadInteger(Self.ClassName, coHeight, Height);
//
//    IniRead(Self, ESDay, AIni);
   Finally
    Free;
    End;
end;

procedure TForm1.FormDestroy(Sender: TObject);
Var
  AIni:                TIniFile;
begin
AIni                 := TIniFile.Create(ChangeFileExt(Application.ExeName, coFileExtIni));
With AIni Do
  Try
    If WindowState = wsNormal Then
      Begin
      WriteInteger(Self.ClassName, coTop, Top);
      WriteInteger(Self.ClassName, coLeft, Left);
      WriteInteger(Self.ClassName, coWidth, Width);
      WriteInteger(Self.ClassName, coHeight, Height);
      End;
//
//    IniWrite(Self, ESDay, AIni);
   Finally
    Free;
    End;
end;

procedure TForm1.FormResize(Sender: TObject);
Var
  Wok1:                Integer;
begin
Wok1                 := Width - (240 + 240 {Panels[1].Width + Panels[2].Width});
SBar1.Panels[0].Width:= Wok1;
FInfPBar.Left        := Wok1 + 2;
end;

end.

