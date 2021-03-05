function im_out = f_reg_gen_db_load_im(im_path)

all_files = dir([im_path '*']);
all_files2 = {all_files.name};

if ~isempty(all_files2)
    all_ext = cell(numel(all_files2),1);
    for n_fil = 1:numel(all_files2)
        [~,~,all_ext{n_fil}] = fileparts(all_files2{n_fil});
    end

    [f_dir] = fileparts(im_path);

    if sum(strcmpi(all_ext, '.tif'))
        files1 = all_files2(strcmpi(all_ext, '.tif'));
        image1 = double(imread([f_dir '\' files1{1}]));
    elseif sum(strcmpi(all_ext, '.tiff'))
        files1 = all_files2(strcmpi(all_ext, '.tiff'));
        image1 = double(imread([f_dir '\' files1{1}]));
    elseif sum(strcmpi(all_ext, '.fig'))
        files1 = all_files2(strcmpi(all_ext, '.fig'));
        fig1 = open([f_dir '\' files1{1}]);
        image1 = fig1.Children.Children.CData;
        close(fig1);
    end
    image1 = image1 - min(image1(:));
    im_out = image1/max(image1(:));
else
    im_out = [];
    fprintf('Warning: %s file not found\n', im_path);
end



% all_files = dir([data_dir '\' extra_dir '\' fname '*']);
% all_files2 = {all_files.name};
% 
% if ~isempty(all_files2)
%     all_ext = cell(numel(all_files2),1);
%     for n_fil = 1:numel(all_files2)
%         [~,~,all_ext{n_fil}] = fileparts(all_files2{n_fil});
%     end
% 
%     if sum(strcmpi(all_ext, '.tif'))
%         files1 = all_files2(strcmpi(all_ext, '.tif'));
%         image1 = double(imread([data_dir '\' extra_dir '\' files1{1}]));
%     elseif sum(strcmpi(all_ext, '.tiff'))
%         files1 = all_files2(strcmpi(all_ext, '.tiff'));
%         image1 = double(imread([data_dir '\' extra_dir '\' files1{1}]));
%     elseif sum(strcmpi(all_ext, '.fig'))
%         files1 = all_files2(strcmpi(all_ext, '.fig'));
%         fig1 = open([data_dir '\' extra_dir '\' files1{1}]);
%         image1 = fig1.Children.Children.CData;
%         close(fig1);
%     end
%     image1 = image1 - min(image1(:));
%     image1 = image1/max(image1(:));
% 
% else
%     image1 = [];
% end


end