// import 'package:socket_io/socket_io.dart';
//
// class LocalhostServer{
//   /// 启动服务器并监听指定端口。
//   void start(int port) {
//     {
//       // 创建一个新的Socket.IO服务器实例。
//       var io = Server();
//
//       // 创建一个自定义命名空间'/some'。
//       var nsp = io.of('/some');
//
//       /// '/some'命名空间的连接事件监听器。
//       /// 当客户端连接时，监听'msg'事件并作出响应。
//       nsp.on('connection', (client) {
//         print('连接到/some'); // 当客户端连接到'/some'时记录日志。
//
//         /// '/some'命名空间中'msg'事件的监听器。
//         /// 记录接收到的数据并向客户端发送响应。
//         client.on('msg', (data) {
//           print('来自/some的数据 => $data'); // 记录接收到的消息。
//           client.emit('fromServer', "ok 2"); // 向客户端发送响应。
//         });
//       });
//
//       /// 默认命名空间的连接事件监听器。
//       /// 当客户端连接时，监听'msg'事件并作出响应。
//       io.on('connection', (client) {
//         print('连接到默认命名空间'); // 当客户端连接到默认命名空间时记录日志。
//
//         /// 默认命名空间中'msg'事件的监听器。
//         /// 记录接收到的数据并向客户端发送响应。
//         client.on('msg', (data) {
//           print('来自默认命名空间的数据 => $data'); // 记录接收到的消息。
//           client.emit('fromServer', "ok"); // 向客户端发送响应。
//         });
//       });
//
//       // 启动服务器并监听3000端口。
//       io.listen(3000);
//     }
//   }
// }
