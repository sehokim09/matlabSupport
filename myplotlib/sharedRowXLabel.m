function sharedRowXLabel(t, rowIdx, labelText, varargin)
% sharedRowXLabel adds a shared x-label to a specific row in a tiledlayout.
%
% Usage:
%   sharedRowXLabel(t, rowIdx, labelText)
%   sharedRowXLabel(..., 'FontSize', 12, 'Color', 'k')

% Get layout size
[numRows, numCols] = deal(t.GridSize(1), t.GridSize(2));

if rowIdx > numRows || rowIdx < 1
    error('Row index %d is out of bounds (1 to %d).', rowIdx, numRows);
end

% Get tile indices for the entire row
startIdx = (rowIdx - 1)*numCols + 1;
tileIndices = startIdx:(startIdx + numCols - 1);

% Get positions of leftmost and rightmost tile in the row
leftTileAx = nexttile(tileIndices(1), t);
rightTileAx = nexttile(tileIndices(end), t);

left = leftTileAx.Position(1);
right = rightTileAx.Position(1) + rightTileAx.Position(3);
bottom = leftTileAx.Position(2);

width = right - left;
height = 0.03;  % Height of label box

% Adjust y-position slightly below tiles
yOffset = 0.04;
yLabel = bottom - yOffset;

% Add annotation textbox
annotation('textbox', [left, yLabel, width, height], ...
    'String', labelText, ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle', ...
    varargin{:});
end
