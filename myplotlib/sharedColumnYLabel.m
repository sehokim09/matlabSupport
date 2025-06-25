function ha = sharedColumnYLabel(t, colIdx, labelText, varargin)
% sharedColumnYLabel adds a vertical y-label aligned to a specific column
% in a tiledlayout.
%
% Usage:
%   sharedColumnYLabel(t, colIdx, labelText)
%   sharedColumnYLabel(..., 'FontSize', 12, 'Color', 'k', ...)
%
% Inputs:
%   t         - Tiled layout object (from tiledlayout)
%   colIdx    - Column index (1-based)
%   labelText - Text to display
%   varargin  - Name-value pairs passed to annotation

% Get layout size
[numRows, numCols] = deal(t.GridSize(1), t.GridSize(2));

if colIdx > numCols || colIdx < 1
    error('Column index %d is out of bounds (1 to %d).', colIdx, numCols);
end

% Get tile indices for the entire column
tileIndices = (0:numRows-1)*numCols + colIdx;

% Get position of the top and bottom tile in this column
topTileAx = nexttile(t, tileIndices(1));
bottomTileAx = nexttile(t, tileIndices(end));

% Get normalized positions
left = topTileAx.Position(1);
bottom = bottomTileAx.Position(2);
top = topTileAx.Position(2) + topTileAx.Position(4);
height = top - bottom;

% Get figure aspect ratio (width / height)
figPos = get(gcf, 'Position');  % [left bottom width height] in pixels
aspectRatio = figPos(4) / figPos(3);  % height / width

% Convert height from normalized figure height → normalized figure width
height_in_width_units = height * aspectRatio;

% Annotation box
boxWidth = height_in_width_units;   % spans vertical height, rotated
boxHeight = 0.03;                   % visually narrow when rotated

% Adjust x-position for label (a bit to the left of tile edge)
xOffset = 0.03;
xLabel = left - xOffset;

% Use a tall, narrow annotation box (swapped width/height due to rotation)
ha = annotation('textbox', [xLabel, bottom, boxWidth, boxHeight], ...
    'String', labelText, ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle', ...
    'Rotation', 90, ...
    varargin{:});
end
