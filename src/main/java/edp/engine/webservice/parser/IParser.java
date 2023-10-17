package edp.engine.webservice.parser;

import com.google.gson.Gson;
import com.google.gson.internal.bind.JsonTreeWriter;
import com.google.gson.stream.JsonWriter;

import java.lang.reflect.Type;

public interface IParser {
    static <T> T fromJson(final String json, final Class<T> returnType) {
        return new Gson().fromJson(json, returnType);
    }
    static <T> T fromJson(final String json, final Type type) {
        return new Gson().fromJson(json, type);
    }
    static String toJson(final Object o) {
        return new Gson().newBuilder().setPrettyPrinting().create().toJson(o);
    }
    static String toJson(final Object o, JsonWriter writer) {
        Gson gson = new Gson();
        gson.toJson(o, o.getClass(), writer);
        return ((JsonTreeWriter) writer).get().toString();
    }
    static String toJson(final Object o, final Type type) {
        return new Gson().toJson(o, type);
    }
}
