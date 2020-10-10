function f_reg_points_remove(app)

if ~isempty(app.ptwf)
    for n_pt = 1:numel(app.ptwf)
        delete(app.ptwf{n_pt})
    end
    app.ptwf = [];
end

if ~isempty(app.pt2p)
    for n_pt = 1:numel(app.pt2p)
        delete(app.pt2p{n_pt})
    end
    app.pt2p = [];
end

app.UITablePoints.Data = [];

end