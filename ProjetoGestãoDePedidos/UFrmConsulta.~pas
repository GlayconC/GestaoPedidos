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
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
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
    Close;
end;

procedure TFrmConsulta.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
  end;
end;

procedure TFrmConsulta.FormShow(Sender: TObject);
begin
  DM.ExecutarConsulta(
    'SELECT CHAVE, NOME, CPF ' +
    'FROM CLIENTES ' +
    'ORDER BY NOME');
end;

procedure TFrmConsulta.DBGrid1DblClick(Sender: TObject);
begin
  ChaveSelecionada :=
    DM.IBQueryConsulta.FieldByName('CHAVE').AsInteger;

  ModalResult := mrOk;
end;

end.
