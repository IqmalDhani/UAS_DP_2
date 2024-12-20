Program MalvidLuxe;
uses crt;

type
    // mendefinisikan tipe record untuk menyimpan data identitas
    identitas = record
    nama : string;
    usia : integer;
    kelamin : string;
    alamat : string;
    pekerjaan : string;
    jumlahOrang : integer;
end;

var
data : array[1..20] of identitas;   // Array untuk menyimpan data identitas yang membooking hotel
jumlahhari, jumlahkamar, i : integer;  // variabel untuk jumlah hari menginap dan jumlah kamar yang disewa
valid: boolean; // variabel untuk validasi input apakah benar atau salah
hargapermalam, totalharga : real;   // variabel untuk harga menginap satu malam dan juga total harga keseluruhan(tipe kamar, jumlah hari, dan banyak orang)
kelas, metode: string;  // variabel untuk tipe kelas penginapan dan juga pilihan untuk pembayaran

procedure Konsumen(var data: identitas);    // Subprogram procedure untuk input identitas yang akan menginap
begin
    writeln('Silahkan isi data diri Anda');
    write('Nama : '); readln(data.nama);
    write('Usia : '); readln(data.usia);
    write('Jenis Kelamin (L/P) : '); readln(data.kelamin);
    write('Domisili : '); readln(data.alamat);
    write('Status Pekerjaan : '); readln(data.pekerjaan);
end;

function PilihKelas: string;    // Subprogram fungsi untuk memilih tipe kelas kamar  
var
    pilihankamar: string;
begin
    repeat
        valid := true;
        writeln('Pilih Tipe Kelas: ');  // pilihan tipe kelas kamar untuk di pilih 
        writeln('1. Standard Room (Rp 600.000 per malam)');
        writeln('2. Superior Room (Rp 900.000 per malam)');
        writeln('3. Deluxe Room (Rp 1.500.000 per malam)');
        readln(pilihankamar);

        if (pilihankamar <> '1') and (pilihankamar <> '2') and (pilihankamar <> '3') then   // validasi input dari tipe kamar yang dipilih(1-3)
        begin
            writeln('Error');
            valid := false;
        end;
    until valid;
    PilihKelas := pilihankamar;
end;

function PilihPembayaran: string;   // Fungsi untuk memilih metode pembayaran
var
    pilihanbayar: string;
begin
    repeat
        valid := true;
        writeln('Pilih Metode Pembayaran: ');
        writeln('1. BRI');
        writeln('2. BSI');
        writeln('3. BNI');
        writeln('4. BCA');
        writeln('5. Mandiri');
        readln(pilihanbayar);

        case pilihanbayar of    // validasi input dari opsi metode pembayaran yang dipilih(1-5)
            '1'..'5': valid := true;
            else
            begin
                writeln('Error.');
                valid := false;
            end;
        end;
    until valid;
    PilihPembayaran := pilihanbayar;
end;

//  Subprogram ringkasan pesanan untuk menampilkan apa saja telah diinput sebelumnya
procedure Ringkasan(data: identitas; Kelas: string; hargapermalam, totalharga: real; metode: string; jumlahhari: integer);
begin
    writeln('Ringkasan Booking Anda: ');
    writeln('Nama: ', data.nama);
    writeln('Usia: ', data.usia);    
    writeln('Jenis Kelamin: ', data.kelamin);
    writeln('Domisili: ', data.alamat);   
    writeln('Status Pekerjaan: ', data.pekerjaan);
    write('Kelas Kamar: ');
    case Kelas of 
        '1': writeln('Standard Room');
        '2': writeln('Superior Room');
        '3': writeln('Deluxe Room');
    end;
    writeln('Harga per malam: Rp ', hargapermalam:0:0);
    writeln('Jumlah Orang dalam Kamar: ', data.jumlahOrang);
    writeln('Lama Menginap: ', jumlahhari, ' malam');
    writeln('Total Harga: Rp ', totalharga:0:0);
    writeln('Metode Pembayaran: ', metode);
    writeln;
    writeln('Terima Kasih, ', data.nama, ', telah memilih Malvid Luxe!');
    writeln('Kami harap Anda memiliki pengalaman menginap yang menyenangkan.');
end;

begin
    clrscr;
    writeln('===Selamat Datang di Malvid Luxe===');   // menampilkan kata welcome kepada konsumen 
    writeln('Where Every Moment Feels Like Luxury');    // menampilkan slogan dari penginapan

    write('Berapa banyak ruangan kamar yang ingin digunakan ? ');
    readln(jumlahkamar);   // Input jumlah kamar yang akan disewa

    for i := 1 to jumlahkamar do
    begin
        Konsumen(data[i]);  // Mengisi data untuk setiap konsumen

        kelas := PilihKelas;    // Memanggil fungsi untuk memilih kelas kamar
        case kelas of
            '1': hargapermalam := 600000;
            '2': hargapermalam := 900000;
            '3': hargapermalam := 1500000;
        end;

        write('Berapa orang yang menginap dalam kamar ini? '); readln(data[i].jumlahOrang);  // Input jumlah orang dalam kamar
        write('Berapa malam akan menginap? '); readln(jumlahhari);  // Input lama hari untuk menginap

        totalharga := (hargapermalam + (data[i].jumlahOrang - 1) * 120000) * jumlahhari; // menghitung total harga termasuk biaya tambahan untuk orang tambahan

        metode := PilihPembayaran;

        Ringkasan(data[i], kelas, hargapermalam, totalharga, metode, jumlahhari); // mencetak ringkasan yang dibooking
        writeln;
    end;
    readln;
end.
