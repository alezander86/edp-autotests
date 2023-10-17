package edp.core.annotations;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import static joptsimple.internal.Strings.EMPTY;

@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface CurrentUrl {
    String value() default EMPTY;

    String[] urls() default {};
}
