function f_reg_map_point_remove(app)

if ~isempty(app.map_pt)
    for n_pt = 1:numel(app.map_pt)
        delete(app.map_pt{n_pt})
    end
    app.map_pt = [];
end

end