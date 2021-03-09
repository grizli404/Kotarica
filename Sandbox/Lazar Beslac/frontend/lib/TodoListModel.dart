import 'dart:convert';
import 'dart:js';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class TodoListModel extends ChangeNotifier{

  List<Task> todos = [];
  bool isLoading = true;
  int taskCounter = 0; //Ovu f-ju cemo da pozivamo sa fronta da nam kaze koliko ima taskova

  final String rpcUrl = "http://192.168.0.24:7545";
  final String wsUrl = "ws://192.168.0.24:7545/";

  final String privateKey = "451dfed9d2d8832da083a8cf910041348d4cf01944ddbf68d17210577c79330c";

  Credentials credentials;
  Web3Client client;
  String abiCode;
  EthereumAddress contractAddress;
  EthereumAddress ownAddress;
  DeployedContract contract;
  ContractFunction taskCount;
  ContractFunction tasks;
  ContractFunction createTask;

  TodoListModel(){
    initialeSetup();
  }

  Future<void> initialeSetup() async{
    client = Web3Client(rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async{
    String abiStringFile = await rootBundle.loadString("src/abis/TodoList.json");

    var jsonAbi = jsonDecode(abiStringFile);
    abiCode = jsonEncode(jsonAbi["abi"]);
    contractAddress = EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    print(contractAddress);
  }

  Future<void> getCredentials() async {
    credentials = await client.credentialsFromPrivateKey(privateKey);
    ownAddress = await credentials.extractAddress();
  }

  Future<void> getDeployedContract() async {
    contract = DeployedContract(ContractAbi.fromJson(abiCode, "TodoList"), contractAddress);
  
    taskCount = contract.function("taskCount");
    tasks = contract.function("tasks");
    createTask = contract.function("createTask");

    getTodos();
    //print();
  }

  //Sve Taskove pakuje u listu
  //I ta list (todos) moze da se koristi na frontu
  getTodos() async{
    List totalTasksList = await client.call(contract: contract, function: taskCount, params: []);

    BigInt totalTasks = totalTasksList[0];
    taskCounter = totalTasks.toInt();
    //todos je niz svih nasih taskova
    todos.clear();
    for (var i = 0; i < totalTasks.toInt(); i++) {
      var temp = await client.call(contract: contract, function: tasks, params: [BigInt.from(i)]);
      
      todos.add(Task(id: i, content: temp[1], completed: temp[2]));
    }

    isLoading = false;
    notifyListeners();
  }

  addTask(String taskContent) async {
    isLoading = true;
    notifyListeners();

    await client.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: createTask,
        parameters: [taskContent]
      ));

    getTodos(); // Da bi novi Task bio vidljiv(da bi bio dodat u listu)
  }

}

class Task {
  int id;
  String content;
  bool completed;

  Task({this.id, this.content, this.completed});
}