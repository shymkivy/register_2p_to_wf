function f_reg_update_mouse_align(app)

n_ms = app.mousenumberSpinner.Value;

n_fr = app.freqnumberSpinner.Value;

current_wf = app.data_all(n_ms).wf_mapping_im{n_fr};


if app.RegisteronButton.Value
    current_tform = app.wf_tform_all{n_ms};
    movingRegistered = imwarp(current_wf,current_tform ,'OutputView',imref2d(size(app.wf_axes_map_mouse.CData))); %
    %comb_im(movingRegistered>0) = movingRegistered(movingRegistered>0);
    app.wf_axes_map_mouse.CData = movingRegistered;
else
    app.wf_axes_map_mouse.CData = current_wf;
end

all_coords = app.data_all(n_ms).wf_mapping_regions_coords;

num_reg = numel(app.ops.mapping_regions);
for n_reg = 1:num_reg
    if app.CoordsonButton.Value
        temp_coord = all_coords(:,n_reg);
        temp_coord = cat(1,temp_coord{:});
    else
        temp_coord = all_coords{n_fr,n_reg};
    end
    
    if app.RegisteronButton.Value
        temp_coord2 = current_tform.T' * [temp_coord, ones(size(temp_coord,1),1)]';
        temp_coord3 = temp_coord2(1:2,:)';
    else
        temp_coord3 = temp_coord;
    end
    
    if ~isempty(temp_coord)
        app.wf_axes_map_mouse_plt{n_reg}.XData = temp_coord3(:,1);
        app.wf_axes_map_mouse_plt{n_reg}.YData = temp_coord3(:,2);
    else
        app.wf_axes_map_mouse_plt{n_reg}.XData = [];
        app.wf_axes_map_mouse_plt{n_reg}.YData = [];
    end
end


end