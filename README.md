# KHAATA 
- **Status:** underdevelopment
- **Version:** 0.0
- **Description:** *Project Description here. . .*

## **Task-List**
- [ ] **Bloc Pattern Implementation** 
- [ ] Code Refactoring
- [ ] Bug Hunting
- [ ] Profiling and Optimization
- [ ] Doxygen comment documentation 

## 1. **Project Dependencies:**

- build_runner: 2.2.0
- introduction_screen: 3.0.2
- hive_generator: 1.1.3
- hive: 2.2.3
- hive_flutter: 1.1.0
- flutter_inset_box_shadow: 1.0.8
- fl_chart: 0.55.1
  
## 2. **Project Structure and Guidelines:**
- `snake-case` naming convention for files and folder **e.g** `sub-screen`.
- **camelCase** `kConstantValue` for constant values.
- `camelCase` for variables naming convention.
- According to google docs, prefer **classes** over **methods** for widget separation and for better widget tree optimization.

## 3. **Custom widget classes:**
#### 1. CustomOutlinedButton :
```
CustomOutlinedButton(
              text: "Click",
              textColor: Colors.black,
              onPressed: () {},
            );
```
#### 2. CustomAppBar
```
    CustomAppBar(
      title: "Title",
      subTitle: "subTitle",
      titleFontSize: 16,
      backgroundColor: Colors.amberAccent,
    );
```
#### 3. CustomCard
```
    CustomCard(
      height: 50,
      width: 100,
      shadow: true,
      child: Text("Card Text"),
    );
```
#### 4. CustomTextField
```
CustomTextField(
            controller: controller,
            contentPadding: 10,
            color: Colors.black,
            inputType: TextInputType.number,
            isDense: true,
            borderStyle: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3)),
            onChanged: (value) {},
          );
```
