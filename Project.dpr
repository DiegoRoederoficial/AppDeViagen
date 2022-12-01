program Project;

uses
  System.StartUpCopy,
  FMX.Forms,
  UTelaInicial in 'UTelaInicial.pas' {FormInicial},
  UDM in 'UDM.pas' {DM: TDataModule},
  UEscolha in 'UEscolha.pas' {FormEscolha},
  URegisterCarro in 'URegisterCarro.pas' {FormCadastroCarros},
  UGPS in 'UGPS.pas' {FormMapa};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFormInicial, FormInicial);
  Application.Run;
end.
