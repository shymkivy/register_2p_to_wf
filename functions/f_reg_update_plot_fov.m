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
        app.fov_axes = imagesc(app.FOV_axes, plot_im);
        axis(app.FOV_axes, 'tight');
    end
    
    app.fov_axes.CData = plot_im;
    [d1, d2] = size(plot_im);
    if app.PlotinmicronsCheckBox.Value
        app.fov_axes.XData = [1, d2]*data2.fov_pix_val/d2;
        app.fov_axes.YData = [1, d1]*data2.fov_pix_val/d1;
        xlabel(app.FOV_axes,'um');
        ylabel(app.FOV_axes,'um');
    else
        app.fov_axes.XData = [1, d2];
        app.fov_axes.YData = [1, d1];
        xlabel(app.FOV_axes,'pixels');
        ylabel(app.FOV_axes,'pixels');
    end
end

end