function f_reg_contour_plot(app)
1
%value = app.ContourButton.Value;

kern_pix_sd = 5;
kernel_half_size = ceil(sqrt(-log(0.1)*2*kern_pix_sd^2));
[X_gaus,Y_gaus] = meshgrid((-kernel_half_size):kernel_half_size);
conv_kernel = exp(-(X_gaus.^2 + Y_gaus.^2)/(2*kern_pix_sd^2));
conv_kernel = conv_kernel/sum(conv_kernel(:));

figure;
n_freq = 5;
for n_db = 1:numel(app.data_all)
    im_pre = app.data_all(n_db).wf_mapping_im{n_freq};
    im_sm = conv2(im_pre,conv_kernel, 'same');
    subplot(2,5,n_db);
    imagesc(im_sm);
end
    






figure; imagesc(im_pre)



[f, x] = ksdensity(im_sm(:));
figure; 
plot(x, f)

figure; 
[M,c] = contour(im_sm,'ShowText','on');



C = contourc(im_sm)

[X, Y] = meshgrid(1:183, 1:206);
figure;
[M3,c] = contour(X,Y,im_sm,5,'ShowText','on')

end