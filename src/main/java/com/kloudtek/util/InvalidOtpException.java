package com.kloudtek.util;

/**
 * Created by yinkaf on 27/03/2014.
 */
public class InvalidOtpException extends Exception {
    public InvalidOtpException() {
        super();
    }

    public InvalidOtpException(String message) {
        super(message);
    }

    public InvalidOtpException(String message, Throwable cause) {
        super(message, cause);
    }

    public InvalidOtpException(Throwable cause) {
        super(cause);
    }

}
