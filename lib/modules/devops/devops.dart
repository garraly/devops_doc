import 'dart:io';

import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

class StoryData extends Object {
  String title;
  String acceptanceCriteria;
  DateTime? sit;
  DateTime? uat;
  String po;
  bool isDevops = true;
  int id;
  List<TaskData> tasks = [];
  StoryData(this.id,this.title, this.acceptanceCriteria, this.po,this.sit, this.uat);
}

class TaskData extends Object {
  String title;
  DateTime? date;
  String workTime;
  String person;
  TaskData(this.title,this.date,this.workTime,this.person);
}


class DevopsData {
  List<StoryData> storydata = [];

  DateTime? _formatDateFromExcelCell(dynamic value) {
    if(value is SharedString) {
      return DateTime.parse(value.toString().substring(0,10));
    }
    if (value is String) {
      return DateTime.parse(value.substring(0,10));
    }
    if (value is int) {
      return DateTime.parse('1899-12-30').add(Duration(days: value));
    }
    return null;
  }

  generateFormExcel(String filePath) {
    storydata = [];
    var bytes = File(filePath).readAsBytesSync();
    Excel excel = Excel.decodeBytes(bytes);
    String tableKey = excel.tables.keys.first;
    Sheet sheet = excel.tables[tableKey] as Sheet;

    if(sheet.rows.isEmpty) {
      return;
    }

    List<Data?> header = sheet.rows.first;
    sheet.removeRow(0);
    int taskColIndex = header.indexWhere((element) => element?.value?.toString() == 'Task');
    int storyColIndex = header.indexWhere((element) => element?.value?.toString() == 'Story');
    int personColIndex = header.indexWhere((element) => element?.value?.toString() == '开发/测试');
    int dateColIndex = header.indexWhere((element) => element?.value?.toString() == '完成日期');
    int workTimeColIndex = header.indexWhere((element) => element?.value?.toString() == '工时');
    int sitColIndex = header.indexWhere((element) => element?.value?.toString() == 'SIT时间');
    int uatColIndex = header.indexWhere((element) => element?.value?.toString() == 'UAT时间');
    int poColIndex = header.indexWhere((element) => element?.value?.toString() == 'PO');
    int acceptanceCriteriaColIndex = header.indexWhere((element) => element?.value?.toString() == '验收标准');

    for (var row in sheet.rows) {
        String task = '';
      if (taskColIndex >= 0) { 
        task = row.elementAt(taskColIndex)?.value?.toString() ?? '';
      }
      String story = '';
      if(storyColIndex>=0) {
        story = row.elementAt(storyColIndex)?.value?.toString() ?? '';
      }
      String person = '';
      if(personColIndex>=0) {
        person = row.elementAt(personColIndex)?.value?.toString() ?? '';
      }
      DateTime? date;
      String workTime = '';
      if(workTimeColIndex>=0) {
        workTime = row.elementAt(workTimeColIndex)?.value?.toString() ?? '';
      }
      DateTime? sit;
      DateTime? uat;

      String po = "";
      if(poColIndex>=0) {
        po = row.elementAt(poColIndex)?.value?.toString() ?? "";
      }

      String acceptanceCriteria = "";
      if(acceptanceCriteriaColIndex>=0) {
        acceptanceCriteria = row.elementAt(acceptanceCriteriaColIndex)?.value?.toString() ?? "";
      }

      if(story.isEmpty) {
        continue;
      }

      if (dateColIndex>= 0) {
        date = _formatDateFromExcelCell(row.elementAt(dateColIndex)?.value);
        print(date.runtimeType);
      }

      if (sitColIndex>= 0) {
        sit = _formatDateFromExcelCell(row.elementAt(sitColIndex)?.value);
      }

      if (uatColIndex>= 0) {
        uat = _formatDateFromExcelCell(row.elementAt(uatColIndex)?.value);
      }
      
      int storyIndex = storydata.indexWhere((element) => element.title == story);
      StoryData storyItem;
      if(storyIndex ==-1) {
        storyItem = StoryData(storydata.length,story,acceptanceCriteria,po,sit,uat);
        storydata.add(storyItem);
      } else {
        storyItem = storydata.elementAt(storyIndex);
      }
      storyItem.tasks.add(TaskData(task, date, workTime, person));
    }
  }

  confirmDevopsStory(int id) {
    storydata[id].isDevops = true;
  }

  confirmCommonStory(int id) {
    storydata[id].isDevops = false;
  }

  exportToExcel() async {
    // var bytes = File('assets/template.xlsx').readAsBytesSync();
    Excel excel = Excel.createExcel();
    Sheet sheet = excel.tables[excel.tables.keys.first] as Sheet;
    sheet.setColWidth(0, 32);
    sheet.setColWidth(1, 43.83);
    sheet.setColWidth(2, 32);
    sheet.setColWidth(3, 43.83);

    List<int> indexTag = [];

    bool firstCol = true;
    for(var element in storydata) {
      int currentIndex = sheet.maxRows;
      String storyColTag = 'A';
      String taskColTag = 'B';

      if(!firstCol) {
        currentIndex = indexTag.last;
        storyColTag = 'C';
        taskColTag = 'D';
        firstCol = true;
      } else {
        firstCol = false;
        indexTag.add(currentIndex);
      }
      int taskLength = element.tasks.length < 6 ? 6 : element.tasks.length;
      String special = element.isDevops ? "专项" : "非专项";
      sheet.merge(CellIndex.indexByString("$storyColTag${currentIndex+1}"), CellIndex.indexByString("$storyColTag${currentIndex+taskLength}"));
      sheet.cell(CellIndex.indexByString("$storyColTag${currentIndex+1}")).value = "1.需求类型：$special"'\r\n'"2.名称：${element.title}"'\r\n'"3.SIT上线时间：${element.sit?.month ?? ""}/${element.sit?.day ?? ""}"'\r\n'"4.UAT上线时间：${element.uat?.month ?? ""}/${element.uat?.day ?? ""}"'\r\n'"5.验收条件：${element.acceptanceCriteria}";
      CellStyle storyCellStory = sheet.cell(CellIndex.indexByString("$storyColTag${currentIndex+1}")).cellStyle ?? CellStyle();
      sheet.cell(CellIndex.indexByString("$storyColTag${currentIndex+1}")).cellStyle = storyCellStory.copyWith(
        fontSizeVal: 11,
        textWrappingVal: TextWrapping.WrapText,
        verticalAlignVal: VerticalAlign.Top,
        fontFamilyVal: "Microsoft YaHei"
      );

      for(int taskIndex = 0; taskIndex < taskLength; taskIndex++) {
        if(taskIndex < element.tasks.length) {
          TaskData taskElement = element.tasks[taskIndex];
          String date =  "";
          if (taskElement.date != null) {
            date = "${taskElement.date!.month}/${taskElement.date!.day}";
          }
          sheet.cell(CellIndex.indexByString("$taskColTag${currentIndex+1+taskIndex}")).value = "${taskElement.title}"'\r\n'"${date.padRight(19)}${('${taskElement.workTime}H').padRight(13)}${taskElement.person}";
          
          CellStyle taskCellStyle = sheet.cell(CellIndex.indexByString("$taskColTag${currentIndex+1+taskIndex}")).cellStyle ?? CellStyle();
          sheet.cell(CellIndex.indexByString("$taskColTag${currentIndex+1+taskIndex}")).cellStyle = taskCellStyle.copyWith(
            backgroundColorHexVal: "fff2cc",
            fontSizeVal: 11,
            textWrappingVal: TextWrapping.WrapText,
            verticalAlignVal: VerticalAlign.Top,
            fontFamilyVal: "Microsoft YaHei"
          );
        } else {
          sheet.cell(CellIndex.indexByString("$taskColTag${currentIndex+1+taskIndex}")).value = "\r\n";
        }
      }
    }

    var fileBytes = excel.save() as List<int>;
    var directory = await getDownloadsDirectory();

    File("${directory?.path}/敏捷故事卡片.xlsx")///保存Excel的路径
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes);
  }
}