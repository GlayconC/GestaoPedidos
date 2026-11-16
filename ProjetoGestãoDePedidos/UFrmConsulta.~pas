unit UFrmConsulta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, UDM;

type
  TFrmConsulta = class(TForm)
    Label1: TLabel;
    edtPesquisar: TEdit;
    DBGrid1: TDBGrid;
    procedure edtPesquisarChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    procedure PesquisarClientes;
    procedure SelecionarCliente;
  public
    ChaveSelecionada: Integer;

  end;

var
  FrmConsulta: TFrmConsulta;

implementation

{$R *.dfm}

procedure TFrmConsulta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
    Key := 0;
end;

procedure TFrmConsulta.DBGrid1KeyDown(
  Sender: TObject;
  var Key: Word;
  Shift: TShiftState
);
begin
  if Key = VK_RETURN then
  begin
    SelecionarCliente;
    Key := 0;
  end;
end;

procedure TFrmConsulta.FormShow(Sender: TObject);
begin
  ChaveSelecionada := 0;
  edtPesquisar.Clear;
  PesquisarClientes;
  edtPesquisar.SetFocus;
end;

procedure TFrmConsulta.DBGrid1DblClick(Sender: TObject);
begin
  SelecionarCliente;
end;

procedure TFrmConsulta.PesquisarClientes;
begin
  DM.PesquisarClientes(edtPesquisar.Text);
end;

procedure TFrmConsulta.SelecionarCliente;
begin
  if DM.IBQueryConsulta.IsEmpty then
    Exit;

  ChaveSelecionada :=
    DM.IBQueryConsulta.FieldByName('CHAVE').AsInteger;

  ModalResult := mrOk;
end;

procedure TFrmConsulta.edtPesquisarChange(Sender: TObject);
begin
  PesquisarClientes;
end;

end.
