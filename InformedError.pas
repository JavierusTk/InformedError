unit InformedError;

interface

uses
  Classes,
  InformedErrorInterface;


type
  TInformedError = class(TInterfacedObject,IInformedError)
  strict private
    FError: boolean;
    FErrorList: TStringList;
  protected
    procedure AddError(const ErrorDescription:string);
  public
    function Error:boolean;
    function Ok:boolean;
    function ErrorDescription:string;
    function AddErrors(const aError:IInformedError):IInformedError;
    constructor Create;
    destructor Destroy; override;
    class function InformError(const ErrorDescription:string):IInformedError;
    class function InformErrorFmt(const ErrorDescription:string;Args:Array of const):IInformedError;
    class function InformOK:IInformedError;
  end;




implementation

uses
  SysUtils;


procedure TInformedError.AddError(const ErrorDescription:string);
var
  vListOfErrors: TStringList;
  i: integer;
begin
  vListOfErrors:=TStringList.Create;
  try
    vListOfErrors.Text:=ErrorDescription;
    if vListOfErrors.Count=1 then begin
      FError:=True;
      FErrorList.Add(vListOfErrors[0]);
     end
    else begin
      for i:=0 to vListOfErrors.Count-1 do
        AddError(vListOfErrors[i]);
    end;
  finally
    FreeAndNil(vListOfErrors);
  end;
end;

function TInformedError.AddErrors(const aError:IInformedError):IInformedError;
begin
  result:=Self;
  if aError.Error then
    result.AddError(aError.ErrorDescription);
end;

constructor TInformedError.Create;
begin
  inherited;
  FError:=False;
  FErrorList:=TStringList.Create;
end;

function TInformedError.ErrorDescription: string;
begin
  result:=FErrorList.Text;
end;

destructor TInformedError.Destroy;
begin
  FreeAndNil(FErrorList);
  inherited;
end;

function TInformedError.Error: boolean;
begin
  result:=FError;
end;

class function TInformedError.InformError(const ErrorDescription: string): IInformedError;
begin
  result:=Create;
  result.AddError(ErrorDescription);
end;

class function TInformedError.InformErrorFmt(const ErrorDescription: string; Args: array of const): IInformedError;
begin
  result:=InformError(Format(ErrorDescription,Args));
end;

class function TInformedError.InformOK: IInformedError;
begin
  result:=Create;
end;

function TInformedError.Ok: boolean;
begin
  result:=not Error;
end;



end.
