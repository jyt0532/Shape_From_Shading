function [albedo_image, surface_normals] = photometric_stereo(imarray, light_dirs)
% imarray: h x w x Nimages array of Nimages no. of images
% light_dirs: Nimages x 3 array of light source directions
% albedo_image: h x w image
% surface_normals: h x w x 3 array of unit surface normals


%% <<< fill in your code below >>>

I_matrix = reshape(imarray(:,:,1), 1, 32256);
for i = 2:64
    I_matrix = cat(1, I_matrix, reshape(imarray(:,:,i), 1, 32256));
end

g = light_dirs\I_matrix;
g = reshape(g, 3, 192,168);

surface_normals = zeros(192, 168, 3);

current_sum = bsxfun(@hypot, g(1,:,:), g(2,:,:));
current_sum = bsxfun(@hypot, current_sum, g(3,:,:));
albedo_image = squeeze(current_sum);
surface_normals(:, :, 1) = bsxfun(@rdivide, squeeze(g(1,:,:)), albedo_image); 
surface_normals(:, :, 2) = bsxfun(@rdivide, squeeze(g(2,:,:)), albedo_image); 
surface_normals(:, :, 3) = bsxfun(@rdivide, squeeze(g(3,:,:)), albedo_image); 



end

