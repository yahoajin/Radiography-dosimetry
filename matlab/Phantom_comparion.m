%% load phantom

f_skinny_2 = fopen(['D:\조아진\dosemetry\habitus\female\phantoms\skinny_phantom_2_act_av.bin']);
A = fread(f_skinny_2, 'float');
AA = reshape(A, [256, 256, 1200]);

f_skinny_1 = fopen(['D:\조아진\dosemetry\habitus\female\phantoms\skinny_phantom_1_act_av.bin']);
B = fread(f_skinny_1, 'float');
BB = reshape(B, [256, 256, 1200]);

f_normal = fopen(['D:\조아진\dosemetry\habitus\female\phantoms\normal_phantom_act_av.bin']);
C = fread(f_normal, 'float');
CC = reshape(C, [256, 256, 1200]);

f_fat_1 = fopen(['D:\조아진\dosemetry\habitus\female\phantoms\fat_phantom_1_act_av.bin']);
D = fread(f_fat_1, 'float');
DD = reshape(D, [256, 256, 1200]);

f_fat_2 = fopen(['D:\조아진\dosemetry\habitus\female\phantoms\fat_phantom_2_act_av.bin']);
E = fread(f_fat_2, 'float');
EE = reshape(E, [256, 256, 1200]);

%%
for n = 1 : 1200
disp(n)
figure(1); 
subplot(1,5,1); imshow(squeeze(AA(:,:,n))', [0 max(squeeze(AA(:,:,n)),[],'all')]);
subplot(1,5,2); imshow(squeeze(BB(:,:,n))', [0 max(squeeze(BB(:,:,n)),[],'all')]);
subplot(1,5,3); imshow(squeeze(CC(:,:,n))', [0 max(squeeze(CC(:,:,n)),[],'all')]);
subplot(1,5,4); imshow(squeeze(DD(:,:,n))', [0 max(squeeze(DD(:,:,n)),[],'all')]);
subplot(1,5,5); imshow(squeeze(EE(:,:,n))', [0 max(squeeze(EE(:,:,n)),[],'all')]);
pause();
end

%%
for n = 1 : 1200
    disp(n)
    figure(1); 
    subplot(1,2,1); imshow(squeeze(AA(:,:,n))', [0 max(squeeze(AA(:,:,n)),[],'all')]);
    subplot(1,2,2); imshow(squeeze(BB(:,:,n))', [0 max(squeeze(BB(:,:,n)),[],'all')]);
    % imshow(squeeze(BB(:,:,n)), [0 max(squeeze(BB(:,:,n)),[],'all')]);
    pause();
end

%%

AAA = AA(:,35:213,:);
BBB = BB(:,35:214,:);
CCC = CC(:,:,:);
DDD = DD(:,33:219,:);
EEE = EE(:,33:226,:);

%%
AAAA = reshape(AAA, [256*179*1200,1]);
EEEE = reshape(EEE, [256*194*1200,1]);

f_skinny_crop = fopen('D:\조아진\dosemetry\habitus\female\skinny\female_skinny_phantom_crop.bin','w');
fwrite(f_skinny_crop, AAAA, 'float');

f_fat_crop = fopen('D:\조아진\dosemetry\habitus\female\skinny\female_fat_phantom_crop.bin','w');
fwrite(f_fat_crop, BBBB, 'float');

%%

BBBB = reshape(BBB, [256*180*1200,1]);
DDDD = reshape(DDD, [256*187*1200,1]);

f_skinny_crop_1 = fopen('D:\조아진\dosemetry\habitus\female\phantoms\female_skinny_phantom_1_crop.bin','w');
fwrite(f_skinny_crop_1, BBBB, 'float');

f_fat_crop_1 = fopen('D:\조아진\dosemetry\habitus\female\phantoms\female_fat_phantom_1_crop.bin','w');
fwrite(f_fat_crop_1, DDDD, 'float');
