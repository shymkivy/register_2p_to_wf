function f_reg_initialize(app)
app.fov_axes = imagesc(app.FOV_axes, 0);
axis(app.FOV_axes, 'tight');
app.fov_axes.ButtonDownFcn = @(~,~) f_reg_button_down(app, app.fov_axes);

app.wf_axes = imagesc(app.WF_axes, 0);
axis(app.WF_axes, 'tight');
app.wf_axes.ButtonDownFcn = @(~,~) f_reg_button_down(app, app.wf_axes);

app.wf_axes_map = imagesc(app.WF_axes_mapping, 0);
axis(app.WF_axes_mapping, 'tight');
%app.im_accepted.ButtonDownFcn = @(~,~) f_cs_button_down(app, app.im_accepted, 'accepted');

app.imagesDBpathEditField.Value = [app.ops.gui_dir '\' app.ops.database_fname];
app.tformDBpathEditField.Value = [app.ops.gui_dir '\' app.ops.tform_fname];
app.SavedataEditField.Value = [app.ops.gui_dir '\' app.ops.save_fname];

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