function table_out = f_reg_load_images(table_in, data_dir, fnames_col, image_col_name, mouse_dir_col)

if ~exist('image_col_name', 'var') || isempty(image_col_name)
    image_col_name = 'image';
end

table_in2 = table_in(~strcmpi(table_in.(fnames_col), ''),:);

table_out = table_in2;
table_out.(image_col_name) = cell(size(table_in2,1),1);

for n_col = 1:size(table_in2,1)
    fname = table_in2.(fnames_col){n_col};
    extra_dir = table_in2.(mouse_dir_col){n_col};
    
    all_files = dir([data_dir '\' extra_dir '\' fname '*']);
    all_files2 = {all_files.name};
    
    all_ext = cell(numel(all_files2),1);
    for n_fil = 1:numel(all_files2)
        [~,~,all_ext{n_fil}] = fileparts(all_files2{n_fil});
    end
    
    if sum(strcmpi(all_ext, '.tif'))
        files1 = all_files2(strcmpi(all_ext, '.tif'));
        image1 = double(imread([data_dir '\' extra_dir '\' files1{1}]));
    elseif sum(strcmpi(all_ext, '.tiff'))
        files1 = all_files2(strcmpi(all_ext, '.tiff'));
        image1 = double(imread([data_dir '\' extra_dir '\' files1{1}]));
    elseif sum(strcmpi(all_ext, '.fig'))
        files1 = all_files2(strcmpi(all_ext, '.fig'));
        fig1 = open([data_dir '\' extra_dir '\' files1{1}]);
        image1 = fig1.Children.Children.CData;
        close(fig1);
    end
    image1 = image1 - min(image1(:));
    image1 = image1/max(image1(:));
    table_out(n_col,{image_col_name}) = {image1};
end

end