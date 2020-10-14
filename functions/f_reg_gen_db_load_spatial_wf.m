function im_list = f_reg_gen_db_load_spatial_wf(file_path)

[pathstr, name, ~] = fileparts(file_path);
f1 = open([pathstr '\' name '.fig']);

% parse fig
num_ch = numel(f1.Children);
im_list = cell(num_ch,2);
not_an_im = false(num_ch,1);
for n_ch = 1:num_ch
    if strcmpi(class(f1.Children(n_ch).Children), 'matlab.graphics.primitive.Image')
        im_list{n_ch,1} = f1.Children(n_ch).Children.CData;
        im_list{n_ch,2} = f1.Children(n_ch).Title.String;
    else
        not_an_im(n_ch) = 1;
    end
end

im_list(not_an_im,:) = [];

close(f1);

%h.Children(2).Children.CData

end