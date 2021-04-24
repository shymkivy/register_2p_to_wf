function f_reg_update_mouse_align(app)

n_ms = app.mousenumberSpinner.Value;

n_fr = app.freqnumberSpinner.Value;

current_wf = app.data_all(n_ms).wf_mapping_im{n_fr};

app.wf_axes_map_mouse.CData = current_wf;

current_coords = app.data_all(n_ms).wf_mapping_regions_coords(n_fr,:);

num_reg = 4;
for n_reg = 1:num_reg
    if ~isempty(current_coords{n_reg})
        app.wf_axes_map_mouse_plt{n_reg}.XData = current_coords{n_reg}(1);
        app.wf_axes_map_mouse_plt{n_reg}.YData = current_coords{n_reg}(2);
    else
        app.wf_axes_map_mouse_plt{n_reg}.XData = [];
        app.wf_axes_map_mouse_plt{n_reg}.YData = [];
    end
end

end