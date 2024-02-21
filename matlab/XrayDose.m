function dose = XrayDose_all(path, num_thread, phantom_type, target_organ_numbers)

%---------------------------------------------------------------------
% XrayDose extracts organ doses from GATE simulation data. ('.raw' files)
% dose = XrayDose(num_thread, phantom_size, target_organ_numbers)
% dose : organ dose for 54 preliminary defined organs (MeV/g)
% num_thread : the number of thread used for parallel GATE simulation
% phantom_type : type of the phantom (skinny_2, skinny_1, normal, fat_1, fat_2)
% target_organ_numbers : target organ numbers
%
% List of organ numbers
% 1. 'Teeth',
% 2. 'Mineral bone',
% 3. 'Humeri upper half spongiosa',
% 4. 'Humeri lower half spongiosa',
% 5. 'Lower arm bones spongiosa',
% 6. 'Hand bones spongiosa',
% 7. 'Clavicles spongiosa',
% 8. 'Cranium spongiosa',
% 9. 'Femora upper half spongiosa',
% 10. 'Femora lower half spongiosa',
% 11. 'Lower leg bones spongiosa',
% 12. 'Foot bones spongiosa',
% 13. 'Mandible spongiosa',
% 14. 'Pelvis spongiosa',
% 15. 'Ribs spongiosa',
% 16. 'Scapulae spongiosa',
% 17. 'Cervical spine spongiosa',
% 18. 'Thoracic spine spongiosa',
% 19. 'Lumbar spine spongiosa',
% 20. 'Sacrum spongiosa',
% 21. 'Sternum spongiosa',
% 22. 'Humeri and femora upper halves medullary cavity',
% 23. 'Humeri and femora lower halves medullary cavity',
% 24. 'Lower arm bones medullary cavity',
% 25. 'Lower leg bones medullary cavity',
% 26. 'Cartilage',
% 27. 'Skin',
% 28. 'Blood',
% 29. 'Muscle tissue',
% 30. 'Liver',
% 31. 'Pancreas',
% 32. 'Brain',
% 33. 'Heart',
% 34. 'Eyes',
% 35. 'Kidneys',
% 36. 'Stomach',
% 37. 'Small intestine',
% 38. 'Large intestine',
% 39. 'Spleen',
% 40. 'Thyroid',
% 41. 'Urinary bladder',
% 42. 'Ovaries',
% 43. 'Adrenals',
% 44. 'Oesophagus',
% 45. 'Gallbladder',
% 46. 'Uterus',
% 47. 'Lymph',
% 48. 'Breast mammary gland',
% 49. 'Adipose tissue',
% 50. 'Lung tissue compressed lungs',
% 51. 'Gastrointestinal tract  contents',
% 52. 'Urine',
% 53. 'Air',
% 54. 'Body' -> same material with Adipose tissue
% 55. 'Lung'
% 56. 'Pituitary gland' -> same material with #45
% 57. 'Trachea' -> same material with #45
% 58. 'Tyhmus' -> same material with #45
% 59. 'Tonsils' -> same material with #45
% 60. 'Ureters' -> same material with #45
% 61. 'Spinal cord'

% it will read '.raw' files from current path and read it to calculate doses for various organs  
% So, '.raw' files acquired from CTScanner system in GATE simulation have
% to be located in current path.
%----------------------------------------------------------------------

cd(path)
List = dir("*.raw");

if phantom_type == 'skinny_2'
    f = fopen("D:\조아진\dosemetry\habitus\female\phantoms\female_skinny_phantom_2_crop.bin");
    phantom_size = [256, 179, 1200];
elseif phantom_type == 'skinny_1'
    f = fopen("D:\조아진\dosemetry\habitus\female\phantoms\female_skinny_phantom_1_crop.bin");
    phantom_size = [256, 180, 1200];
elseif phantom_type == 'normal'
    f = fopen("D:\조아진\dosemetry\habitus\female\phantoms\organ_material_phantom_crop.bin");
    phantom_size = [256, 179, 1200];
elseif phantom_type == 'fat_1'
    f = fopen("D:\조아진\dosemetry\habitus\female\phantoms\female_fat_phantom_1_crop.bin");
    phantom_size = [256, 187, 1200];
elseif phantom_type == 'fat_2'
    f = fopen("D:\조아진\dosemetry\habitus\female\phantoms\female_fat_phantom_2_crop.bin");
    phantom_size = [256, 194, 1200];
end

dose_raw = zeros(prod(phantom_size),1);

for k = 1 : num_thread
    filename = List(k).name
    fid = fopen(filename);
    tmp_dose = fread(fid,'float');
    dose_raw = dose_raw + tmp_dose;
end

organ_label = fread(f, 'float');

dose = zeros(length(target_organ_numbers),1);
for j = 1 : length(target_organ_numbers)
    a = find(organ_label==target_organ_numbers(j));
    dose(j) = sum(dose_raw(a));
end