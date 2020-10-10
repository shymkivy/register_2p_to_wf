function comb_im = f_apply_tform(tform, image_wf, image_2p)

movingRegistered = imwarp(image_2p,tform,'OutputView',imref2d(size(image_wf)));
comb_im = image_wf;
comb_im(movingRegistered>0) = movingRegistered(movingRegistered>0);

end