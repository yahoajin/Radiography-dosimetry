function image = XrayImage(path, num_thread, image_size, dynamic_range)

%---------------------------------------------------------------------
% XrayImage makes x-ray images from GATE simulation data.
% image = XrayImage(path, num_thread, image_size, dynamic_range)
% image : output image
% path : input file path 
% num_thread : the number of thread used for parallel GATE simulation
% image_size : the number of pixels in 2-D array detector([Xpix, Ypix]) 
% dynamic_range : dynamic range of the X-ray image between 0 and 1
%
% it will read '.dat' files from current path and read it to make an X-ray image  
% So, '.dat' files acquired from CTScanner system in GATE simulation have
% to be located in current path.
%----------------------------------------------------------------------

List = dir([path+"*.dat"]);

image_raw = zeros(prod(image_size),1);

for k = 1 : num_thread
    filename = List(k).name
    fid = fopen(filename);
    tmp_img = fread(fid,'float');
    image_raw = image_raw + tmp_img;

end

image = reshape(image_raw,image_size);
image = (max(image_raw)-image)'/(max(image_raw)-min(image_raw));

figure; histogram(image);
figure; imshow(image,dynamic_range,"InitialMagnification",4000); colormap('gray');
