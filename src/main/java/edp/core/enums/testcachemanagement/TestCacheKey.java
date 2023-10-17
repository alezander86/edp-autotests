package edp.core.enums.testcachemanagement;

import lombok.Getter;

public enum TestCacheKey {
    ACCESS_TOKEN("access_token"),
    AC_CREATOR_PASSWORD("password"),
    ADMIN_CONSOLE_CLIENT_PASSWORD("password"),
    CHANGE_ID("change_id"),
    COMPONENT_NAME("name"),
    FORK_GITLAB_PROJECT_ID("id"),

    FORK_GITLAB_SUBGROUP_ID("id"),
    FORK_GITLAB_PROJECT_PATH_WITH_NAMESPACE("path_with_namespace"),
    GITLAB_MERGE_REQUEST_IID("iid"),
    GENERATED_GITHUB_PROJECT_URL("clone_url"),
    SHA_FOR_HEAD_GITHUB("sha"),
    GITHUB_PULL_REQUEST_NUMBER("number"),
    JIRA_TICKET_KEY("key"),
    USER_INPUT_ID("id"),
    INPUT_APPLICATION_NAME("name"),
    FIRST_INPUT_APPLICATION_NAME("name"),
    SECOND_INPUT_APPLICATION_NAME("name"),
    INPUT_APPLICATION_VERSION("1"),
    FIRST_INPUT_APPLICATION_VERSION("1"),
    SECOND_INPUT_APPLICATION_VERSION("1"),
    PROCEED_INPUT_ID("id"),
    IMAGE_VERSION("image"),
    LINK_NAME("name"),
    LINK_URL("url"),

    SUBGROUP_PATH("full_path");
    @Getter
    private final String key;
    TestCacheKey(String key) {
        this.key = key;
    }
}
