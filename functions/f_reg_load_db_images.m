function f_reg_load_db_images(app)

filepath = app.imagesDBpathEditField.Value;
[~,~,ext] = fileparts(filepath);

if strcmpi(ext, '.mat')
    data = load(filepath);
    if isfield(data, 'wf_data') || isfield(data, 'fov_data')
        if isfield(data, 'wf_data')
            f_reg_add_wf(app, data.wf_data);
        end
        if isfield(data, 'fov_data')
            f_reg_add_fov(app, data.fov_data);
        end
    else
        messege1 = sprintf('Your database a table of fov_data or wf_data');
        uialert(app.UIFigure, messege1 ,'Warning','Icon','warning');
    end
end 

end