function check = check_linear(start,step,end_value)

if ((start < end_value && start + step > start) || (start > end_value && start + step < start)) && (start ~=end_value) && (step ~=0) && (abs(start + step-end_value) < abs(start -end_value)) 
    check = 'ok';
else
    check = 'not ok';
end

    