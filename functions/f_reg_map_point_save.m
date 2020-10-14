function f_reg_map_point_save(app)

if ~isempty(app.map_pt)
    n_mouse = strcmpi([app.data_all.wf_fname], app.WFimageDropDownMapping.Value);
    
    for n_pt = 1:numel(app.map_pt)
        if app.data_all(n_mouse).wf_mapping_regions{app.current_mapping_plot,n_pt}
            app.data_all(n_mouse).wf_mapping_regions_coords{app.current_mapping_plot,n_pt} = {app.map_pt{n_pt}.Position};
        end
    end
end

end