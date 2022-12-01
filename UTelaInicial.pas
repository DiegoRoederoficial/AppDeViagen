unit UTelaInicial;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, Data.DB, System.permissions,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Edit, FMX.TabControl, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Layouts, System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.MediaLibrary.Actions, IdHashSHA, FMX.DialogService, UDM,UEscolha;

type
  TFormInicial = class(TForm)
    ActionList1: TActionList;
    ChangeTabAction1: TChangeTabAction;
    ChangeTabAction2: TChangeTabAction;
    Layout1: TLayout;
    TabControl1: TTabControl;
    TabItemLogin: TTabItem;
    Image1: TImage;
    Layout2: TLayout;
    Layout3: TLayout;
    Edit_Email_Login: TEdit;
    Label4: TLabel;
    Layout4: TLayout;
    Edit_senha_Login: TEdit;
    Label5: TLabel;
    Rectangle1: TRectangle;
    Label3: TLabel;
    Layout5: TLayout;
    Label1: TLabel;
    TabItemCadastro: TTabItem;
    Image2: TImage;
    Layout6: TLayout;
    Layout7: TLayout;
    Edit_Email_Cadastro: TEdit;
    Label2: TLabel;
    Layout8: TLayout;
    Edit_Senha_Cadastro: TEdit;
    Label6: TLabel;
    Rectangle2: TRectangle;
    Cadastrar: TLabel;
    Layout9: TLayout;
    procedure CadastrarClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Rectangle1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormInicial: TFormInicial;

implementation

{$R *.fmx}

function SHA1FromString(const AString: string): string;
var
  SHA1: TIdHashSHA1;
begin
  SHA1 := TIdHashSHA1.Create;
  try
    Result := SHA1.HashStringAsHex(AString);
  finally
    SHA1.Free;
  end;
end;

procedure TFormInicial.Label1Click(Sender: TObject);
begin
  ChangeTabAction2.Execute;
end;


procedure TFormInicial.Rectangle1Click(Sender: TObject);
begin
  var
    senha: string;
  begin
    senha := SHA1FromString(Edit_senha_Login.Text);
    DM.FDQPessoa.Close;
    DM.FDQPessoa.ParamByName('pnome').AsString := Edit_Email_Login.Text;
    DM.FDQPessoa.Open();

    if not(DM.FDQPessoa.IsEmpty) and (DM.FDQPessoasenha.AsString = senha)
    then
    begin
      if not Assigned(FormEscolha) then
        Application.CreateForm(TFormEscolha, FormEscolha);
      FormEscolha.Show;
    end
    else
    begin
      ShowMessage('Login ou senha não confere');
    end
  end;

end;



procedure TFormInicial.CadastrarClick(Sender: TObject);
var
  senha: string;
begin
  senha := SHA1FromString(Edit_Senha_Cadastro.Text);
  DM.FDQPessoa.Close;
  DM.FDQPessoa.Open();
  if (Edit_Email_Cadastro.Text = EmptyStr) or (Edit_Senha_Cadastro.Text = EmptyStr)
  then
    Abort;

  DM.FDQPessoa.Close;
  DM.FDQPessoa.Open();
  if (Edit_Email_Cadastro.Text = EmptyStr) or (Edit_Senha_Cadastro.Text = EmptyStr)
  then
    Abort;

  DM.FDQPessoa.Append;
  DM.FDQPessoaemail.AsString := Edit_Email_Cadastro.Text;
  DM.FDQPessoasenha.AsString := senha;

  DM.FDQPessoa.Post;
  DM.FDConnection.CommitRetaining;

  ChangeTabAction1.Execute;
end;

end.
