function f_reg_initialize(app)
app.fov_axes = imagesc(app.FOV_axes, 0);
axis(app.FOV_axes, 'equal');
axis(app.FOV_axes, 'tight');
xlabel(app.FOV_axes,'pixels');
ylabel(app.FOV_axes,'pixels');
app.fov_axes.ButtonDownFcn = @(~,~) f_reg_button_down(app, app.fov_axes);

app.wf_axes = imagesc(app.WF_axes, 0);
axis(app.WF_axes, 'equal');
axis(app.WF_axes, 'tight');
xlabel(app.WF_axes,'pixels');
ylabel(app.WF_axes,'pixels');
app.wf_axes.ButtonDownFcn = @(~,~) f_reg_button_down(app, app.wf_axes);

app.wf_axes_map = imagesc(app.WF_axes_mapping, 0);
axis(app.WF_axes_mapping, 'equal');
axis(app.WF_axes_mapping, 'tight');
xlabel(app.WF_axes_mapping,'pixels');
ylabel(app.WF_axes_mapping,'pixels');
%app.im_accepted.ButtonDownFcn = @(~,~) f_cs_button_down(app, app.im_accepted, 'accepted');

app.DBpathEditField.Value = app.ops.database_path;  %[app.ops.gui_dir '\' app.ops.database_path];
app.xlsxpathEditField.Value = app.ops.xlsx_path;      %[app.ops.gui_dir '\' app.ops.tform_fname];
app.SaveDBpathEditField.Value = app.ops.save_path;  %[app.ops.gui_dir '\' app.ops.save_fname];

app.wf_axes_map_mouse = imagesc(app.WF_axes_mapping_mouse, 0);
hold(app.WF_axes_mapping_mouse, 'on');
axis(app.WF_axes_mapping_mouse, 'equal');

%% register mouse section
num_reg = 4;
app.wf_axes_map_mouse_plt = cell(num_reg,1);
for n_reg = 1:num_reg
    app.wf_axes_map_mouse_plt{n_reg} = plot(app.WF_axes_mapping_mouse, 0, 0, 'o', 'LineWidth', 3, 'Color', app.map_pt_colors{n_reg});
end

for n_reg = 1:num_reg
    app.wf_axes_map_mouse_plt{n_reg}.XData = [];
    app.wf_axes_map_mouse_plt{n_reg}.YData = [];
end


% wf_data.mouse_tag = [];
% wf_data.wf_fname = [];
% wf_data.wf_im = [];
% 
% fov_data.mouse_tag = [];
% fov_data.wf_fname = [];
% fov_data.area = [];
% fov_data.fov_fname = [];
% fov_data.fov_im = [];
% 
% app.data.fov_data = struct2table(fov_data);
% 
% tform_data.wf_fname = [];
% tform_data.fov_fname = [];
% tform_data.tform = [];
% tform_data.xy2p = [];
% tform_data.xywf = [];
% tform_data.selected = [];
% 
% app.data.tform_data = struct2table(tform_data);

end