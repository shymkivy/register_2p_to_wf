function f_reg_add_wf(app, wf_data)

%% check if required colums are present
wf_cols = app.ops.wf_data_columns;
for n_col = 1:numel(wf_cols)
    temp_cols = strcmpi(wf_cols{n_col},fields(wf_data));
    if ~sum(temp_cols)
        wf_cols(temp_cols)
        messege1 = sprintf('Your database needs a "%s" column in wf_data table', wf_cols{n_col});
        uialert(app.UIFigure, messege1 ,'Warning','Icon','warning');
    end
end


%% check if data is present
if isempty(app.data_all)
    current_mouse_idx = 1;
else
    current_mouse_idx = numel([app.data_all.(wf_cols{1})]) + 1;
end
num_load_data = numel(wf_data.(wf_cols{1}));

%%
changes = 0;
for n_dat = 1:num_load_data
    temp_data = wf_data(n_dat,:);
    
    if current_mouse_idx>1
        wf_exists = sum(strcmpi([app.data_all.wf_fname], temp_data.wf_fname));
    else
        wf_exists = 0;
    end
    
    if ~wf_exists
        data1(1).mouse_num = current_mouse_idx;
        data1(1).mouse_tag = temp_data.mouse_tag;
        data1(1).wf_fname = temp_data.wf_fname;
        data1(1).wf_im = temp_data.wf_im;
        data1(1).regions = {};
        
        if isempty(app.data_all)
            app.data_all = data1;
        else
            app.data_all = [app.data_all; data1];
        end
        
        changes = changes + 1;
        current_mouse_idx = current_mouse_idx + 1;
    end
end
if changes
    f_reg_update_dropdown(app);
    f_reg_update_plot_wf(app);
    f_reg_update_plot_fov(app);
end


%% add data











end