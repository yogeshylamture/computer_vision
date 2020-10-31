function iMark_script = generate_script(file)
fid = fopen(file,'r');
script = fscanf(fid, '%c');

[iMark_script] = eval(script);
fclose(fid);





