motif_name = 'lw73ry_motif';
port_name = 'B';
baseDIR = pwd;
a = dir;
dirs = [a.isdir];
a = a(dirs == 1);
list_dirs = a(cellfun(@(x) strcmp(x,'.'),{a.name})+cellfun(@(x) strcmp(x,'..'),{a.name}) == 0);
for dir_num = 1:numel(list_dirs)
    try
        cd([list_dirs(dir_num).name '/mat/' motif_name '_roboextract/mat/roboaggregate']);
        convert_aggregate_to_bin(pwd,port_name);
    catch em
        disp(['error in' baseDIR list_dirs(dir_num).name '/mat/' motif_name '_roboextract/mat/roboaggregate']);
    end
    cd(baseDIR);
end