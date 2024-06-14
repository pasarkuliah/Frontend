import 'package:flutter/material.dart';
import 'package:nama_proyek/api/apiclient.dart';
import 'package:nama_proyek/resposne/cart_response.dart';

class BillingInformationScreen extends StatefulWidget {
  final List<Cart> cartItems;

  const BillingInformationScreen({Key? key, required this.cartItems})
      : super(key: key);

  @override
  _BillingInformationState createState() => _BillingInformationState();
}

class _BillingInformationState extends State<BillingInformationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _selectedPaymentMethod;

  Future<void> _submitOrder() async {
    final name = _nameController.text;
    final address = _addressController.text;
    final city = _cityController.text;
    final phone = _phoneController.text;

    if (name.isNotEmpty &&
        address.isNotEmpty &&
        city.isNotEmpty &&
        phone.isNotEmpty &&
        _selectedPaymentMethod != null) {
      final success = await ApiClient.checkoutProcess(
        name: name,
        address: address,
        city: city,
        phone: phone,
        paymentMethod: _selectedPaymentMethod!,
        cartItems: widget.cartItems,
      );

      if (success) {
        // Navigasi ke layar pembayaran berhasil
        Navigator.of(context).pushNamed('/Billing');
      } else {
        // Tampilkan pesan kesalahan jika checkout gagal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ops kamu sudah melakukan checkout di cart ini.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // Tampilkan pesan jika ada input yang kosong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields and select payment method.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var styleFrom = ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
    );
    var styleFrom2 = styleFrom;
    return Scaffold(
      appBar: AppBar(
        title: Text('Billing Information'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed("/ShoppingCart");
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter Your Name',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                hintText: 'Enter Your Address',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'City',
                hintText: 'Enter Your City',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter Your Phone Number',
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedPaymentMethod,
              hint: Text('Select Your Payment Method'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPaymentMethod = newValue;
                });
              },
              items: <String>['Cash On Delivery']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 40),
            Center(
              child: InkWell(
                onTap: _submitOrder,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Lakukan Pesanan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
