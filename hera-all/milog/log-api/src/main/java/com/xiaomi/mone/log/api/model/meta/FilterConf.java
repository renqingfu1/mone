package com.xiaomi.mone.log.api.model.meta;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
public class FilterConf {
    private String code;
    private FilterName name;
    private FilterType type;
    private Integer order;
    private String lifecycle;
    private Map<String, String> args;
}