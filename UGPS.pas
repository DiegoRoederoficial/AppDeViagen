unit UGPS;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Menus, FMX.TabControl,
  System.Actions, FMX.ActnList, FMX.Objects, FMX.Edit, FMX.Layouts, FMX.ListBox,
  FMX.DateTimeCtrls, FMX.Gestures, FMX.Maps, System.Sensors, System.Permissions,
  System.Sensors.Components, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.Ani;

type
  TFormMapa = class(TForm)
    LocationSensor1: TLocationSensor;
    TabControl1: TTabControl;
    TabItemGPS: TTabItem;
    Layout1: TLayout;
    MapView1: TMapView;
    Switch1: TSwitch;
    Label1: TLabel;
    Label2: TLabel;
    LabelTempo: TLabel;
    LabelDistancia: TLabel;
    Edit_Origem: TEdit;
    Edit_Destino: TEdit;
    LabelValor: TLabel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    ToolBar1: TToolBar;
    btn_calcular: TSpeedButton;
    TextValor: TText;
    TextTempo: TText;
    TextDistancia: TText;
    procedure Switch1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject;
      const OldLocation, NewLocation: TLocationCoord2D);
    procedure btn_calcularClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMapa: TFormMapa;

implementation

uses UDM, json
{$IFDEF ANDROID}
    , Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
{$ENDIF}
    ;
{$R *.fmx}

procedure TFormMapa.FormCreate(Sender: TObject);
begin
  MapView1.MapType := TMapType.Normal;
end;

procedure TFormMapa.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
var
  MyMarker: TMapMarkerDescriptor;
  posicao: TMapCoordinate;

begin

  MapView1.Location := TMapCoordinate.Create(NewLocation.Latitude,
    NewLocation.Longitude);
  posicao.Latitude := NewLocation.Latitude;
  posicao.Longitude := NewLocation.Longitude;
  MyMarker := TMapMarkerDescriptor.Create(posicao, 'Estou aqui!');
  MyMarker.Draggable := true;
  MyMarker.Visible := true;
  MyMarker.Snippet := 'Eu';

  MapView1.AddMarker(MyMarker);
  // Label3.Text := NewLocation.Latitude.ToString().Replace(',', '.');
  // Label4.Text := NewLocation.Longitude.ToString().Replace(',', '.');

end;

procedure TFormMapa.btn_calcularClick(Sender: TObject);
var
  retorno: TJSONObject;
  prows: TJSONPair;
  arrayr: TJSONArray;
  orows: TJSONObject;
  arraye: TJSONArray;
  oelementos: TJSONObject;
  oduracao, odistancia: TJSONObject;

  distancia_str, duracao_str: string;
  distancia_int, duracao_int: integer;

   valor : double;
begin
  RESTRequest1.Resource :=
    'json?origins={origem}&destinations={destino}&mode=driving&language=pt-BR&key=AIzaSyAwjnJzF57fQddVy_dL8yTC01Zw7ufVuY8';
  RESTRequest1.Params.AddUrlSegment('origem', Edit_Origem.Text);
  RESTRequest1.Params.AddUrlSegment('destino', Edit_Destino.Text);
  RESTRequest1.Execute;

  retorno := RESTRequest1.Response.JSONValue as TJSONObject;

  if retorno.GetValue('status').Value <> 'OK' then
  begin
    showmessage('Ocorreu um erro ao calcular a viagem.');
   exit;
  end;

  prows := retorno.Get('rows');
  arrayr := prows.JSONValue as TJSONArray;
  orows := arrayr.Items[0] as TJSONObject;
  arraye := orows.GetValue('elements') as TJSONArray;
  oelementos := arraye.Items[0] as TJSONObject;

  odistancia := oelementos.GetValue('distance') as TJSONObject;
  oduracao := oelementos.GetValue('duration') as TJSONObject;

  distancia_str := odistancia.GetValue('text').Value;
  distancia_int := odistancia.GetValue('value').Value.ToInteger;

  duracao_str := oduracao.GetValue('text').Value;
  duracao_int := oduracao.GetValue('value').Value.ToInteger;

  textDistancia.Text := distancia_str;
    textTempo.Text := duracao_str;

     valor := (distancia_int / 8) * (5);
  TextValor.Text := 'R$ ' + FormatFloat('###,#', valor);
end;

procedure TFormMapa.Switch1Click(Sender: TObject);
{$IFDEF ANDROID}
var
  APermissaoGPS: string;
{$ENDIF}
begin
{$IFDEF ANDROID}
  APermissaoGPS := JStringToString
    (TJManifest_permission.JavaClass.ACCESS_FINE_LOCATION);

  PermissionsService.RequestPermissions([APermissaoGPS],
    Procedure(const APermissions: TArray<string>;
      const AGrantResults: TArray<TPermissionStatus>)
    begin
      if (Length(AGrantResults) = 1) and
        (AGrantResults[0] = TPermissionStatus.Granted) then
        LocationSensor1.Active := true
      else
        LocationSensor1.Active := False
    end);
{$ENDIF}
end;

end.
