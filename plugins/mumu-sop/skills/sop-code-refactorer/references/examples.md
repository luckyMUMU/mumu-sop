# 重构示例

本文档提供代码重构的常见场景和示例。

---

## 重构场景

### 1. 提取方法 (Extract Method)

**重构前**:
```java
void printOwing() {
    // print banner
    System.out.println("***********************");
    System.out.println("*** Customer Owes ***");
    System.out.println("***********************");

    // calculate details
    double outstanding = 0;
    for (Order order : orders) {
        outstanding += order.getAmount();
    }

    // print details
    System.out.println("name: " + name);
    System.out.println("amount: " + outstanding);
}
```

**重构后**:
```java
void printOwing() {
    printBanner();
    double outstanding = calculateOutstanding();
    printDetails(outstanding);
}

private void printBanner() {
    System.out.println("***********************");
    System.out.println("*** Customer Owes ***");
    System.out.println("***********************");
}

private double calculateOutstanding() {
    double outstanding = 0;
    for (Order order : orders) {
        outstanding += order.getAmount();
    }
    return outstanding;
}

private void printDetails(double outstanding) {
    System.out.println("name: " + name);
    System.out.println("amount: " + outstanding);
}
```

---

### 2. 以多态取代条件表达式 (Replace Conditional with Polymorphism)

**重构前**:
```java
double getSpeed() {
    switch (type) {
        case EUROPEAN:
            return getBaseSpeed();
        case AFRICAN:
            return getBaseSpeed() - getLoadFactor() * numberOfCoconuts;
        case NORWEGIAN_BLUE:
            return isNailed ? 0 : getBaseSpeed(voltage);
        default:
            throw new RuntimeException("Should be unreachable");
    }
}
```

**重构后**:
```java
abstract class Bird {
    abstract double getSpeed();
}

class EuropeanBird extends Bird {
    double getSpeed() {
        return getBaseSpeed();
    }
}

class AfricanBird extends Bird {
    double getSpeed() {
        return getBaseSpeed() - getLoadFactor() * numberOfCoconuts;
    }
}

class NorwegianBlueBird extends Bird {
    double getSpeed() {
        return isNailed ? 0 : getBaseSpeed(voltage);
    }
}
```

---

### 3. 分解条件表达式 (Decompose Conditional)

**重构前**:
```java
if (date.before(SUMMER_START) || date.after(SUMMER_END)) {
    charge = quantity * winterRate + winterServiceCharge;
} else {
    charge = quantity * summerRate;
}
```

**重构后**:
```java
if (isSummer(date)) {
    charge = summerCharge(quantity);
} else {
    charge = winterCharge(quantity);
}

private boolean isSummer(Date date) {
    return !date.before(SUMMER_START) && !date.after(SUMMER_END);
}

private double summerCharge(int quantity) {
    return quantity * summerRate;
}

private double winterCharge(int quantity) {
    return quantity * winterRate + winterServiceCharge;
}
```

---

### 4. 引入参数对象 (Introduce Parameter Object)

**重构前**:
```java
void addEntry(String name, Date created, Date modified, String author);
```

**重构后**:
```java
class EntryMetadata {
    private String name;
    private Date created;
    private Date modified;
    private String author;
    // constructor, getters
}

void addEntry(EntryMetadata metadata);
```

---

## 重构检查清单

- [ ] 是否有足够的测试覆盖？
- [ ] 测试是否全部通过？
- [ ] 是否遵循小步重构原则？
- [ ] 每步重构后是否提交？
- [ ] 是否更新了相关文档？
- [ ] 是否验证了约束树一致性？