function f_reg_region_borders(app)

n_ms = app.mousenumberSpinner.Value;

rois = app.data_all(n_ms).region_borders;

if app.regionbordersonButton.Value
    for n_reg = 1:numel(rois)
        if isstruct(rois{n_reg})
            roi1 = rois{n_reg};
            roi2 = drawfreehand(app.WF_axes_mapping_mouse, 'Color', app.map_pt_colors{n_reg}, 'Position', roi1.Position, 'Waypoints', roi1.Waypoints);
            rois{n_reg} = roi2;
        end
    end
else
    for n_reg = 1:numel(rois)
        if ~isempty(rois{n_reg})
            roi1.Position = rois{n_reg}.Position;
            roi1.Waypoints = rois{n_reg}.Waypoints;
            delete(rois{n_reg});
            rois{n_reg} = roi1;
        end
    end
end

%app.data_all(n_ms).region_borders = rois;
%im_all = cat(3,app.data_all(1).wf_mapping_im{:});
%f_save_tif_stack2_YS(im_all, [pwd '\tuning.tif'])

end