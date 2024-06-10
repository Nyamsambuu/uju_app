import 'package:flutter/material.dart';
import 'package:uju_app/theme/app_theme.dart';

class ProductReturnPolicy extends StatelessWidget {
  const ProductReturnPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              'Хүргэлт / Буцаан олголтын мэдээлэл',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            trailing:
                Icon(Icons.chevron_right, color: AppTheme.textSecondaryColor),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeliveryReturnPolicyScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DeliveryReturnPolicyScreen extends StatelessWidget {
  const DeliveryReturnPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Хүргэлт / Буцаан олголт',
            style: Theme.of(context).textTheme.bodyLarge),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Хүргэлтийн талаар мэдээлэл',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8.0),
            _buildInfoRow(
                context, 'Хүргэлтийн арга', 'Ердийн шуудангийн бүтээгдэхүүн'),
            _buildInfoRow(context, 'Хүргэлтийн төлбөр', '3,000 вон'),
            _buildInfoRow(context, 'Төлбөрийн арга', 'Урьдчилсан төлбөр'),
            _buildInfoRow(context, 'Үнэгүй хүргэлт',
                '100,000 воныг давсан худалдан авалтанд үнэгүй хүргэлт'),
            _buildInfoRow(
                context, 'Номын сангийн нэмэлт хүргэлтийн төлбөр', '5,000 вон'),
            _buildInfoRow(context, 'Хүргэлт боломжгүй бүс',
                'Хүргэлт боломжгүй бүс байхгүй.'),
            Divider(thickness: 0.3, color: Colors.grey),
            Text(
              'Солилцоо / Буцаалт',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8.0),
            _buildInfoRow(context, 'Буцаалтын хүргэлтийн төлбөр',
                'Нэг талдаа 3,000 вон (эхний хүргэлт үнэгүй байсан бол 6,000 вон нэмэгдэнэ)'),
            _buildInfoRow(context, 'Солилцооны хүргэлтийн төлбөр', '6,000 вон'),
            _buildInfoRow(context, 'Илгээх хаяг',
                '(48737) Бусан, Донг-гү, Бомильро 53-р гудамж, 25-р байр, 1-р давхар, 101 тоот'),
            Divider(thickness: 0.3, color: Colors.grey),
            Text(
              'Буцаалт / солилцооны шалтгаанаас хамааран хүсэлт гаргах боломжтой хугацаа',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8.0),
            Text(
              'Буцаалт хийхээсээ өмнө худалдаалагчтай холбоо барьж, буцаалтын шалтгаан, шуудангийн компани, хүргэлтийн төлбөр, буцаах хаяг зэрэгтэй тохиролцсоны дараа буцаах бүтээгдэхүүнийг илгээнэ үү.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 8.0),
            Text(
              '1. Худалдан авагчийн энгийн бодол өөрчлөгдсөн бол бараа хүлээн авснаас хойш 7 хоногийн дотор (худалдан авагч буцаалтын хүргэлтийн төлбөрийг хариуцна)',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '2. Зар сурталчилгаа болон гэрээний агуулгаас өөр байсан тохиолдолд барааг хүлээн авснаас хойш 3 сарын дотор, эсвэл үүнийг мэдсэнээс хойш 30 хоногийн дотор.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
