import java.io.*;
import java.util.Scanner;

/**
 * Created by fjy on 15/04/27.
 */
public class SplitDateTime {
    public void split(File inputFile, File outputFile) throws IOException {
        Scanner in = new Scanner(inputFile);
        PrintWriter pw = new PrintWriter(new BufferedWriter(new FileWriter(outputFile)));
        while(in.hasNext())
        {
            String s = in.nextLine();


            int yearIndex = s.indexOf("年");
            int monthIndex = s.indexOf("月");
            int dayIndex = s.indexOf("日");
            int hourIndex = s.indexOf("時");
            int minuteIndex = s.indexOf("分");
            int secondIndex = s.indexOf("秒");


            String year = s.substring(1, yearIndex);
            String month = s.substring(yearIndex + 1, monthIndex);
            String day = s.substring(monthIndex + 1, dayIndex);
            String hour = s.substring(hourIndex - 2, hourIndex);
            String minute = s.substring(hourIndex + 1, minuteIndex);
            String second = s.substring(minuteIndex + 1, secondIndex);

            String date = "\"" + year + month + day + "\"";
            String time = "\"" + hour + minute + second + "\"";
            String newline = date + "," + time + "," + s.substring(secondIndex + 2);

            pw.println(newline);

        }
        pw.close();
    }
}
