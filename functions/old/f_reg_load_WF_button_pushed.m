function f_reg_load_WF_button_pushed(app)

% obsolete

[~,fname,~] = fileparts(app.WidefieldpathEditField.Value);

file_exists = sum(strcmpi([app.data.data_wf.wf_fname], fname));

if ~file_exists
    [temp1.wf_im, temp1.wf_fname] = f_reg_load_image(app.WidefieldpathEditField.Value);
    
    f_reg_add_wf(app, temp1);
    
    f_reg_update_gui_data(app)
end

end
