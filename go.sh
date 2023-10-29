#/bin/bash
arr1=('懸垂測試 Dangle test' '電力測試 electricity test' '排放測試 emission test' 'PDN測試 PDA test')
arr2=('承載能力 Carrying capacity' '爬坡檢測 Hill climbing detection' '晶圓檢測 Wafer inspection' '儀表辨識 Instrument identification')
arr3=('光須檢測 Light whiskers' '耐電壓試驗 Withstand Voltage Test' '絕緣電阻測試 Insulation Resistance Test' 'EMS測試 EWM Test')
arr4=('噪音測試 Airborne Noise Test' '負空間測試 negative space test' '橋接測試 bridge test' '回抽測試 retraction test')
arr5=('垂直打印測試 vertical print test' '準確度測試 accuracy test' '支撐測試 support test' '料絲檢測 Filament detection')
arr6=('水假影像測試 Water CT number accuracy' '擷取測試 Acquisition test' '噪音測試 Noise test' '線性度測試 Linearity test')


ts=`date "+%s"`
#ts=1700484454
#echo $ts

for i in {1..43200};
do
    ts=$((ts + 60))
    date=`date -r ${ts} "+%Y-%m-%d %H:%M:%S"`

    number=$RANDOM
    let "number %= 4"
    n=$((number + 1))

    echo "INSERT INTO public.exams(
	id, machine_id, batch_at, batch_at_code, answer_code, answer_string, created_at, updated_at)
	VALUES (${i}, 1, '${date}', 1, ${n}, '${arr1[number]}', '${date}', '${date}');"
done

for i in {43201..86400};
do
    ts=$((ts + 60))
    date=`date -r ${ts} "+%Y-%m-%d %H:%M:%S"`

    number=$RANDOM
    let "number %= 4"
    n=$((number + 1))

    echo "INSERT INTO public.exams(
	id, machine_id, batch_at, batch_at_code, answer_code, answer_string, created_at, updated_at)
	VALUES (${i}, 2, '${date}', 1, ${n}, '${arr2[number]}', '${date}', '${date}');"
done

for i in {86401..129600};
do
    ts=$((ts + 60))
    date=`date -r ${ts} "+%Y-%m-%d %H:%M:%S"`

    number=$RANDOM
    let "number %= 4"
    n=$((number + 1))

    echo "INSERT INTO public.exams(
	id, machine_id, batch_at, batch_at_code, answer_code, answer_string, created_at, updated_at)
	VALUES (${i}, 3, '${date}', 1, ${n}, '${arr3[number]}', '${date}', '${date}');"
done

for i in {129601..172800};
do
    ts=$((ts + 60))
    date=`date -r ${ts} "+%Y-%m-%d %H:%M:%S"`

    number=$RANDOM
    let "number %= 4"
    n=$((number + 1))

    echo "INSERT INTO public.exams(
	id, machine_id, batch_at, batch_at_code, answer_code, answer_string, created_at, updated_at)
	VALUES (${i}, 4, '${date}', 1, ${n}, '${arr4[number]}', '${date}', '${date}');"
done

for i in {172801..216000};
do
    ts=$((ts + 60))
    date=`date -r ${ts} "+%Y-%m-%d %H:%M:%S"`

    number=$RANDOM
    let "number %= 4"
    n=$((number + 1))

    echo "INSERT INTO public.exams(
	id, machine_id, batch_at, batch_at_code, answer_code, answer_string, created_at, updated_at)
	VALUES (${i}, 5, '${date}', 1, ${n}, '${arr5[number]}', '${date}', '${date}');"
done

for i in {216001..259200};
do
    ts=$((ts + 60))
    date=`date -r ${ts} "+%Y-%m-%d %H:%M:%S"`

    number=$RANDOM
    let "number %= 4"
    n=$((number + 1))

    echo "INSERT INTO public.exams(
	id, machine_id, batch_at, batch_at_code, answer_code, answer_string, created_at, updated_at)
	VALUES (${i}, 6, '${date}', 1, ${n}, '${arr6[number]}', '${date}', '${date}');"
done


