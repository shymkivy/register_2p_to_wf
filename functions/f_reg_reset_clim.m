function f_reg_reset_clim(app)

app.fov_axes.Parent.CLim(1) = min(app.fov_axes.CData(:));
app.fov_axes.Parent.CLim(2) = max(app.fov_axes.CData(:));

app.CLimminEditField.Value = min(app.fov_axes.CData(:));
app.CLimmaxEditField.Value = max(app.fov_axes.CData(:));

end