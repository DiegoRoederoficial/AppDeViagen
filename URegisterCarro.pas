unit URegisterCarro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, IdHashSHA,
  FMX.StdActns, FMX.MediaLibrary.Actions, FMX.DialogService, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFormCadastroCarros = class(TForm)
    Layout1: TLayout;
    Layout3: TLayout;
    Layout2: TLayout;
    Layout4: TLayout;
    Label1: TLabel;
    Edit_Nome: TEdit;
    Layout5: TLayout;
    Label2: TLabel;
    Edit_Quantridade: TEdit;
    Layout6: TLayout;
    Label3: TLabel;
    Layout7: TLayout;
    Label4: TLabel;
    Edit_Media: TEdit;
    Rectangle1: TRectangle;
    Label5: TLabel;
    Label6: TLabel;
    Edit_Tipo: TEdit;
    procedure Rectangle1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastroCarros: TFormCadastroCarros;

implementation

uses UDM,UEscolha;

{$R *.fmx}

procedure TFormCadastroCarros.Rectangle1Click(Sender: TObject);
begin
  DM.FDQueryCarros.SQL.Clear;
  DM.FDQueryCarros.SQL.Add('INSERT INTO Carros(Nome, Quantidade, Tipo, Media)');
  DM.FDQueryCarros.SQL.Add('VALUES (:Nome, :Quantidade, :Tipo, :Media)');
  DM.FDQueryCarros.ParamByName('Nome').AsString := Edit_Nome.Text;
  DM.FDQueryCarros.ParamByName('Quantidade').AsString := Edit_Quantridade.Text;
  DM.FDQueryCarros.ParamByName('Tipo').AsString := Edit_Tipo.Text;
  DM.FDQueryCarros.ParamByName('Media').AsString := Edit_Media.Text;
  DM.FDQueryCarros.ExecSQL();
   if not Assigned(FormEscolha) then
        Application.CreateForm(TFormEscolha, FormEscolha);
      FormEscolha.Show;
end;

end.
