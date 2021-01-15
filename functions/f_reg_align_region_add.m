function f_reg_align_region_add(app)

if ~isempty(app.AddregionEditField.Value)
    if ~sum(strcmpi(app.AddregionEditField.Value, app.mapping_regions))
        app.mapping_regions = [app.mapping_regions, {app.AddregionEditField.Value}];

        if ~isfield(app.data_all, 'wf_mapping_regions')
            app.data_all(1).wf_mapping_regions = [];
            app.data_all(1).wf_mapping_regions_coords = [];
        end

        num_freqs = numel(app.data_all(1).wf_mapping_title);

        mapping_regions.(app.AddregionEditField.Value) = ones(num_freqs,1);
        mapping_regions_coords.(app.AddregionEditField.Value) = cell(num_freqs,1);

        for n_ms = 1:num_freqs
            app.data_all(n_ms).wf_mapping_regions = [app.data_all(n_ms).wf_mapping_regions, struct2table(mapping_regions)];
            app.data_all(n_ms).wf_mapping_regions_coords = [app.data_all(n_ms).wf_mapping_regions_coords, struct2table(mapping_regions_coords)];
        end
    else
        f_reg_yell(app, 'This region name already exists');
    end
else
    f_reg_yell(app, 'Write a title first');
end

end