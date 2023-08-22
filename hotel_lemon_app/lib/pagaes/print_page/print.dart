import 'dart:typed_data';
import 'package:flutter/material.dart' hide Image;
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'dart:io' show Platform;
import 'package:image/image.dart';

class Print extends StatefulWidget {
  final quantity;
  final product;
  final total;

  const Print({
    Key? key,
    required this.product,
    required this.total,
    this.quantity,
  }) : super(key: key);

  @override
  _PrintState createState() => _PrintState(
        product,
        total,
        quantity,
      );
}

class _PrintState extends State<Print> {
  PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  String? _devicesMsg;
  BluetoothManager bluetoothManager = BluetoothManager.instance;

  final state;
  final total;
  final quantity;

  _PrintState(
    this.state,
    this.total,
    this.quantity,
  );

  @override
  void initState() {
    if (Platform.isAndroid) {
      bluetoothManager.state.listen((
        val,
      ) {
        print('state = $val');
        if (!mounted) return;
        if (val == 12) {
          print('on');
          initPrinter();
        } else if (val == 10) {
          print('off');
          setState(() => _devicesMsg = 'Bluetooth Disconnect!');
        }
      });
    } else {
      initPrinter();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          "Print",
          style: TextStyle(color: Colors.amber),
        ),
        centerTitle: true,
        shadowColor: Colors.black,
        backgroundColor: Colors.green.shade300,
      ),
      body: _devices.isEmpty
          ? Center(child: Text(_devicesMsg ?? ""))
          : ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (c, i) {
                return ListTile(
                  leading: Icon(Icons.print),
                  title: Text(_devices[i].name ?? ""),
                  subtitle: Text(_devices[i].address!),
                  onTap: () {
                    _startPrint(_devices[i]);
                  },
                );
              },
            ),
    );
  }

  void initPrinter() {
    _printerManager.startScan(Duration(seconds: 2));
    _printerManager.scanResults.listen((val) {
      if (!mounted) return;
      setState(() => _devices = val);
      if (_devices.isEmpty) setState(() => _devicesMsg = 'No Devices');
    });
  }

  Future<void> _startPrint(PrinterBluetooth printer) async {
    _printerManager.selectPrinter(printer);
    final result =
        await _printerManager.printTicket(await _ticket(PaperSize.mm80));
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(result.msg),
      ),
    );
  }

  Future<Ticket> _ticket(PaperSize paper) async {
    final ticket = Ticket(paper);
    final ByteData data = await rootBundle.load('images/logo.jpeg');
    final Uint8List bytes = data.buffer.asUint8List();
    final Image? image = decodeImage(bytes);
    ticket.image(image);

    ticket.text(
      'KHUSHI',
      styles: const PosStyles(
          bold: true,
          align: PosAlign.left,
          height: PosTextSize.size2,
          width: PosTextSize.size2),
      linesAfter: 1,
    );
    ticket.row([
      PosColumn(
          text: 'Bestellnummer: ', width: 12, styles: PosStyles(bold: true)),
    ]);

    ticket.row([
      PosColumn(
          text: '-------------------------------',
          width: 12,
          styles: PosStyles(bold: true)),
    ]);

    for (var i = 0; i < widget.product.length; i++) {
      
      ticket.row([
        PosColumn(text:widget.product[i].name,width:8 ),
        PosColumn(
            text:
                '${widget.product[i].price}x ${widget.product[i].quantity.toString()}',
            width: 4),
      ]);
    }

    ticket.feed(1);

    ticket.row([
      PosColumn(
          text: '-------------------------------',
          width: 12,
          styles: PosStyles(bold: true)),
    ]);
    ticket.row([
      PosColumn(text: 'Total:-', width: 6, styles: PosStyles(bold: true)),
      PosColumn(
          text: total.toString(),
          width: 6,
          styles: PosStyles(bold: true)),
    ]);

    ticket.row([
      PosColumn(
          text: '-------------------------------',
          width: 12,
          styles: PosStyles(bold: true)),
    ]);
    ticket.text(
      'Cash:',
      styles: PosStyles(
          align: PosAlign.left,
          height: PosTextSize.size2,
          width: PosTextSize.size1),
      linesAfter: 0,
    );

    ticket.feed(1);

    ticket.text('Hotel Lemon',
        styles: PosStyles(align: PosAlign.left, bold: true));

    ticket.text('Bhagwati road,Inaruwa.',
        styles: PosStyles(align: PosAlign.left, bold: true));
    ticket.text('Sunsari Nepal.',
        styles: PosStyles(align: PosAlign.left, bold: true));

    ticket.text('Inaruwa 56703.',
        styles: PosStyles(align: PosAlign.left, bold: true));

    ticket.feed(1);
    ticket.text('tax number: 34/535/00093',
        styles: PosStyles(align: PosAlign.left, bold: true));

    ticket.feed(1);
    ticket.row([
      PosColumn(
        text: 'Thanks for your purchase',
        width: 12,
        styles: PosStyles(align: PosAlign.left, bold: true),
      )
    ]);
    ticket.row([
      PosColumn(
        text: 'Exchange only with receipt',
        width: 12,
        styles: PosStyles(align: PosAlign.left, bold: true),
      )
    ]);
    ticket.feed(1);

    ticket.text('Contact', styles: PosStyles(align: PosAlign.left, bold: true));

    ticket.text('hotellemon.np@gmail.com\n+977982-5356883',
        styles: PosStyles(align: PosAlign.left, bold: true));

    ticket.cut();

    return ticket;
  }

  @override
  void dispose() {
    _printerManager.stopScan();
    super.dispose();
  }
}
