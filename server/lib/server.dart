import 'package:mongo_dart/mongo_dart.dart';
import 'package:sevr/sevr.dart';

void start() async {
  // Log into database
  final db = await Db.create(
      'mongodb+srv://admin:%l4u7Xfh@cluster0.ytwge.mongodb.net/test?retryWrites=true&w=majority');
  await db.open();

  final coll = db.collection('contacts');
  /*print(await coll.find().toList());*/

  // TODO Create Server
  const port = 8081;
  final serv = Sevr();

  serv.get('/', [
    (ServRequest req, ServResponse res) async {
      final contacts = await coll.find().toList();
      return res.status(200).json({'contacts': contacts});
    }
  ]);

  serv.post('/', [
    (ServRequest req, ServResponse res) async {
      await coll.save(req.body);
      return res.json(
        await coll.findOne(where.eq('name', req.body['name'])),
      );
    }
  ]);

  serv.delete('/:id', [
    (ServRequest req, ServResponse res) async {
      await coll
          .remove(where.eq('_id', ObjectId.fromHexString(req.params['id'])));
      return res.status(200);
    }
  ]);

  // TODO Listen for connections
  serv.listen(port, callback: () {
    print('Server listening on port: $port');
  });
}
