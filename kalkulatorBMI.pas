program HitungKaloriLanjutan;  //judul program
uses crt;

type
    identitas = record  //record yang berisi tipe data
        nama : string;
        umur : integer;
        jeniskelamin : char;
        tb : real;
        bb : real;
        aktivitas : integer;
    end;

var  //pendeklarisian variabel
    data : array[1..100] of identitas;
    i, n : integer;
    totalBMI : real;


function HitungBMI(idx : integer): real; //menghitung BMI menggunakan function
begin
    HitungBMI := data[idx].bb / sqr(data[idx].tb); 
end;

function FaktorAktivitas(a : integer): real;  //menentukan faktor aktivitas fisik yang dilakukan
begin                                         //menggunakan function dan juga case of
    case a of
        1: FaktorAktivitas := 1.2;
        2: FaktorAktivitas := 1.375;
        3: FaktorAktivitas := 1.55;
        4: FaktorAktivitas := 1.725;
        5: FaktorAktivitas := 1.9;
    else
        FaktorAktivitas := 1.0;
    end;
end;

function HitungBMR(idx : integer): real; //menghitung BMR menggunakan function dan juga ada if else
begin
    with data[idx] do
    begin
        if upcase(jeniskelamin) = 'L' then
            HitungBMR := 88.362 + (13.397 * bb) + (4.799 * (tb * 100)) - (5.677 * umur)
        else
            HitungBMR := 447.593 + (9.247 * bb) + (3.098 * (tb * 100)) - (4.330 * umur);
    end;
end;

function KaloriMaintenance(idx : integer): real; //menghitung kalorimaintenance dengan function
begin
    KaloriMaintenance := HitungBMR(idx) * FaktorAktivitas(data[idx].aktivitas);
end;


procedure Garis; //membuata tampilan garis-garis dengan procedure
begin
    writeln('================================================');
end;

procedure KategoriBMI(idx : integer); //menentukan kategori/status BMI dengan if else dalam procedure
var
    bmi : real;
begin
    bmi := HitungBMI(idx);

    if bmi < 18.5 then
        writeln('Status Gizi : Kurus')
    else if bmi <= 24.9 then
        writeln('Status Gizi : Normal')
    else if bmi <= 29.9 then
        writeln('Status Gizi : Overweight')
    else
        writeln('Status Gizi : Obesitas');
end;

procedure RekomendasiKalori(idx : integer); //menampilkan defisit,maintenance,dan surplus dengan procedure
var
    kalori : real;
begin
    kalori := KaloriMaintenance(idx);

    writeln('Rekomendasi Kebutuhan Kalori:');
    writeln('- Defisit (diet)     : ', (kalori - 500):0:0, ' kkal/hari');
    writeln('- Maintenance       : ', kalori:0:0, ' kkal/hari');
    writeln('- Surplus (naik BB) : ', (kalori + 500):0:0, ' kkal/hari');
end;

procedure InputData; //menginput data identitas user sesuai jumlah data yg dimasukkan di dalam procedure
begin
    clrscr;
    Garis;
    writeln('   SISTEM ANALISIS KEBUTUHAN KALORI HARIAN');
    Garis;

    write('Masukkan jumlah data: ');
    readln(n);

    for i := 1 to n do
    begin
        clrscr;
        writeln('Input Data ke-', i);
        Garis;

        with data[i] do
        begin
            write('Nama                 : ');
            readln(nama);
            write('Umur (tahun)         : ');
            readln(umur);
            write('Jenis Kelamin (L/P)  : ');
            readln(jeniskelamin);
            write('Tinggi Badan (m)     : ');
            readln(tb);
            write('Berat Badan (kg)     : ');
            readln(bb);

            writeln;
            writeln('Aktivitas Fisik:');
            writeln('1. Sangat Ringan');
            writeln('2. Ringan');
            writeln('3. Sedang');
            writeln('4. Berat');
            writeln('5. Sangat Berat');
            write('Pilihan (1-5)        : ');
            readln(aktivitas);
        end;
    end;
end;

procedure RekapBMI; //menghitung rata rata BMI dari jumlah data yg diinput dalam procedure
begin
    writeln;
    Garis;
    writeln('REKAPITULASI DATA');
    Garis;
    writeln('Jumlah Data   : ', n);
    writeln('Rata-rata BMI : ', (totalBMI / n):0:2);
end;


begin
    InputData; //memanggil procedure inputdata
    clrscr;

    totalBMI := 0;

    Garis;
    writeln('           HASIL ANALISIS INDIVIDU');
    Garis;

    for i := 1 to n do  //menampilkan hasil dari laporan BMI dan BMR menggunakan for dari jumlah data yg diinput
    begin
        writeln;
        writeln('Nama : ', data[i].nama);
        writeln('BMI  : ', HitungBMI(i):0:2);
        KategoriBMI(i);
        writeln('BMR  : ', HitungBMR(i):0:0, ' kkal');
        RekomendasiKalori(i);

        totalBMI := totalBMI + HitungBMI(i);
        Garis;
    end;

    RekapBMI; //memanggil procedure rekapBMI
    writeln('Tekan ENTER untuk keluar...');
    readln;
end.

