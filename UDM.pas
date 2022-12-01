unit UDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, IOUtils;

type
  TDM = class(TDataModule)
    FDConnection: TFDConnection;
    FDQueryCarros: TFDQuery;
    FDQPessoa: TFDQuery;
    FDQPessoaid: TFDAutoIncField;
    FDQPessoaemail: TStringField;
    FDQPessoasenha: TStringField;
    procedure FDConnectionAfterConnect(Sender: TObject);
    procedure FDConnectionBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

procedure TDM.FDConnectionAfterConnect(Sender: TObject);
var
  strSQL: string;
begin
  strSQL := 'create table IF NOT EXISTS pessoa( 		' + //
    'id integer not null primary key autoincrement, ' + //
    'email varchar(300),                             ' + //
    'senha varchar(300))                             ';
  FDConnection.ExecSQL(strSQL);
  FDQPessoa.Active;
  FDQueryCarros.Active;
end;

procedure TDM.FDConnectionBeforeConnect(Sender: TObject);
var
  strPath: string;
begin
{$IF DEFINED(iOS) or DEFINED(ANDROID)}
  strPath := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,
    'bancoDados.db');
{$ENDIF}
{$IFDEF MSWINDOWS}
  strPath := System.IOUtils.TPath.Combine
    ('D:\Users\aluno\Documents\Embarcadero\Studio\Projects\BD',
    'bancoDados.db');
{$ENDIF}
  FDConnection.Params.Values['UseUnicode'] := 'False';
  FDConnection.Params.Values['DATABASE'] := strPath;
end;

end.
