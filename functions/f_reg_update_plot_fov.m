function f_reg_update_plot_fov(app)

if ~isempty(app.FOVimageDropDown.Value)
    current_wf = strcmpi([app.data_all.wf_fname], app.WFimageDropDown.Value);
    data1 = app.data_all(current_wf).regions;
    current_region = strcmpi([data1.region_name],app.RegionDropDown.Value);
    data2 = data1(current_region);
    
    if strcmpi([data2.fov_fname],app.FOVimageDropDown.Value)
        plot_im = data2.fov_im;
    elseif strcmpi([data2.fov_surface_fname],app.FOVimageDropDown.Value)
        plot_im = data2.fov_surface_im;
    end

    f_reg_set_clim(app);
    
    if isempty(app.FOV_axes.Children)
        app.fov_axes = imagesc(app.FOV_axes, plot_im); axis(app.FOV_axes, 'tight');
    else
        app.fov_axes.CData = plot_im;
    end
end

end