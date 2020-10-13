function f_reg_update_plot_wf(app)

if ~isempty(app.WFimageDropDown.Value)
    db_wf = f_reg_get_current_wf_reg(app);
    plot_im = db_wf.wf_im{1};
    
    if find([app.ButtonGroup.Buttons.Value]) == 2
        [~, db_reg] = f_reg_get_current_wf_reg(app);
        if ~strcmpi(db_reg.current_tform, '0')
            current_fov = strcmpi([db_reg.fov_fname], app.FOVimageDropDown.Value);
            im_2p = db_reg.fov_im{current_fov};
            tform1 = db_reg.regions_tforms(str2double(db_reg.current_tform)).tform;
            plot_im = f_apply_tform(tform1, plot_im, im_2p);
        end
    elseif find([app.ButtonGroup.Buttons.Value]) == 3
    end
    
    if isempty(app.WF_axes.Children)
        app.wf_axes = imagesc(app.WF_axes, plot_im); axis(app.WF_axes, 'tight');
    else
        app.wf_axes.CData = plot_im;
    end
end

end