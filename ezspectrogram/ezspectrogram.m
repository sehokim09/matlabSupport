function [T, F, ps, units] = ezspectrogram(s, fs, intv, noverlap, nfft, spectrumtype)

%{
% Wrapper function for Matlab's ``spectrogram``. It provides reasonable default 
% options to facilitate using this tools.
% 
% :param array s: Samples over time
% :param int fs: Sampling frequency in [Hz]
% :param float intv: (Optional) Interval of time that will be used to compute 
%                    each slice of the spectrogram. Defaults to 1 second.
% :param float noverlap: (Optional) Default number of samples to overlap
%                         between adjacent psd estimates over time. Default
%                         value is same sa Matlab's ``spectrogram``
% :param int nfft: (Optional) Number of samples to use for each psd
%                   estimation. Defaults to value in Matlab's
%                   ``spectrogram``.
% :param str spectrumtype: (Optional) Either 'psd' (default) or 'power';
% 
% :return matrix T: Matrix of times at which spectrogram is calculated
% :return matrix F: Matrix of frequencies at which spectrogram is calculated
% :return matrix ps: Spectrogram in [dB]
% 
% Usage Example
% -------------
% >> [T, F, ps, units] = myspectrogram(samples, fs);
% >> plot_spectrogram(T, F, ps, units);
% 
% Author: Marc Sanchez Net
% Date:   03/31/2020
% Copyright (c) 2020, Marc Sanchez Net
%}

% Default values
if ~isArg('intv'), intv = 1; end
if ~isArg('noverlap'), noverlap = []; end
if ~isArg('nfft'), nfft = []; end
if ~isArg('spectrumtype'), spectrumtype = 'psd'; end

% [sec] Calculate the sample duration
Ts = 1/fs;

% Calculate the number of samples per interval
window = floor(intv/Ts);

% Compute spectrogram using Welch's method
[~, f, t, ps] = spectrogram(s, window, noverlap, nfft, fs, ...
                            spectrumtype);

% Meshgrid
[T, F] = meshgrid(t, f);

% Transform to dB
ps = 10*log10(ps);

% Set units of the returned values
if strcmpi(spectrumtype, 'psd')
    units = '[dB/Hz]';
else
    units = '[dB]';
end

% If arguments out, return
if nargout > 0, return; end

% Otherwise, plot spectrogram
plot_spectrogram(T, F, ps, units);
