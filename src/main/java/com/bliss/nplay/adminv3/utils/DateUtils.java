package com.bliss.nplay.adminv3.utils;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

public class DateUtils {

	private static final String PATTERN_DATE = "yyyy-MM-dd HH:mm:ss";

	private static final ThreadLocal<DateFormat> DATE_FORMAT = new ThreadLocal<DateFormat>() {
		@Override
		public DateFormat get() {
			DateFormat f = super.get();
			if (f == null) {
				f = new SimpleDateFormat(PATTERN_DATE);
				f.setTimeZone(TimeZone.getTimeZone("GMT+7"));
				set(f);
			}
			return f;
		}
	};

	public static Date getDateTime(String strDate) throws IOException {
		if (strDate != null) {
			try {
				return DATE_FORMAT.get().parse(strDate);
			} catch (ParseException e) {
				throw new IOException("failed to parse dateTime: " + strDate);
			}
		}
		return null;
	}

	public static String getDateTime(Date date) throws IOException {
		if (date == null) {
			return null;
		}
		return DATE_FORMAT.get().format(date);
	}

	public static String getDateTime(long lmiliseconds)  {
		Date origDate = new Date(lmiliseconds);
		return DATE_FORMAT.get().format(origDate);
	}

	public static Date addDays(Date origDate, int days) {
		Calendar cal = Calendar.getInstance(); 	
		cal.setTime(origDate); 
		cal.add(Calendar.DATE, days);
		return cal.getTime();
	}
	
	public static Date subtractDays(Date origDate, int days) {
		Calendar cal = Calendar.getInstance(); 	
		cal.setTime(origDate); 
		cal.add(Calendar.DATE, -days);
		return cal.getTime();
	}

}
