function cb = setUpArcticXYmap(ax, land, landColor, projection, cmapIn, levelsIn, clabel)    
    % ax = axes('Parent', parent);
    hold on; box on
    set(ax, 'XTick', [], 'YTick', []);

    xlim([-3500 3300])
    ylim([-3000 3800])

    % Draw and fill land areas
    for k = 2:length(land)
        [xProj, yProj] = projfwd(projcrs(projection), land(k).Lat, land(k).Lon); % Convert
        iNan = find(isnan(xProj));
        iNan = [1, iNan, length(xProj)];
        if k == 2 % Fix k = 2
            xProj(iNan(2)-1) = NaN; 
            xProj(iNan(3)-1) = NaN;
            yProj(iNan(2)-1) = NaN; 
            yProj(iNan(3)-1) = NaN;
            iNan(2) = [];
        end
        for iPoly = 1 : length(iNan) - 1
            idx = iNan(iPoly):iNan(iPoly+1);
            xp = xProj(idx);
            yp = yProj(idx);
            xp(isnan(xp)) = [];
            yp(isnan(yp)) = [];
            hp = patch(xp/1e3, yp/1e3, landColor);
            % uistack(hp, 'bottom')
        end
    end

    % set colormap and color limits
    colormap(ax, cmapIn)
    clim(ax,[min(levelsIn) max(levelsIn)])

    % add labeled color bar
    cb = colorbar;
    cb.Ticks = levelsIn;
    cb.Label.String = clabel;

    axis square
end