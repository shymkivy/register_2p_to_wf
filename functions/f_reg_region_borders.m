function f_reg_region_borders(app)

n_ms = app.mousenumberSpinner.Value;

rois = app.data_all(n_ms).region_borders;
graphics1 = app.app_data.graphics;

if app.regionbordersonButton.Value
    for n_reg = 1:numel(rois)
        if isgraphics(rois{n_reg})
            roi1.Position = rois{n_reg}.Position(rois{n_reg}.Waypoints,:);
            roi1.Waypoints = true(size(roi1.Position,1),1);
        elseif ~isempty(rois{n_reg})
            roi1 = rois{n_reg};
        else
            roi1 = [];
        end
        if ~isempty(roi1)
            roi2 = drawfreehand(app.WF_axes_mapping_mouse, 'Color', app.map_pt_colors{n_reg}, 'Position', roi1.Position, 'Waypoints', roi1.Waypoints);
            graphics1{n_reg} = roi2;
        end
    end
else
    for n_reg = 1:numel(rois)
        if ~isempty(graphics1{n_reg})
            roi1.Position = graphics1{n_reg}.Position;
            roi1.Waypoints = graphics1{n_reg}.Waypoints;
            delete(graphics1{n_reg});
            rois{n_reg} = roi1;
        end
    end
end

app.data_all(n_ms).region_borders = rois;
app.app_data.graphics = graphics1;
%im_all = cat(3,app.data_all(1).wf_mapping_im{:});
%f_save_tif_stack2_YS(im_all, [pwd '\tuning.tif'])

end