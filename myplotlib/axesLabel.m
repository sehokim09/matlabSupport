function ha = axesLabel(ax, labelText, offset, varargin)
% tileLabel adds a text label aligned to a specific tile
% in a tiledlayout.
%
% Usage:
%   tileLabel(t, labelText)
%   tileLabel(..., 'FontSize', 12, 'Color', 'k', ...)
%
% Inputs:
%   ax        - Axes object (from nexttile)
%   labelText - Text to display
%   varargin  - Name-value pairs passed to annotation

% Get normalized positions
left = ax.Position(1);
top = ax.Position(2) + ax.Position(4);

% Adjust x-position for label (a bit to the left of tile edge)
xLabel = left;
yLabel = top - offset;

% Use a tall, narrow annotation box (swapped width/height due to rotation)
ha = annotation('textbox', [xLabel, yLabel, 0.03, 0.03], ...
    'String', labelText, ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle', ...
    varargin{:});
end
