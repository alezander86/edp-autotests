package edp.utils.strings;

import java.util.Base64;
import org.apache.commons.lang.RandomStringUtils;

public class StringsHelper {

    public static String decode(String encodedValue) {
        return new String(Base64.getDecoder().decode(encodedValue));
    }

    public static String encode(String decodedValue) {
        return Base64.getEncoder().encodeToString(decodedValue.getBytes());
    }

    public static String getRandomStringWithLength(int length) {
        return RandomStringUtils.random(length, true, true);
    }
}
