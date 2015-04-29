import java.io.*;
import java.util.Scanner;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

/**
 * Created by fjy on 15/04/27.
 */
public class SplitDateTime {
    public void split(String input) throws IOException {
        POIFSFileSystem in = new POIFSFileSystem(new FileInputStream(input));
        HSSFWorkbook workbook = new HSSFWorkbook(in);

        HSSFSheet sheet = workbook.getSheetAt(0);

        for (int i = 1; i <= sheet.getLastRowNum(); i++) {
            HSSFRow row = sheet.getRow(i);
            HSSFCell cell = row.getCell(0);

            String s = cell.getStringCellValue();

            int yearIndex = s.indexOf("年");
            int monthIndex = s.indexOf("月");
            int dayIndex = s.indexOf("日");
            int hourIndex = s.indexOf("時");
            int minuteIndex = s.indexOf("分");
            int secondIndex = s.indexOf("秒");


            String year = s.substring(0, yearIndex);
            String month = s.substring(yearIndex + 1, monthIndex);
            String day = s.substring(monthIndex + 1, dayIndex);
            String hour = s.substring(hourIndex - 2, hourIndex);
            String minute = s.substring(hourIndex + 1, minuteIndex);
            String second = s.substring(minuteIndex + 1, secondIndex);

            String date = year + "-" + month+ "-" + day;
            String time = hour + ":" + minute + ":" + second;

            cell.setCellValue(date + " " + time);

            workbook.write(new FileOutputStream(input));


        }
    }

    public void CreateNewsList(String input, String tweetAccount) throws IOException {
        POIFSFileSystem in = new POIFSFileSystem(new FileInputStream(input));
        HSSFWorkbook workbook1 = new HSSFWorkbook(in);
        HSSFWorkbook workbook2 = new HSSFWorkbook();

        HSSFSheet sheet1 = workbook1.getSheetAt(0);
        HSSFSheet sheet2 = workbook2.createSheet("NewsList");

        int rownum = 0;

        for(int i = 0; i <= sheet1.getLastRowNum(); i ++) {
            HSSFRow row1 = sheet1.getRow(i);
            HSSFRow row2;
            HSSFCell cell = row1.getCell(1);
            String content = cell.getStringCellValue();

            if(content.contains(tweetAccount))
            {
                row2 = sheet2.createRow(rownum ++);
                for(int j = 0; j < row1.getLastCellNum(); j ++)
                {
                    HSSFCell cell1 = row1.getCell(j);
                    String cell1Value = cell1.getStringCellValue();
                    HSSFCell cell2 = row2.createCell(j);

                    cell2.setCellValue(cell1Value);
                }
            }

        }

        workbook2.write(new FileOutputStream(input.substring(0, input.lastIndexOf("/")) + "/NewsList_" + tweetAccount + ".xls"));
    }

    public void ExtractRetweets(String input, String newsFile) throws IOException {
        POIFSFileSystem in = new POIFSFileSystem(new FileInputStream(input));
        POIFSFileSystem news = new POIFSFileSystem(new FileInputStream(newsFile));
        HSSFWorkbook workbook1 = new HSSFWorkbook(in);
        HSSFWorkbook workbookNews = new HSSFWorkbook(news);

        HSSFSheet sheet1 = workbook1.getSheetAt(0);
        HSSFSheet sheetNews = workbookNews.getSheetAt(0);


        for(int k = 0; k <= sheetNews.getLastRowNum(); k ++) {
            HSSFSheet sheet2 = workbookNews.createSheet(String.valueOf(k));
            HSSFRow rowNews = sheetNews.getRow(k);
            HSSFCell cellNewsBody = rowNews.getCell(2);
            String newsContent = cellNewsBody.getStringCellValue();

            int writtenRows = 1;

            HSSFRow head = sheet2.createRow(0);
	        HSSFCell date = head.createCell(0);
	        HSSFCell address = head.createCell(1);
	        HSSFCell body = head.createCell(2);
	        HSSFCell platform = head.createCell(3);
	        HSSFCell site = head.createCell(4);

	        date.setCellValue("date");
	        address.setCellValue("address");
	        body.setCellValue("body");
	        platform.setCellValue("platform");
	        site.setCellValue("site");
            for (int i = 1; i <= sheet1.getLastRowNum(); i++) {
                HSSFRow row1 = sheet1.getRow(i);
                HSSFRow row2;
                HSSFCell cell = row1.getCell(2);

                String s = cell.getStringCellValue();

                if (s.contains(newsContent)) {
                    row2 = sheet2.createRow(writtenRows ++);
                    for (int j = 0; j < row1.getLastCellNum(); j++) {
                        HSSFCell cell1 = row1.getCell(j);
                        String cell1Value = cell1.getStringCellValue();
                        HSSFCell cell2 = row2.createCell(j);

                        cell2.setCellValue(cell1Value);
                    }


                }
            }
        }
        workbookNews.write(new FileOutputStream(newsFile));

    }
}
