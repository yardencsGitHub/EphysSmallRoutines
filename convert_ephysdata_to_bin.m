data = ephys.data;
d = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2',200,350,8800,9300,60,1,60,ephys.fs);
Hd = design(d,'equiripple');
filtered = filtfilt(Hd.Numerator,1,double(data));
denoised_data=spikoclust_denoise_signal(filtered,[],[],'car_trim',40,'method','car');

for el_n=1:13
    fname = ['toclust' num2str(el_n) '.bin'];
    fid = fopen(fname,'w');
    tmp_data = squeeze(denoised_data(:,:,1));
    
    for bout=1:size(data,2)
        fwrite(fid,tmp_data(:,bout),'int16');
    end
    fclose(fid);
end
%filtfilt(Hd.Numerator,1,double(data(:,bout)))