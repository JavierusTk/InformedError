unit InformedErrorInterface;

interface

type
  IInformedError = interface ['{578FA3B7-0186-45D3-AFED-8D3569AA8F9A}']
    function Error:boolean;
    function Ok:boolean;
    function ErrorDescription:string;
    procedure AddError(const pErrorDescription:string);
    function AddErrors(const pError:IInformedError):IInformedError;
  end;




implementation

end.
