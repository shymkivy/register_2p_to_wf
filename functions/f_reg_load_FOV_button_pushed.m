function f_reg_load_FOV_button_pushed(app)

if numel(app.DataTree.Children) < 1
    uialert(app.UIFigure, 'First load widefield frame' ,'Warning','Icon','warning');
elseif isempty(app.DataTree.SelectedNodes)
    uialert(app.UIFigure, 'First select widefield parent frame' ,'Warning','Icon','warning');
else
    [~,fname,~] = fileparts(app.FOVpathEditField.Value);
    
    file_exists = sum(strcmpi([app.data.data_fov.fov_fname], fname));

    if ~file_exists
        [fov_data.fov_im, fov_data.fov_fname] = f_reg_load_image(app.FOVpathEditField.Value);
        fov_data.fov_data.fov_fname_link = {app.DataTree.SelectedNodes(1).Text};
        
        f_reg_add_fov(app, fov_data)

        f_reg_update_gui_data(app)
    end
end




end