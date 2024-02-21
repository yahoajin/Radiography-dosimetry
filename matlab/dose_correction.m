%% Effective dose calculation

num_iter = (3000*10.^6);
num_electrons = 1*(10.^-3)/(1.6*10.^-19);                       % for 1 mAs
geometric_efficiency = (30*40)/(4*pi*(100.^2));
X_ray_production_efficiency = 10.^-9 * 42 * 100*10.^3;
num_photons = num_electrons*geometric_efficiency*X_ray_production_efficiency;
R_simul_mAs = num_photons./num_iter;

organ_weighting_factor = [0.01 0.04 0.12 0.04 0.01 0.04 0.12 0.04 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.20];

equivalent_dose_skinny_1 = sum(abdomen_dose_150_kVp_skinny_1'.*R_simul_mAs.*organ_weighting_factor.*mass_correction_factor')

%%

List = dir("*.raw");

dose_raw = zeros(prod([256 194 1200]),1);

for k = 1 : 10
    filename = List(k).name
    fid = fopen(filename);
    tmp_dose = fread(fid,'float');
    dose_raw = dose_raw + tmp_dose;
end

f = fopen("D:\조아진\dosemetry\habitus\female\phantoms\female_fat_phantom_2_crop.bin");
organ_label = fread(f, 'float');

a = find(organ_label==0);
dose_raw(a) = 0;

% f_dosemap = fopen(['Abdomen_dose_150kVp_fat1-Dose.raw']);
% A = fread(f_dosemap, 'float');
AA = reshape(dose_raw, [256, 194, 1200]);

%%
for i = 1 : 194
    img = flipud(squeeze(AA(:,i,:))');
    figure(100); imshow(img, [0 max(dose_raw)]); colormap('hot');
    % colorbar;
    pause();
end