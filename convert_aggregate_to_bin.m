function convert_aggregate_to_bin(DIR,port_name)
load('roboaggregate.mat');
channels = ephys.labels(ephys.ports == port_name);
fs = ephys.fs;
d = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2',200,350,8800,9300,60,1,60,fs);
Hd = design(d,'equiripple');
filtered = filtfilt(Hd.Numerator,1,double(ephys.data));
for channel_n=1:numel(channels)
    fname = ['toclust' num2str(channels(channel_n)) '.bin'];
    fid = fopen(fname,'w');
    tmp_data = squeeze(filtered(:,:,channels(channel_n)));
    
    for bout=1:size(tmp_data,2)
        fwrite(fid,tmp_data(:,bout),'int16');
    end
    fclose(fid);
end
