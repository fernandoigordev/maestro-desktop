unit Utils.Factory.DataSet;

interface

uses
  FireDAC.Comp.Client;

function GetQuery: TFDQuery;overload;
function GetQuery(ASql: String): TFDQuery;overload;

implementation
uses
  Entity.Connection;

function GetQuery: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := TEntityConnection.GetInstance.FDConnection;
end;

function GetQuery(ASql: String): TFDQuery;
begin
  Result := GetQuery;
  Result.SQL.Text := ASql;
end;

end.
