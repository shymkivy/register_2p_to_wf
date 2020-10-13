function f_reg_set_clim(app)

app.fov_axes.Parent.CLim(1) = app.CLimminEditField.Value;
app.fov_axes.Parent.CLim(2) = app.CLimmaxEditField.Value;

end