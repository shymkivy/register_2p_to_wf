function f_reg_load_db_tform(app)

if isempty(app.data_all)
    messege1 = sprintf('Load images db first');
    uialert(app.UIFigure, messege1 ,'Warning','Icon','warning');
else

    data_load = load(app.tformDBpathEditField.Value);

    if isstruct(data_load.tform_data)
        tform_data = struct2table(data_load.tform_data);
    else
        tform_data = data_load.tform_data;
    end

    db = app.data_all;

    fov_found = false(numel([tform_data.wf_fname]),1);
    for n_tf = 1:numel([tform_data.wf_fname])
        tform_data1 = tform_data(n_tf,:);
        current_fov = tform_data1.fov_fname;
        for n_wf = 1:numel(db)
            for n_reg = 1:numel(db(n_wf).regions)
                db2 = db(n_wf).regions(n_reg);
                matching_fov = strcmpi(current_fov, db2.fov_fname);
                if sum(matching_fov)
                    fov_found(n_tf) = 1;

                    tform1(1).tform_num = [];
                    tform1(1).tform = tform_data1.tform;
                    tform1(1).xy2p = tform_data1.xy2p;
                    tform1(1).xywf = tform_data1.xywf;
                    if isempty(db(n_wf).regions(n_reg).regions_tforms)
                        tform1.tform_num = '1';
                        db(n_wf).regions(n_reg).regions_tforms = tform1;
                        db(n_wf).regions(n_reg).current_tform = '1';
                    else
                        num_trofms = numel({db(n_wf).regions(n_reg).regions_tforms.tform});
                        % check for matching tforms
                        ident_tform = 0;
                        for n_tforms = 1:num_trofms
                            temp_tform = db(n_wf).regions(n_reg).regions_tforms(n_tforms).tform.T;
                            if prod(tform1.tform.T(:) == temp_tform(:))
                                ident_tform = 1;
                            end
                        end
                        if ~ident_tform
                            tform1.tform_num = num2str(num_trofms + 1);
                            db(n_wf).regions(n_reg).regions_tforms = [db(n_wf).regions(n_reg).regions_tforms; tform1];
                        end
                    end
                end

            end
        end
    end

    if ~prod(fov_found)
        messege1 = sprintf('%d tforms were not matched to db ( %s)', sum(~fov_found), [tform_data.fov_fname{~fov_found} ' ']);
        uialert(app.UIFigure, messege1 ,'Warning','Icon','warning');
    end

    app.data_all = db;
    f_reg_update_dropdown(app);
    f_reg_point_on(app);
    
end

end