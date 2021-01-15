function f_reg_align_line_add(app)

n_mouse = strcmpi([app.data_all.wf_fname], app.WFimageDropDownMapping.Value);
db_wf = app.data_all(n_mouse);

line_list = cell(numel(app.ops.mapping_regions),1);
for n_reg = 1:numel(app.ops.mapping_regions)
    if db_wf.wf_mapping_regions{app.current_mapping_plot,n_reg}
        if ~isempty(db_wf.wf_mapping_regions_coords{app.current_mapping_plot,n_reg}{1})
            coords1 = db_wf.wf_mapping_regions_coords{app.current_mapping_plot,n_reg}{1};
        else
            coords1 = size(app.wf_axes_map.CData)/2;
        end
        line_list{n_reg} = images.roi.Line(app.WF_axes_mapping, 'Color', app.map_pt_colors{n_reg}, 'Position',[20 20; 40 40]);
        line_list{n_reg}.Label = app.ops.mapping_regions{n_reg};
    end
end
app.map_pt = line_list;


end