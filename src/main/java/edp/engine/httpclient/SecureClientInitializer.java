package edp.engine.httpclient;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class SecureClientInitializer {
    private static final InheritableThreadLocal<DefaultSecureHttpClient> DEFAULT_SECURE_HTTP_CLIENT_THREAD_SAFE =
            new InheritableThreadLocal<>();
    public static void setDefaultSecureHttpClient() {
        DEFAULT_SECURE_HTTP_CLIENT_THREAD_SAFE.set(new DefaultSecureHttpClient());
    }
    public static DefaultSecureHttpClient getDefaultSecureHttpClient() {
        return DEFAULT_SECURE_HTTP_CLIENT_THREAD_SAFE.get();
    }
}
