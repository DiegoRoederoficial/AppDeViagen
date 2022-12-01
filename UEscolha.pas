unit UEscolha;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts;

type
  TFormEscolha = class(TForm)
    Layout1: TLayout;
    Image1: TImage;
    Layout2: TLayout;
    Rectangle1: TRectangle;
    Layout3: TLayout;
    Image2: TImage;
    Image3: TImage;
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEscolha: TFormEscolha;

implementation

uses URegisterCarro, UGPS;
{$R *.fmx}

procedure TFormEscolha.Image2Click(Sender: TObject);
begin
  if not Assigned(FormCadastroCarros) then
    Application.CreateForm(TFormCadastroCarros, FormCadastroCarros);
 FormCadastroCarros.Show;
end;

procedure TFormEscolha.Image3Click(Sender: TObject);
begin
  if not Assigned(FormMapa) then
    Application.CreateForm(TFormMapa, FormMapa);
  FormMapa.Show;
end;

end.
