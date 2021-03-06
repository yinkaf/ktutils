/*
 * Copyright (c) 2014 Kloudtek Ltd
 */

package com.kloudtek.util.logging;

import java.util.logging.ConsoleHandler;
import java.util.logging.Handler;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Logging related utilities
 */
public class LoggingUtils {
    public static void setupSimpleLogging(Level lvl, boolean showLevel, boolean showTimestamp) {
        for (final Handler handler : Logger.getLogger("").getHandlers()) {
            if (handler instanceof ConsoleHandler) {
                final SimpleLogFormatter logFormatter = new SimpleLogFormatter();
                logFormatter.setShowLevel(showLevel);
                logFormatter.setShowTimestamp(showTimestamp);
                handler.setFormatter(logFormatter);
                handler.setLevel(lvl);
            }
        }
    }
}
