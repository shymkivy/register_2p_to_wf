function f_reg_update_gui_data(app)

f_reg_update_dropdown(app);

%% first wf
if isempty(app.WF_axes.Children)
    f_reg_update_plot_wf(app);
end

%% now fov

if isempty(app.FOV_axes.Children)
    f_reg_update_plot_fov(app);
end

end