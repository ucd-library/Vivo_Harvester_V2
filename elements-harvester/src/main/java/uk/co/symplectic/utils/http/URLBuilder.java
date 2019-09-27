/*
 * ******************************************************************************
 *   Copyright (c) 2019 Symplectic. All rights reserved.
 *   This Source Code Form is subject to the terms of the Mozilla Public
 *   License, v. 2.0. If a copy of the MPL was not distributed with this
 *   file, You can obtain one at http://mozilla.org/MPL/2.0/.
 * ******************************************************************************
 *   Version :  ${git.branch}:${git.commit.id}
 * ******************************************************************************
 */
package uk.co.symplectic.utils.http;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

/**
 * Class to build a URL from a base URL, paths and any QueryString parameters.
 * The ToString() method will return the full URL, with the parameters URL encoded and appended correctly.
 */

public class URLBuilder {
    private StringBuilder url;
    private List<URLParam> params;

    public URLBuilder(String urlBase) {
        url = new StringBuilder();
        url.append(urlBase);
        params = new ArrayList<URLParam>();
    }

    public void appendPath(String path) {
        if (path.contains("?")) {
            throw new IllegalArgumentException("Path can not contain a question mark");
        }

        if (url.charAt(url.length() - 1) == '/') {
            if (path.startsWith("/")) {
                 url.append(path.substring(1));
            } else {
                url.append(path);
            }
        } else {
            if (path.startsWith("/")) {
                url.append(path);
            } else {
                url.append("/").append(path);
            }
        }
    }

    public void addParam(String name, String value) {
        params.add(new URLParam(name, value));
    }

    public String toString() {
        String querySeparator = "?";
        StringBuilder urlBuilder = new StringBuilder();
        urlBuilder.append(url);
        if (params.size() > 0) {
            for (URLParam param : params) {
                urlBuilder.append(querySeparator);
                querySeparator = "&";
                try {
                    urlBuilder.append(URLEncoder.encode(param.name, "UTF-8"));
                    urlBuilder.append("=");
                    urlBuilder.append(URLEncoder.encode(param.value, "UTF-8"));
                } catch (UnsupportedEncodingException ignored) {
                }
            }
        }

        return urlBuilder.toString();
    }

    /**
     * Simple class to represent a QueryString parameter, key and value as strings
     */
    @SuppressWarnings("unused")
    private class URLParam {
        private String name;
        private String value;

        URLParam(String name, String value) {
            this.name = name;
            this.value = value;
        }

        String getName() {
            return name;
        }

        String getValue() {
            return value;
        }
    }
}
