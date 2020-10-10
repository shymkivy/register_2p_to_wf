function f_reg_point_on(app)

if app.PointsonButton.Value
    f_reg_points_add(app);
else
    f_reg_points_remove(app);
end

end