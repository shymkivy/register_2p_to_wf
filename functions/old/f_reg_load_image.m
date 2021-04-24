function [image_out, fname] = f_reg_load_image(image_path)

% obsolete

[~,fname ,ext] = fileparts(image_path);

if strcmpi(ext, '.fig')
    fig1 = openfig(image_path);
    image_out = fig1.Children.Children.CData;
    close(fig1);
elseif strcmpi(ext, '.tif') || strcmpi(ext, '.tiff')
    image_out = imread(image_path);
end

image_out = double(image_out);
image_out = image_out - min(image_out(:));
image_out = image_out/max(image_out(:));

end