function f_reg_register_wf(app)

anchor_dset = app.AnchordsetSpinner.Value;

num_dset = numel(app.data_all);
num_reg = 4;

region_means = zeros(num_dset, num_reg, 2); 
for n_dset = 1:num_dset
    coords = app.data_all(n_dset).wf_mapping_regions_coords;
    for n_reg = 1:num_reg
        temp1 = coords(:,n_reg);
        region_means(n_dset, n_reg, :) = mean(cat(1,temp1{:}));
    end  
end

tform_all = cell(num_dset,1);

for n_dset = 1:num_dset
    tform_all{n_dset} = fitgeotrans(squeeze(region_means(n_dset,:,:)),squeeze(region_means(anchor_dset,:,:)) ,'nonreflectivesimilarity');
end

app.wf_tform_all = tform_all;


%movingRegistered = imwarp(image_2p,tform21,'OutputView',imref2d(size(image_wf)));
%comb_im(movingRegistered>0) = movingRegistered(movingRegistered>0);


end