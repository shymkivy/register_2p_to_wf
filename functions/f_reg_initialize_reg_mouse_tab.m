function f_reg_initialize_reg_mouse_tab(app)


num_mice = numel(app.data_all);

app.mousenumberSpinner.Limits(1) = 1;
app.mousenumberSpinner.Limits(2) = num_mice;

if ~isfield(app.data_all, 'wf_mapping_freqs')
    for n_ms = 1:num_mice
        num_freqs = numel(app.data_all(n_ms).wf_mapping_title);
        app.data_all(n_ms).wf_mapping_freqs = zeros(num_freqs,1);
        for n_fr = 1:num_freqs
            app.data_all(n_ms).wf_mapping_freqs(n_fr) = str2double(app.data_all(n_ms).wf_mapping_title{n_fr}(4:end-4));
        end
    end
end

app.freqnumberSpinner.Limits(1) = 1;
app.freqnumberSpinner.Limits(2) = numel(app.data_all(1).wf_mapping_title);

f_reg_update_mouse_align(app);

x = cat(1,app.data_all.wf_mapping_title);
freqs = zeros(numel(x),1);
for n_fr = 1:numel(x)
    freqs(n_fr) = str2double(x{n_fr}(4:end-4));
end

%%
app.regionnumSpinner.Limits(2) = numel(app.ops.mapping_regions);

if ~isfield(app.data_all, 'region_borders')
    for n_ms = 1:num_mice
        app.data_all(n_ms).region_borders = cell(numel(app.ops.mapping_regions),1);
    end
end

end