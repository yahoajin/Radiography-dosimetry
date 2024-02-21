%% Abdomen dose data extraction

foldernames = ["D:\조아진\dosemetry\habitus\female\abdomen\skinny_2_60kVp\";
               "D:\조아진\dosemetry\habitus\female\abdomen\skinny_2_90kVp\";
               "D:\조아진\dosemetry\habitus\female\abdomen\skinny_2_120kVp\";
               "D:\조아진\dosemetry\habitus\female\abdomen\skinny_2_150kVp\";
               "D:\조아진\dosemetry\habitus\female\abdomen\skinny_1_60kVp\";
               "D:\조아진\dosemetry\habitus\female\abdomen\skinny_1_90kVp\";
               "D:\조아진\dosemetry\habitus\female\abdomen\skinny_1_120kVp\";
               "D:\조아진\dosemetry\habitus\female\abdomen\skinny_1_150kVp\";
               "D:\조아진\dosemetry\habitus\female\abdomen\normal_60kVp\";
               "D:\조아진\dosemetry\habitus\female\abdomen\normal_90kVp\";
               "D:\조아진\dosemetry\habitus\female\abdomen\normal_120kVp\";
               "D:\조아진\dosemetry\habitus\female\abdomen\normal_150kVp\";
               "D:\조아진\dosemetry\habitus\female\abdomen\fat_1_60kVp\";
               "D:\조아진\dosemetry\habitus\female\abdomen\fat_1_90kVp\";
               "D:\조아진\dosemetry\habitus\female\abdomen\fat_1_120kVp\";
               "D:\조아진\dosemetry\habitus\female\abdomen\fat_1_150kVp\";
               "D:\조아진\dosemetry\habitus\female\abdomen\fat_2_60kVp\";
               "D:\조아진\dosemetry\habitus\female\abdomen\fat_2_90kVp\";
               "D:\조아진\dosemetry\habitus\female\abdomen\fat_2_120kVp\";
               "D:\조아진\dosemetry\habitus\female\abdomen\fat_2_150kVp\";
               ];


n_interested_organs = [27, 30, 36, 41, 32, 44, 38, 40, 35, 31, 39, 45, 43, 33, 37, 55, 58, 42];

Abdomen_dose_skinny_2 = zeros(18, 4);
Abdomen_dose_skinny_1 = zeros(18, 4);
Abdomen_dose_normal = zeros(18, 4);
Abdomen_dose_fat_1 = zeros(18, 4);
Abdomen_dose_fat_2 = zeros(18, 4);

for i = 1 : 5
    for j = 1 : 4
        if i == 1
            Abdomen_dose_skinny_2(:,j) = XrayDose_all(foldernames((i-1)*4+j),10,"skinny_2",n_interested_organs);
        elseif i == 2
            Abdomen_dose_skinny_1(:,j) = XrayDose_all(foldernames((i-1)*4+j),10,"skinny_1",n_interested_organs);
        elseif i == 3
            Abdomen_dose_normal(:,j) = XrayDose_all(foldernames((i-1)*4+j),10,"normal",n_interested_organs);
        elseif i == 4
            Abdomen_dose_fat_1(:,j) = XrayDose_all(foldernames((i-1)*4+j),10,"fat_1",n_interested_organs);
        elseif i == 5
            Abdomen_dose_fat_2(:,j) = XrayDose_all(foldernames((i-1)*4+j),10,"fat_2",n_interested_organs);
        end
    end
end

cd D:\조아진\dosemetry\habitus\female\

%% Abdomen relative dose calculation 

Abdomen_dose_ratio_fat_2 = Abdomen_dose_fat_2./Abdomen_dose_normal(:,2);
Abdomen_dose_ratio_fat_1 = Abdomen_dose_fat_1./Abdomen_dose_normal(:,2);
Abdomen_dose_ratio_normal = Abdomen_dose_normal./Abdomen_dose_normal(:,2);
Abdomen_dose_ratio_skinny_1 = Abdomen_dose_skinny_2./Abdomen_dose_normal(:,2);
Abdomen_dose_ratio_skinny_2 = Abdomen_dose_skinny_1./Abdomen_dose_normal(:,2);

%% Abdome relative dose graph drawing

organ_names = categorical({'Skin',
               'Liver',
               'Stomach',
               'Urinary bladder',
               'Brain',
               'Oesophagus',
               'Large intestine',
               'Thyroid',
               'Kidneys',
               'Pancreas',
               'Spleen',
               'Gallbladder'
               'Adrenals',
               'Heart',
               'Small intestine',
               'Lung',
               'Thymus',
               'Ovaries'});

X = reordercats(organ_names,{'Skin',
               'Liver',
               'Stomach',
               'Urinary bladder',
               'Brain',
               'Oesophagus',
               'Large intestine',
               'Thyroid',
               'Kidneys',
               'Pancreas',
               'Spleen',
               'Gallbladder'
               'Adrenals',
               'Heart',
               'Small intestine',
               'Lung',
               'Thymus',
               'Ovaries'});


E_normal = [60 90 120 150];

for organ = 1 : 18 
% organ = 18;

figure; 
plot(E_normal, Abdomen_dose_ratio_normal(organ,:), "-kSquare", "MarkerSize",6,"MarkerEdgeColor",[0 0 0], "MarkerFaceColor",[1 1 1]);
xlim([50 160]);
% ylim([0.6 1.5]);
xlabel('Tube voltage (kVp)');
ylabel('Relative organ dose (Arb. Unit)');
title(X(organ)); 
hold on

plot(E_normal, Abdomen_dose_ratio_skinny_2(organ,:), "-kx", "MarkerSize",6,"MarkerEdgeColor",[0 0 0], "MarkerFaceColor",[0 0 0]);
xlim([50 160]);
% ylim([0.6 1.5]);
xlabel('Tube voltage (kVp)');
ylabel('Relative organ dose (Arb. Unit)');

plot(E_normal, Abdomen_dose_ratio_skinny_1(organ,:), "-ko", "MarkerSize",6,"MarkerEdgeColor",[0 0 0], "MarkerFaceColor",[1 1 1]);
xlim([50 160]);
% ylim([0.6 1.5]);
xlabel('Tube voltage (kVp)');
ylabel('Relative organ dose (Arb. Unit)');

plot(E_normal, Abdomen_dose_ratio_fat_1(organ,:), "-k^", "MarkerSize",6,"MarkerEdgeColor",[0 0 0], "MarkerFaceColor",[0 0 0]);
xlim([50 160]);
% ylim([0.6 1.5]);
xlabel('Tube voltage (kVp)');
ylabel('Relative organ dose (Arb. Unit)');

plot(E_normal, Abdomen_dose_ratio_fat_2(organ,:), "-kDiamond", "MarkerSize",6,"MarkerEdgeColor",[0 0 0], "MarkerFaceColor",[0 0 0]);
xlim([50 160]);
% ylim([0.6 1.5]);
xlabel('Tube voltage (kVp)');
ylabel('Relative organ dose (Arb. Unit)');

legend({'Normal phantom','Skinny_2 phantom', 'Skinny_1 phantom', 'Obese_1 phantom', 'Obese_2 phantom'}, 'Location','best')

hold off
end