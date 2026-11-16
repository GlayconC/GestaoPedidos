unit URegistroErros;

interface

uses
  SysUtils;

procedure RegistrarErro(const AContexto: String; E: Exception);

implementation

function ArquivoLog: String;
begin
  Result := ExtractFilePath(ParamStr(0)) + 'erros.log';
end;

procedure RegistrarErro(const AContexto: String; E: Exception);
var
  Log: TextFile;
begin
  try
    AssignFile(Log, ArquivoLog);

    if FileExists(ArquivoLog) then
      Append(Log)
    else
      Rewrite(Log);

    try
      Writeln(Log, 'Data/Hora: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', Now));
      Writeln(Log, 'Contexto: ' + AContexto);
      Writeln(Log, 'Classe: ' + E.ClassName);
      Writeln(Log, 'Mensagem: ' + E.Message);
      Writeln(Log, '----------------------------------------');
    finally
      CloseFile(Log);
    end;
  except
    { O sistema não deve parar caso nem o log possa ser gravado. }
  end;
end;

end.
