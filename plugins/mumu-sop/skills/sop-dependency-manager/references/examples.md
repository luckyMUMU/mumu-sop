# 依赖管理示例

本文档提供依赖升级和管理的常见场景和示例。

---

## 依赖升级场景

### 1. 版本升级检查流程

**步骤**:
1. 检查当前版本和新版本
2. 阅读 CHANGELOG 和迁移指南
3. 评估破坏性变更影响
4. 在隔离分支进行升级
5. 运行测试套件
6. 处理废弃 API
7. 验证性能影响

**示例检查报告**:
```yaml
dependency: spring-boot
current_version: 2.7.18
target_version: 3.2.0
breaking_changes:
  - item: "javax.* → jakarta.* 命名空间变更"
    impact: "高"
    files_affected: 45
  - item: "Spring Security 配置方式变更"
    impact: "中"
    files_affected: 3
migration_guide: https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-3.0-Migration-Guide
estimated_effort: "3-5 天"
```

---

### 2. 依赖冲突解决

**场景**: 传递依赖版本冲突

```bash
# 检测冲突
mvn dependency:tree -Dverbose

# 示例输出
[INFO] +- com.example:app:jar:1.0.0
[INFO] |  +- com.library:A:jar:2.0.0
[INFO] |  |  \- com.common:utils:jar:1.0.0  <-- 冲突
[INFO] |  \- com.library:B:jar:3.0.0
[INFO] |     \- com.common:utils:jar:2.0.0  <-- 冲突
```

**解决方案**:
```xml
<!-- 排除传递依赖 -->
<dependency>
    <groupId>com.library</groupId>
    <artifactId>A</artifactId>
    <version>2.0.0</version>
    <exclusions>
        <exclusion>
            <groupId>com.common</groupId>
            <artifactId>utils</artifactId>
        </exclusion>
    </exclusions>
</dependency>

<!-- 显式声明需要的版本 -->
<dependency>
    <groupId>com.common</groupId>
    <artifactId>utils</artifactId>
    <version>2.0.0</version>
</dependency>
```

---

### 3. 安全漏洞处理

**场景**: 发现依赖存在 CVE

```yaml
vulnerability:
  id: CVE-2024-12345
  severity: HIGH
  dependency: log4j-core
  affected_versions: ">= 2.0, < 2.17.1"
  fixed_versions: ">= 2.17.1"
  recommendation: "立即升级到 2.17.1 或更高版本"
```

**处理流程**:
1. 评估漏洞影响范围
2. 确定受影响的功能模块
3. 升级到安全版本
4. 验证功能兼容性
5. 记录安全事件

---

### 4. 依赖范围优化

**问题**: 测试依赖被错误地包含在生产包中

```xml
<!-- 错误 -->
<dependency>
    <groupId>org.junit.jupiter</groupId>
    <artifactId>junit-jupiter</artifactId>
    <version>5.9.0</version>
</dependency>

<!-- 正确 -->
<dependency>
    <groupId>org.junit.jupiter</groupId>
    <artifactId>junit-jupiter</artifactId>
    <version>5.9.0</version>
    <scope>test</scope>
</dependency>
```

---

## 升级检查清单

- [ ] 是否阅读了迁移指南？
- [ ] 是否评估了破坏性变更？
- [ ] 是否在隔离分支进行？
- [ ] 测试是否全部通过？
- [ ] 是否检查了安全漏洞？
- [ ] 是否验证了性能影响？
- [ ] 是否更新了文档？