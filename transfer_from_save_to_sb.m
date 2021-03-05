% transfer from save to DB
data_all_s = load('reg_save.mat');
data_all_s = data_all_s.data_all;
data_all = load('reg_images_db.mat');
data_all = data_all.data_all;

for n_ms = 1:10
    data_all(n_ms).wf_mapping_regions = data_all_s(n_ms).wf_mapping_regions;
    data_all(n_ms).wf_mapping_regions_coords = data_all_s(n_ms).wf_mapping_regions_coords;
    
    for n_reg = 1:numel(data_all(n_ms).regions)
        data_all_s(n_ms).regions(n_reg).region_name;
        
        n_reg2 = strcmpi(data_all_s(n_ms).regions(n_reg).region_name, [data_all(n_ms).regions.region_name]);
        
        data_all(n_ms).regions(n_reg2).regions_tforms = data_all_s(n_ms).regions(n_reg).regions_tforms;
        data_all(n_ms).regions(n_reg2).current_tform = data_all_s(n_ms).regions(n_reg).current_tform;
    end
    
end
    