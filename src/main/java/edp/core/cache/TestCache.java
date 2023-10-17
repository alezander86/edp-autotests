package edp.core.cache;

import edp.core.enums.testcachemanagement.TestCacheKey;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import org.assertj.core.api.Assertions;

import java.util.Objects;
import java.util.concurrent.ConcurrentHashMap;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class TestCache {

    private static class TestSessionMap extends ConcurrentHashMap {
        @Override
        public Object put(final Object key, final Object value) {
            return Objects.isNull(value) ? super.remove(key) : super.put(key, value);
        }
    }

    private static TestSessionMap getCache() {
        return CACHE.get();
    }

    private static final ThreadLocal<TestSessionMap> CACHE = new InheritableThreadLocal<>();

    public static void initializeTestCache() {
        CACHE.set(new TestSessionMap());
    }

    public static void clearCache() {
        getCache().clear();
        CACHE.remove();
    }

    public static boolean containsKey(final TestCacheKey key) {
        return getCache().containsKey(key);
    }

    public static void putDataInCache(final TestCacheKey key, final Object value) {
        getCache().put(key, value);
    }

    public static Object get(final TestCacheKey key) {
        return getCache().get(key);
    }

    @SuppressWarnings("unchecked")
    public static <T> T get(final TestCacheKey key, final Class<?> type) {
        Object value = getCache().get(key);
        if (Objects.nonNull(value)) {
            Assertions.assertThat(value).as("Incompatible type of returned from TestCache object")
                    .isInstanceOf(type);
        }
        return Objects.nonNull(value) ? (T) value : null;
    }
}
