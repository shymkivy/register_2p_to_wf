function f_reg_update_plot_wf(app)

if ~isempty(app.WFimageDropDown.Value)
    db_wf = f_reg_get_current_wf_reg(app);
    plot_im = db_wf.wf_im{1};
    
    
    
    if find([app.ButtonGroup.Buttons.Value]) == 2
        [~, db_reg] = f_reg_get_current_wf_reg(app);
        if ~strcmpi(db_reg.current_tform, '0')
            
            if strcmpi([db_reg.fov_fname],app.FOVimageDropDown.Value)
                im_2p = db_reg.fov_im;
            elseif strcmpi([db_reg.fov_surface_fname],app.FOVimageDropDown.Value)
                im_2p = db_reg.fov_surface_im;
            end
            
            tform1 = db_reg.regions_tforms(str2double(db_reg.current_tform)).tform;
            plot_im = f_apply_tform(tform1, plot_im, im_2p);
        end
    elseif find([app.ButtonGroup.Buttons.Value]) == 3
        for n_reg = 1:numel(db_wf.regions)
            db_reg1 = db_wf.regions(n_reg);
            if numel(db_reg1.regions_tforms)
                tform1 = db_reg1.regions_tforms(str2double(db_reg1.current_tform)).tform;
                
                % maybe fix this later ()
                if app.current_fov_is_surface
                    if ~isempty(db_reg1.fov_surface_im)
                        im_2p = db_reg1.fov_surface_im;
                    elseif ~isempty(db_reg1.fov_im)
                        im_2p = db_reg1.fov_im;
                    end
                else
                    if ~isempty(db_reg1.fov_im)
                        im_2p = db_reg1.fov_im;
                    elseif ~isempty(db_reg1.fov_surface_im)
                        im_2p = db_reg1.fov_surface_im;
                    end
                end
                

                plot_im = f_apply_tform(tform1, plot_im, im_2p);
            end
        end
    end
    
    if isempty(app.WF_axes.Children)
        app.wf_axes = imagesc(app.WF_axes, plot_im); axis(app.WF_axes, 'tight');
    end
    
    % extract pixel size from AC data xlsx
    idx_var = strcmpi(app.data_xlsx.Properties.VariableNames, 'cam_um_pix');
    if sum(idx_var)
        idx_dset = strcmpi(app.data_xlsx.mapping_wf_frame, app.WFimageDropDown.Value);
        if sum(idx_dset)
            cam_pix_all = app.data_xlsx(idx_dset,idx_var).Variables;
        end
    end
    
    app.wf_axes.CData = plot_im;
    [d1, d2] = size(plot_im);
    if numel(cam_pix_all)
        app.wf_axes.XData = [1, d1]*cam_pix_all(1);
        app.wf_axes.YData = [1, d2]*cam_pix_all(1);
        xlabel(app.WF_axes,'um');
        ylabel(app.WF_axes,'um');
    else
        app.wf_axes.XData = [1, d1]*cam_pix_all(1);
        app.wf_axes.YData = [1, d2]*cam_pix_all(1);
        xlabel(app.WF_axes,'pixels');
        ylabel(app.WF_axes,'pixels');
    end
end

end