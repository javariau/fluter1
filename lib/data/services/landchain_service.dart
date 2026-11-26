import '../../domain/models/blockchain_info_model.dart';
import '../../domain/models/land_model.dart';
import '../../domain/models/task_model.dart';

class LandChainService {
  Future<List<LandModel>> getLands() async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    final rows = [
      _land(
        'LC-001',
        'BDG-015/2022',
        'Ratna Puspita',
        'Cibubur, Depok',
        240,
        'SHM',
        'Terverifikasi',
        '2024-06-14',
      ),
      _land(
        'LC-002',
        'BDG-021/2023',
        'Aditya Pranata',
        'Cimanggis, Depok',
        180,
        'HGB',
        'Dalam proses',
        '2025-02-08',
      ),
      _land(
        'LC-003',
        'BDG-034/2021',
        'Siti Rahmawati',
        'Beji, Depok',
        320,
        'AJB',
        'Perlu verifikasi',
        '2023-10-22',
      ),
      _land(
        'LC-004',
        'BDG-042/2024',
        'Bima Kurniawan',
        'Sukmajaya, Depok',
        150,
        'SHM',
        'Terverifikasi',
        '2025-07-05',
      ),
      _land(
        'LC-005',
        'BDG-057/2022',
        'Dewi Anggraini',
        'Limo, Depok',
        410,
        'HGB',
        'Dalam proses',
        '2024-11-19',
      ),
      _land(
        'LC-006',
        'BDG-063/2020',
        'Fajar Nugraha',
        'Sawangan, Depok',
        275,
        'AJB',
        'Terverifikasi',
        '2022-03-16',
      ),
    ];
    return rows.map(LandModel.fromJson).toList(growable: false);
  }

  Future<List<TaskModel>> getTasks() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final rows = [
      _task(
        'T-01',
        'Siapkan KTP pemilik',
        'Pastikan identitas pemilik masih berlaku.',
        'Identitas',
        false,
      ),
      _task(
        'T-02',
        'Siapkan Kartu Keluarga',
        'Lampirkan salinan KK terbaru.',
        'Identitas',
        false,
      ),
      _task(
        'T-03',
        'Lengkapi surat ukur tanah',
        'Periksa kesesuaian batas dan luas bidang.',
        'Dokumen',
        false,
      ),
      _task(
        'T-04',
        'Verifikasi dokumen',
        'Cocokkan data dengan dokumen pendukung.',
        'Verifikasi',
        true,
      ),
      _task(
        'T-05',
        'Validasi sertifikat',
        'Pastikan sertifikat telah tervalidasi.',
        'Verifikasi',
        false,
      ),
      _task(
        'T-06',
        'Selesaikan penerbitan',
        'Ambil dokumen setelah proses selesai.',
        'Penerbitan',
        false,
      ),
    ];
    return rows.map(TaskModel.fromJson).toList(growable: false);
  }

  Future<List<BlockchainInfoModel>> getBlockchainInfos() async {
    await Future<void>.delayed(const Duration(milliseconds: 550));
    final rows = [
      _block(
        'TX-105',
        'Sertifikat diverifikasi',
        'Status bidang BDG-015/2022 diperbarui setelah pemeriksaan dokumen.',
        '0x8f2a91c4d7b6e0318a5c2f9d4e7b1026',
        '2025-10-18T09:42:00',
        'Terkonfirmasi',
      ),
      _block(
        'TX-104',
        'Perubahan data pemilik',
        'Pencatatan pemilik bidang BDG-021/2023 diperbarui.',
        '0x3c7d10e2a5b84f961d0c3e7a9b2f6d41',
        '2025-10-16T14:18:00',
        'Terkonfirmasi',
      ),
      _block(
        'TX-103',
        'Dokumen ukur ditambahkan',
        'Dokumen ukur bidang BDG-034/2021 masuk ke riwayat administrasi.',
        '0xa41f6c2d9e03b7584a1d6f20c3b9e572',
        '2025-10-13T11:06:00',
        'Terkonfirmasi',
      ),
      _block(
        'TX-102',
        'Pengajuan sertifikat dibuat',
        'Pengajuan bidang BDG-042/2024 berhasil dicatat.',
        '0x72b5d8e1c4f9036a1e7b5d2c8a4f6190',
        '2025-10-10T08:30:00',
        'Terkonfirmasi',
      ),
      _block(
        'TX-101',
        'Berkas diterima',
        'Berkas bidang BDG-057/2022 diterima untuk ditinjau.',
        '0xd19a4e7c2b508f36a1d9e4c7b2f60583',
        '2025-10-07T16:52:00',
        'Terkonfirmasi',
      ),
    ];
    return rows.map(BlockchainInfoModel.fromJson).toList(growable: false);
  }

  Map<String, dynamic> _land(
    String id,
    String nomor,
    String owner,
    String location,
    num area,
    String type,
    String status,
    String date,
  ) => {
    'id': id,
    'nomorBidang': nomor,
    'namaPemilik': owner,
    'lokasi': location,
    'luasTanah': area,
    'jenisSertifikat': type,
    'statusDokumen': status,
    'tanggalPenerbitan': date,
  };

  Map<String, dynamic> _task(
    String id,
    String title,
    String description,
    String category,
    bool completed,
  ) => {
    'id': id,
    'judul': title,
    'deskripsi': description,
    'kategori': category,
    'isCompleted': completed,
  };

  Map<String, dynamic> _block(
    String id,
    String title,
    String description,
    String hash,
    String date,
    String status,
  ) => {
    'id': id,
    'judul': title,
    'deskripsi': description,
    'transactionHash': hash,
    'tanggal': date,
    'status': status,
  };
}
