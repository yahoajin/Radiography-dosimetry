%%

E_normal = [60 90 120 150];
% E_fat = [120 150];
% E_skinny = [60 90 120];

%%

for organ = 1 : 18 
% organ = 18;


figure; 
plot(E_normal, Chest_dose_normal(organ,:), "-kSquare", "MarkerSize",6,"MarkerEdgeColor",[0 0 0], "MarkerFaceColor",[1 1 1]);
xlim([50 160]);
xlabel('Energy (keV)');
ylabel('Dose (MeV)');
title(X(organ)); 
hold on



plot(E_normal, Chest_dose_skinny(organ,:), "-kx", "MarkerSize",6,"MarkerEdgeColor",[0 0 0], "MarkerFaceColor",[0 0 0]);
xlim([50 160]);
xlabel('Energy (keV)');
ylabel('Dose (MeV)');



plot(E_normal, Chest_dose_skinny_1(organ,:), "-ko", "MarkerSize",6,"MarkerEdgeColor",[0 0 0], "MarkerFaceColor",[1 1 1]);
xlim([50 160]);
xlabel('Energy (keV)');
ylabel('Dose (MeV)');



plot(E_normal, Chest_dose_fat_1(organ,:), "-k^", "MarkerSize",6,"MarkerEdgeColor",[0 0 0], "MarkerFaceColor",[0 0 0]);
xlim([50 160]);
xlabel('Energy (keV)');
ylabel('Dose (MeV)');



plot(E_normal, Chest_dose_fat(organ,:), "-kDiamond", "MarkerSize",6,"MarkerEdgeColor",[0 0 0], "MarkerFaceColor",[0 0 0]);
xlim([50 160]);
xlabel('Energy (keV)');
ylabel('Dose (MeV)');

legend({'Normal phantom','Skinny_2 phantom', 'Skinny_1 phantom', 'Obese_1 phantom', 'Obese_2 phantom'}, 'Location','best')

hold off
end