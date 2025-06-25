function ret = isArg(str)

% This function checks if an argument was supplied to the caller function
% and whether it is empty or not.
%
% :param str str: Name of the variable as a string
%
% :return bool ret: True if the argument is supplied and is not empty
%
% .. Tip:: Use this function to check if an argument is supplied and then
%          set default values
%
% Author: Marc Sanchez Net
% Date: 09/14/2016

% Check inputs
assert(ischar(str),'Input must be the name of the variable as a string');

% Ensure that the variable exists
call = sprintf('exist(''%s'',''var'') && ~isempty(%s)',str,str);
ret  = evalin('caller',call);