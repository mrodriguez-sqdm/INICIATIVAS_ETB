package com.globant.jwt.exception;

public class NotAuthorizedTransformerException extends Exception
{
    public NotAuthorizedTransformerException(final String message) {
        super(message);
    }
}