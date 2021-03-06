/*
 * Copyright (c) 2014 Kloudtek Ltd
 */

package com.kloudtek.util;

import java.io.Closeable;
import java.io.File;
import java.io.IOException;

/**
 * Used to create a temporary file with restricted permissions (only owner can read/write/execute)
 */
public class TempFile extends File implements Closeable {
    public TempFile(String prefix, String suffix) throws IOException {
        super(genPath(prefix, suffix));
    }

    public TempFile(String prefix) throws IOException {
        super(genPath(prefix, "tmp"));
    }

    private static String genPath(String prefix, String suffix) throws IOException {
        final File tmp = File.createTempFile(prefix, suffix);
        boolean permChange = tmp.setReadable(false, false);
        permChange = permChange && tmp.setWritable(false, false);
        permChange = permChange && tmp.setExecutable(false, false);
        permChange = permChange && tmp.setReadable(true, true);
        permChange = permChange && tmp.setWritable(true, true);
        if (!permChange) {
            throw new IOException("Unable to change permissions on temp dir: " + tmp.getPath());
        }
        return tmp.getPath();
    }

    /**
     * Deletes the files, or should it fail to, schedule it for deletion using {@link java.io.File#deleteOnExit()}
     *
     * @throws IOException If an error occurs while deleting the file.
     */
    public void close() throws IOException {
        if (!delete()) {
            deleteOnExit();
        }
    }
}
