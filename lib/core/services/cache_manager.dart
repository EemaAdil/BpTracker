import 'dart:convert';

import 'package:get_storage/get_storage.dart';

mixin CacheManager {

  Future<bool> saveUserName(String? userName) async {
    final storage = GetStorage();
    await storage.write(CMUserName.userName.toString(), userName);
    return true;
  }

  String? getUserName() {
    final storage = GetStorage();
    return storage.read(CMUserName.userName.toString());
  }

  Future<bool> saveUserId(String? userId) async {
    final storage = GetStorage();
    await storage.write(CMUserId.userId.toString(), userId);
    return true;
  }

  String? getUserId() {
    final storage = GetStorage();
    return storage.read(CMUserId.userId.toString());
  }

  Future<bool> saveDesignation(String? designation) async {
    final storage = GetStorage();
    await storage.write(CMDesignation.designation.toString(), designation);
    return true;
  }

  String? getDesignation() {
    final storage = GetStorage();
    return storage.read(CMDesignation.designation.toString());
  }


  Future<bool> saveBranchID(String? branchId) async {
    final storage = GetStorage();
    await storage.write(CMBranchID.branchID.toString(), branchId);
    return true;
  }

  String? getBranchID() {
    final storage = GetStorage();
    return storage.read(CMBranchID.branchID.toString());
  }

  Future<bool> saveEmployeeNO(String? userName) async {
    final storage = GetStorage();
    await storage.write(CMEmployeeNO.employeeNo.toString(), userName);
    return true;
  }

  String? getEmployeeNO() {
    final storage = GetStorage();
    return storage.read(CMEmployeeNO.employeeNo.toString());
  }


  Future<bool> saveRefreshToken(String? refreshToken) async {
    final storage = GetStorage();
    await storage.write(CMRefreshToken.refreshToken.toString(), jsonEncode(refreshToken));
    return true;
  }

  String? getRefreshToken() {
    final storage = GetStorage();
    return storage.read(CMRefreshToken.refreshToken.toString());
  }


  Future<bool> saveCompanyId(String? companyId) async {
    final storage = GetStorage();
    await storage.write(CMCompanyId.companyId.toString(), companyId);
    return true;
  }

  String? getCompanyId() {
    final storage = GetStorage();
    return storage.read(CMCompanyId.companyId.toString());
  }

  Future<bool> saveCurrentAddress(String? address) async {
    final storage = GetStorage();
    await storage.write(CMCurrentAddress.currentAddress.toString(), address);
    return true;
  }

  String? getCurrentAddress() {
    final storage = GetStorage();
    return storage.read(CMCurrentAddress.currentAddress.toString());
  }

  Future<bool> saveNotificationCount(String? count) async {
    final storage = GetStorage();
    await storage.write(CMNotificationCount.notificationCount.toString(), count);
    return true;
  }

  String? getNotificationCount() {
    final storage = GetStorage();
    return storage.read(CMNotificationCount.notificationCount.toString());
  }

  Future<bool> saveFirstRun(bool value) async {
    final storage = GetStorage();
    await storage.write(CacheManagerRun.FirstRun.toString(), value);
    return true;
  }

  bool getFirstRun() {
    final storage = GetStorage();
    return storage.read(CacheManagerRun.FirstRun.toString());
  }

  Future<bool> saveFirstRunNull(bool b) async {
    final storage = GetStorage();
    await storage.writeIfNull(CacheManagerRun.FirstRun.toString(), b);
    return true;
  }


  Future<bool> removeAllData() async {
    final storage = GetStorage();
    await storage.remove(CMUserName.userName.toString());
    await storage.remove(CMCompanyId.companyId.toString());
    await storage.remove(CMDesignation.designation.toString());
    await storage.remove(CMBranchID.branchID.toString());
    await storage.remove(CMEmployeeNO.employeeNo.toString());
    await storage.remove(CMRefreshToken.refreshToken.toString());
    await storage.remove(CMCurrentAddress.currentAddress.toString());
    await storage.remove(CMNotificationCount.notificationCount.toString());
    return true;
  }


}

enum CMUserName { userName }
enum CMUserId { userId }
enum CMDesignation { designation }
enum CMEmployeeNO { employeeNo }
enum CMBranchID { branchID }
enum CMCompanyId { companyId }
enum CMRefreshToken { refreshToken }
enum CMCurrentAddress { currentAddress }
enum CMNotificationCount { notificationCount }
enum CacheManagerRun { FirstRun }
