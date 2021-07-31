function f_reg_region_draw(app)

n_reg = app.regionnumSpinner.Value;
n_ms = app.mousenumberSpinner.Value;

if ~isempty(app.data_all(n_ms).region_borders{n_reg})
    delete(app.data_all(n_ms).region_borders{n_reg});
end
roi = drawfreehand(app.WF_axes_mapping_mouse, 'Color', app.map_pt_colors{n_reg});
app.data_all(n_ms).region_borders{n_reg} = roi;

end