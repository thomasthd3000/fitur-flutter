import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VAScreen extends StatelessWidget {
  final String accountNumber = '89325400000020002';
  final String accountName = 'Bank Mandiri a/n Jesayas';
  final String amount = 'Rp 100.000';

  const VAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Make payment before',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                '20/08/2024 11:00 WIB',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Pay to Virtual Account Number',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        accountNumber,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        accountName,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: accountNumber));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Nomor rekening disalin!')),
                      );
                    },
                    child: const Text(
                      'Salin',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Total Payment',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    amount,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: amount));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Jumlah pembayaran disalin!')),
                      );
                    },
                    child: const Text(
                      'Salin',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            //1. Masukkan kartu ATM dan PIN Anda.\n2. Pilih menu 'Pembayaran'.\n3. Masukkan kode perusahaan dan Nomor Virtual Account.\n4. Masukkan jumlah pembayaran.\n5. Konfirmasi transaksi.
            const ExpansionTile(
              title: Text("ATM BCA"),
              children: <Widget>[
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                    children: [
                      Row(
                        children: [
                          Text('1. '),
                          Text('Masukkan kartu ATM dan PIN Anda.'),
                        ],
                      ),
                      Row(
                        children: [
                          Text('2. '),
                          Text('Pilih menu \'Pembayaran.\''),
                        ],
                      ),
                      Row(
                        children: [
                          Text('3. '),
                          Expanded(
                            child: Text(
                              'Masukkan kode perusahaan dan Nomor Virtual Account.',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('4. '),
                          Text('Masukkan jumlah pembayaran.'),
                        ],
                      ),
                      Row(
                        children: [
                          Text('5. '),
                          Text('Konfirmasi transaksi.'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const ExpansionTile(
              title: Text("m-BCA (BCA mobile)"),
              children: <Widget>[
                ListTile(
                  title: Text(
                      "1. Login pada aplikasi m-BCA.\n2. Pilih menu 'm-Transfer'.\n3. Pilih 'BCA Virtual Account'.\n4. Masukkan nomor Virtual Account.\n5. Konfirmasi pembayaran."),
                ),
              ],
            ),
            const ExpansionTile(
              title: Text("Internet Banking BCA"),
              children: <Widget>[
                ListTile(
                  title: Text(
                      "1. Login pada alamat Internet Banking BCA (https://klikbca.com)\n2. Pilih menu Pembayaran Tagihan > Pembayaran > BCA Virtual Account.\n3. Pada kolom kode bayar, masukkan 5 angka kode perusahaan untuk Tokopedia (80777) dan Nomor HP yang terdaftar di akun Tokopedia Anda (Contoh: 80777081808379295)\n4. Di halaman konfirmasi, pastikan detil pembayaran sudah sesuai seperti Nomor BCA Virtual Account, Nama Pelanggan dan Jumlah Pembayaran\n5. Masukkan password dan mToken\n6. Cetak/simpan struk pembayaran BCA Virtual Account sebagai bukti pembayaran"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
