function key = calculate_random_key(key_size)

key = '';
for i=1:key_size
    random_bit = round(rand);        %calculate random ones and zeros
    key = strcat(key,num2str(random_bit));
end