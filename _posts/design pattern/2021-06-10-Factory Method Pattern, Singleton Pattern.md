---
categories: design-pattern
---



## Factory Method Pattern

팩토리 메서드 : 템플릿 메소드 패턴이 사용된다.

- Application

```java
package com.parkgaram.dp.templatecreator;

import com.parkgaram.dp.templatecreator.fw.Creator;
import com.parkgaram.dp.templatecreator.fw.Item;

public class Application {
	public static void main(String[] args) {
		Creator creator = new DefaultItemCreator();

		Item item1 = creator.create("나무칼");
		Item item2 = creator.create("나무방패");
		Item item3 = creator.create("나무갑주");
		item1.use();
		item2.use();
		item3.use();
	}
}
```

### Item class

```java
package com.parkgaram.dp.templatecreator.fw;

public abstract class Item {
	public abstract void use();
}
```

- DefaultItem 자식 클래스

```java
package com.parkgaram.dp.templatecreator;

import com.parkgaram.dp.templatecreator.fw.Item;

public class DefaultItem extends Item {
	private String itemName;
	
	public DefaultItem(String itemName) {
		this.itemName = itemName;
	}
	
	@Override
	public void use() {
		System.out.println(itemName +" 사용했습니다!");
	}
}
```

### Creator class

```java
package com.parkgaram.dp.templatecreator.fw;

public abstract class Creator {
    // 여러 메소드들을 추상화하여 자식에서 선언하고
	abstract protected String init(String itemName);

	abstract protected Item createItem(String itemName);

	abstract protected String end(String itemName);
    
    // 하나의 메서드에서 추상화한 메서드를 구현하면 템플릿메서드의 완성!!
	public Item create(String itemName) {
		init(itemName);
		Item item = createItem(itemName);
		end(itemName);
		return item;
	}
}
```

- Creator 자식 클래스

```java
package com.parkgaram.dp.templatecreator;

import com.parkgaram.dp.templatecreator.fw.Creator;
import com.parkgaram.dp.templatecreator.fw.Item;

public class DefaultItemCreator extends Creator {
	@Override
	protected String end(String itemName) {
		System.out.println("Default 마무리 작업!");
		return itemName;
	}

	@Override
	protected String init(String itemName) {
		System.out.println("Default 초기 작업!");
		return itemName;
	}

	@Override
	protected Item createItem(String itemName) {
		return new DefaultItem(itemName);
	}
}
```

## Singleton Pattern

싱글톤 패턴 : 하나의 인스턴스만 생성해야 할 객체를 위한 패턴

static variable, static method 를 사용

- Application

```java
public class Application {

	public static void main(String[] args) {
		SystemSpeaker LG = SystemSpeaker.getInstance();
		SystemSpeaker SAMSUNG = SystemSpeaker.getInstance();

		System.out.println(LG.getVolume());
		System.out.println(SAMSUNG.getVolume());
		LG.setVolume(10);
		System.out.println(LG.getVolume());
		System.out.println(SAMSUNG.getVolume());
		SAMSUNG.setVolume(20);
		System.out.println(LG.getVolume());
		System.out.println(SAMSUNG.getVolume());
	}
}
```

- SystemSpeaker

```java
public class SystemSpeaker {

	private static SystemSpeaker instance;
	private int volume;

	private SystemSpeaker() {
		setVolume(5);
	}

	public static SystemSpeaker getInstance() {
		if (instance == null) {
			instance = new SystemSpeaker();
		} else {
		}
		return instance;
	}

	public int getVolume() {
		return volume;
	}

	public void setVolume(int volume) {
		this.volume = volume;
	}
}
```

