# <b>Проектирование и разработка базы данных сервисного центра</b>

Проект представляет собой полнофункциональную базу данных для автоматизации работы сервисного центра по ремонту компьютерной техники и электроники. Разработанная система обеспечивает полный цикл управления заказами - от приема техники до выдачи клиенту с детальным учетом всех операций, материалов и финансовых расчетов.

<p align="center">
  <img src="https://img.shields.io/badge/MySQL-8.0+-blue.svg" alt="MySQL">
  <img src="https://img.shields.io/badge/ERwin_Data_Modeler-7.3+-orange" alt="ERwin">
</p>

## <b>Навигация</b>
1. [Описание проекта](#проектирование-и-разработка-базы-данных-сервисного-центра)
2. [Модель данных](#модель-данных)
3. [Установка](#установка)
4. [Программируемые объекты](#программируемые-объекты)

## <b>Модель данных</b>

Проектируемая база данных должна содержать информацию о оформленных в сервисном центре заказах, информацию о расходах на ремонт конкретной единицы техники и информацию о клиенте, который оформляет заказ. Для каждого <b>клиента</b> хранится такая информация, как имя и электронный адрес. Аналогичная информация хранится для <b>мастера</b>. За <b>техникой</b> закреплены ее <b>производитель</b> и <b>вид</b>, который определяет, конкретно каким устройством она является (например, ПК, мобильный телефон и т.д.). <b>Работа</b> по конкретной технике содержит наименование конкретных проводимых над техникой операций (например, замена дисплея, распайка дополнительного слота под RAM и т.д.). Также хранится <b>расходный материал</b> относительно каждой работы, проведенной над техникой. Сводная таблица заказ хранит в себе основную информацию по заказу.

На основе предложенной выше функциональной модели была разработана модель данных, логическая и физическая схемы которой представлены на рисунках ниже.
<p align="center">
  <img src="img/logical.png">
</p>
<p align="center">
  Рисунок 1. Логическая модель данных
</p>
<p align="center">
  <img src="img/physical.png">
</p>
<p align="center">
  Рисунок 2. Физическая модель данных
</p>

## <b>Установка</b>

Перед началом установки убедитесь, что на вашей системе установлены:

| Компонент | Минимальная версия | Рекомендуемая версия | Проверка установки |
|-----------|-------------------|----------------------|-------------------|
| **MySQL Server** | 8.0 | 8.0+ | `mysql --version` |
| **MySQL Client** | 8.0 | 8.0+ | `mysql -V` |

### 1. Клонирование репозитория 

```bash
# Клонируем репозиторий
git clone https://github.com/idBulenkoIvan/database_design.git

# Переходим в директорию проекта
cd database_design

# Проверяем наличие файлов
ls -la
```

### 2. Создание базы данных

```bash
# Подключаемся к MySQL серверу
mysql -u root -p

# Создаем базу данных
CREATE DATABASE IF NOT EXISTS service_center 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

# Проверяем создание
SHOW DATABASES;

# Выходим из MySQL 
EXIT;
```

### 3. Импорт структуры данных

```sql
# Импортируем дамп
mysql -u root -p service_center < dump/dump.sql

# Проверяем импорт
mysql -u root -p -e "USE service_center; SHOW TABLES;"
```

### 4. Настройка пользователей и прав доступа

```sql
# Создаем администратора
CREATE USER '<username>'@'localhost' IDENTIFIED BY '<password>';

# Назначаем права
GRANT ALL PRIVILEGES ON service_center.* TO 'service_user'@'localhost';

# Создаем пользователя только для чтения
CREATE USER '<username>'@'localhost' IDENTIFIED BY '<password>';
GRANT SELECT ON service_center_db.* TO 'report_user'@'localhost';

# Применяем изменение прав
FLUSH PRIVILEGES;

# Проверяем пользователей
SELECT User, Host FROM mysql.user;
```

### 5. Проверка установки 

```sql
# Подключаемся к базе данных
mysql -u <username> -p service_center

# Просматриваем список таблиц
SHOW TABLES;
```

## <b>Программируемые объекты</b>

Для автоматизации бизнес-процессов и повышения эффективности работы с данными были разработаны функции, процедуры. Также для поддержания целостности и согласованности данных реализованы триггеры. 

### Функции 

#### 1. `calculate_total_consumables_cost` - Расчет стоимости расходных материалов по некоторому заказу
```sql
DELIMITER $$
CREATE FUNCTION calculate_total_consumables_cost(order_id INT) RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE total_cost DECIMAL(10, 2);
    SELECT SUM(consumables.material_price) INTO total_cost FROM consumables
    JOIN consumption ON consumption.material_id = consumables.material_id
    WHERE consumption.order_id = order_id;
    RETURN total_cost;
END$$
DELIMITER ;
```

#### 2. `calculate_total_workload_price` - Расчет стоимости работ по некоторому заказу
```sql
DELIMITER $$
CREATE FUNCTION calculate_total_workload_price(order_id INT) RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE total_cost DECIMAL(10, 2);
    SELECT SUM(workload.workload_price) INTO total_cost FROM repair
    JOIN workload ON workload.workload_id = repair.workload_id
    WHERE repair.order_id = order_id;
    RETURN total_cost;
END$$
DELIMITER ;
```

#### 3. 'calculate_order_margin' - Расчет прибыли с заказа
```sql
CREATE FUNCTION calculate_order_margin(order_id INT) RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE materials_cost DECIMAL(10, 2) DEFAULT 0;
    DECLARE workload_price DECIMAL(10, 2) DEFAULT 0;
    
    SELECT COALESCE(SUM(consumption.amount * consumables.material_price), 0) INTO materials_cost FROM consumption 
    JOIN consumables ON consumption.material_id = consumables.material_id
    WHERE consumption.order_id = order_id;
    
    SELECT COALESCE(SUM(workload.workload_price), 0) INTO workload_price FROM repair 
    JOIN workload ON repair.workload_id = workload.workload_id
    WHERE repair.order_id = order_id;
    
    RETURN workload_price - materials_cost;
END$$
END$$
```

#### 4. 'check_material_availability' - Проверка доступности материалов на складе
```sql
CREATE FUNCTION check_material_availability(material_id INT) RETURNS BOOLEAN
READS SQL DATA
BEGIN
    DECLARE total_reserved INT;
    
    SELECT COALESCE(SUM(consumption.amount), 0) INTO total_reserved FROM consumption
    JOIN ordering ON consumption.order_id = ordering.order_id
    WHERE consumption.material_id = material_id
          AND ordering.status_id IN (3, 4);
    
    RETURN (10 - total_reserved) > 0; 
END$$
```

#### 5. 'get_avg_order_cost_by_type' - Расчет средней стоимости заказа по типу техники
```sql
CREATE FUNCTION get_avg_order_cost_by_type(type_name VARCHAR(50)) RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE avg_cost DECIMAL(10, 2);
    
    SELECT AVG(workload.workload_price + COALESCE(consumables.material_price, 0)) INTO avg_cost FROM ordering
    JOIN technique ON ordering.technique_id = technique.technique_id
    JOIN technique_type ON technique.type_id = technique_type.type_id
    LEFT JOIN repair ON ordering.order_id = repair.order_id
    LEFT JOIN workload ON repair.workload_id = workload.workload_id
    LEFT JOIN consumption ON ordering.order_id = consumption.order_id
    LEFT JOIN consumables ON consumption.material_id = consumables.material_id
    WHERE LOWER(technique_type.technique_type) = LOWER(type_name);
    
    RETURN COALESCE(avg_cost, 0);
END$$
```

### Хранимые процедуры  

#### 1. 'calculate_profit' - Расчет прибыли за некоторый период
```sql
DELIMITER $$
CREATE PROCEDURE calculate_profit(IN start_date DATE, IN end_date DATE)
BEGIN
    SET @total_consumables := (
        SELECT SUM(c.amount * m.material_price) FROM consumption AS c
        JOIN consumables AS m ON c.material_id = m.material_id
        JOIN ordering AS o ON c.order_id = o.order_id
        WHERE o.order_date BETWEEN start_date AND end_date
    );

    SET @total_repairs := (
        SELECT SUM(w.workload_price) FROM repair AS r
        JOIN workload AS w ON r.workload_id = w.workload_id
        JOIN ordering AS o ON r.order_id = o.order_id
        WHERE o.order_date BETWEEN start_date AND end_date
    );

    SET @total_profit := @total_consumables + @total_repairs;
    SELECT @total_profit AS total_profit;
END$$
DELIMITER ;
```

#### 2. 'update_order_status' - Мануальное обновление статуса некоторого заказа
```sql
DELIMITER $$
CREATE PROCEDURE update_order_status(IN order_id INT)
BEGIN
    UPDATE ordering
    SET ordering.status_id = ordering.status_id + 1
    WHERE ordering.order_id = order_id;
END$$
DELIMITER ;
```

#### 3. 'analyze_repairman_performance' - Анализ эффективности мастеров
```sql
CREATE PROCEDURE analyze_repairman_performance(IN period_days INT)
BEGIN
    SELECT repairman.repairman_name, COUNT(DISTINCT ordering.order_id) as total_orders,
           SUM(workload.workload_price) as total_revenue, AVG(DATEDIFF(ordering.order_complete_date, ordering.order_date)) as avg_completion_days
    FROM repairman
    LEFT JOIN ordering ON repairman.repairman_id = ordering.repairman_id
    LEFT JOIN repair ON ordering.order_id = repair.order_id
    LEFT JOIN workload ON repair.workload_id = workload.workload_id
    WHERE ordering.order_date >= DATE_SUB(CURDATE(), INTERVAL period_days DAY)
    GROUP BY repairman.repairman_id, repairman.repairman_name
    ORDER BY total_revenue DESC;
END$$
```

#### 4. 'analyze_popular_services' - Анализ популярности услуг
```sql
CREATE PROCEDURE analyze_popular_services(IN start_date DATE, IN end_date DATE)
BEGIN
    SELECT workload.workload_name, COUNT(repair.order_id) as usage_count,
           SUM(workload.workload_price) as total_revenue
    FROM workload
    LEFT JOIN repair ON workload.workload_id = repair.workload_id
    LEFT JOIN ordering ON repair.order_id = ordering.order_id
    WHERE ordering.order_date BETWEEN start_date AND end_date
    GROUP BY workload.workload_id, workload.workload_name, workload.workload_price
    ORDER BY usage_count DESC;
END$$
```

#### 5. 'generate_completed_orders_report' - Отчет по завершенным заказам с детализацией
```sql
CREATE PROCEDURE generate_completed_orders_report(IN report_month INT, IN report_year INT)
BEGIN
    SELECT  ordering.order_id, ordering.order_date, ordering.order_complete_date,
            customer.customer_name, technique.technique_name, repairman.repairman_name,
            calculate_total_consumables_cost(ordering.order_id) as materials_cost,
            calculate_total_workload_price(ordering.order_id) as workload_cost,
            calculate_order_margin(ordering.order_id) as order_margin
    FROM ordering
    JOIN customer ON ordering.customer_id = customer.customer_id
    JOIN technique ON ordering.technique_id = technique.technique_id
    LEFT JOIN repairman ON ordering.repairman_id = repairman.repairman_id
    WHERE ordering.status_id = 5
          AND MONTH(ordering.order_complete_date) = report_month
          AND YEAR(ordering.order_complete_date) = report_year
    ORDER BY ordering.order_complete_date DESC;
END$$
```

### Триггеры

#### 1. 'update_order_complete_date' - Автоматическое обновление даты завершения
```sql
DELIMITER $$
CREATE TRIGGER update_order_complete_dateAFTER UPDATE ON ordering
FOR EACH ROW
BEGIN
    IF NEW.status_id = 5 AND OLD.status_id != 5 THEN
        UPDATE ordering 
    SET order_complete_date = CURDATE() 
        WHERE order_id = NEW.order_id;
    END IF;
END$$
DELIMITER ;
```

#### 2. 'update_customer_info' - Синхронизация данных клиента
```sql
DELIMITER $$
CREATE TRIGGER update_customer_info AFTER INSERT ON ordering
FOR EACH ROW
BEGIN
    UPDATE customer
    SET customer.customer_name = NEW.customer_name,
        customer.customer_email = NEW.customer_email
    WHERE customer.customer_id = NEW.customer_id;
END$$
DELIMITER ;
```

#### 3. 'update_order_status_after_workload_append' - Автоматический перевод в работу
```sql
DELIMITER $$
CREATE TRIGGER update_order_status_after_work_added AFTER INSERT ON repair
FOR EACH ROW
BEGIN
    UPDATE ordering
    SET status_id = 3
    WHERE order_id = NEW.order_id;
END$$
DELIMITER ;
```

#### 4. 'update_consumables_before_insert' - Контроль дублирования расходников
```sql
DELIMITER $$
CREATE TRIGGER update_consumables_before_insert BEFORE INSERT ON consumption
FOR EACH ROW
BEGIN
	DECLARE old_amount INT;
	SELECT amount INTO old_amount FROM consumption
  WHERE consumption.order_id = NEW.order_id
        AND consumption.material_id = NEW.material_id;
	IF old_amount IS NOT NULL THEN
		UPDATE consumables
    SET amount = old_amount + NEW.amount WHERE consumption.material_id = NEW.material_id
											   AND order_id = NEW.order_id;
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Duplicate entry detected, old record updated';
	END IF;
END$$
DELIMITER ;
```

#### 5. 'update_order_status_after_consumables_added' - Статус при добавлении материалов
```sql
DELIMITER $$
CREATE TRIGGER update_order_status_after_consumables_added AFTER INSERT ON consumption
FOR EACH ROW
BEGIN
    UPDATE ordering
    SET status_id = 3
    WHERE order_id = NEW.order_id;
END$$
DELIMITER ;
```

#### 6. 'prevent_duplicate_work' - Контроль дублирования работ
```sql
CREATE TRIGGER prevent_duplicate_work BEFORE INSERT ON repair
FOR EACH ROW
BEGIN
    DECLARE duplicate_count INT;
    
    SELECT COUNT(*) INTO duplicate_countFROM repair
    WHERE repair.order_id = NEW.order_id 
          AND repair.workload_id = NEW.workload_id;
    
    IF duplicate_count > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Эта работа уже добавлена в заказ';
    END IF;
END$$
```
