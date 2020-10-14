function f_reg_map_point_add(app)

n_mouse = strcmpi([app.data_all.wf_fname], app.WFimageDropDownMapping.Value);
db_wf = app.data_all(n_mouse);

pt_list = cell(numel(app.mapping_regions),1);
for n_reg = 1:numel(app.mapping_regions)
    if db_wf.wf_mapping_regions{app.current_mapping_plot,n_reg}
        if ~isempty(db_wf.wf_mapping_regions_coords{app.current_mapping_plot,n_reg}{1})
            coords1 = db_wf.wf_mapping_regions_coords{app.current_mapping_plot,n_reg}{1};
        else
            coords1 = size(app.wf_axes_map.CData)/2;
        end
        pt_list{n_reg} = images.roi.Point(app.WF_axes_mapping, 'Color', app.map_pt_colors{n_reg}, 'Position',[coords1]);
        pt_list{n_reg}.Label = app.mapping_regions{n_reg};
    end
end
app.map_pt = pt_list;

end