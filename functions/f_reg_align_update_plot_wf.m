function f_reg_align_update_plot_wf(app)

if ~isempty(app.WFimageDropDownMapping.Value)
    cr_plot = app.current_mapping_plot;
    db_wf = app.data_all(strcmpi([app.data_all.wf_fname], app.WFimageDropDownMapping.Value));
    
    plot_im = db_wf.wf_mapping_im{cr_plot};
    
    if isempty(app.WF_axes_mapping.Children)
        app.wf_axes_map = imagesc(app.WF_axes_mapping, plot_im); axis(app.WF_axes_mapping, 'tight');
    else
        app.wf_axes_map.CData = plot_im;
    end
end

end