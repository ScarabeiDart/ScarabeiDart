library com.jfixby.scarabei.api.time;

abstract class TimeStream
{
    static int SECOND = 1000;
    static int MINUTE = (SECOND * 60);
    static int HOUR = (MINUTE * 60);
    static int DAY = (HOUR * 24);
    static int WEEK = (DAY * 7);

    int currentTimeMillis();
}
