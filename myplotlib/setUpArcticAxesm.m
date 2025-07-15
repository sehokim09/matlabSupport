function setUpArcticAxesm(cmapIn, levelsIn, clabel)
    % create axesm-based map
    abm = axesm("stereo",Origin=[90 0 0],Grid="on",GColor="w");

    % zoom in to arctic region
    nlim = 0.45;
    set(abm,XLim=[-nlim nlim],YLim=[-nlim nlim])

    % set colormap and color limits
    colormap(abm, cmapIn)
    clim(abm,[min(levelsIn) max(levelsIn)])

    % add labeled color bar
    cb = colorbar;
    cb.Ticks = levelsIn;
    cb.Label.String = clabel;
end