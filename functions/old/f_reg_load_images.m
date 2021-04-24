function table_out = f_reg_load_images(table_in, data_dir, fnames_col, image_col_name, mouse_dir_col)

% obsolete

if ~exist('image_col_name', 'var') || isempty(image_col_name)
    image_col_name = 'image';
end

table_in2 = table_in(~strcmpi(table_in.(fnames_col), ''),:);

table_out = table_in2;
table_out.(image_col_name) = cell(size(table_in2,1),1);

for n_col = 1:size(table_in2,1)
    fname = table_in2.(fnames_col){n_col};
    extra_dir = table_in2.(mouse_dir_col){n_col};
    
    im_path  = [data_dir '\' extra_dir '\' fname];
    im_out = f_reg_gen_db_load_im(im_path);
    
    table_out(n_col,{image_col_name}) = {im_out};
end

end