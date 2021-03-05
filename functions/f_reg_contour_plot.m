function f_reg_contour_plot(app)
%value = app.ContourButton.Value;
kern_pix_sd = 3;
kernel_half_size = ceil(sqrt(-log(0.1)*2*kern_pix_sd^2));
[X_gaus,Y_gaus] = meshgrid((-kernel_half_size):kernel_half_size);
conv_kernel = exp(-(X_gaus.^2 + Y_gaus.^2)/(2*kern_pix_sd^2));
conv_kernel = conv_kernel/sum(conv_kernel(:));

thresh = .6;

for n_db = 3%:numel(app.data_all)
    figure;
    all_freqs = app.data_all(n_db).wf_mapping_im;
    %max_val = max(max(cat(1,all_freqs{:})));
    for n_freq = 1:10
        im_pre = all_freqs{n_freq};
        im_sm = conv2(im_pre,conv_kernel, 'same');
        subplot(2,5,n_freq); hold on;
        max_val = max(im_sm(:));
        im_sm2 = im_sm/max_val;
        imagesc(im_sm2);
        %caxis([0 1]);
        contour(im_sm2>(thresh),1, 'LineColor', 'r')
    end
end


app.data_all(1).wf_mapping_regions_coords
app.data_all(1).wf_mapping_regions


color1 = {'r', 'b', 'g', 'k'};
n_dset = 5;
[num_freqs, num_groups] = size(app.data_all(n_dset).wf_mapping_regions);
figure; hold on;
for n_gr = 1:num_groups
    for n_freq = 1:num_freqs
        if app.data_all(n_dset).wf_mapping_regions(n_freq,n_gr).Variables
            coord = app.data_all(n_dset).wf_mapping_regions_coords{n_freq,n_gr};
            plot(coord(1), coord(2), 'o', 'Color', color1{n_gr});
        end
    end
end


end