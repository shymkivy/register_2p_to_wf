function f_reg_save_data(app)

data_all = app.data_all;
save_path = app.SavedataEditField.Value;
[path1, fname1, ~] = fileparts(save_path);
save([path1, '\', fname1, '.mat'], 'data_all');

end