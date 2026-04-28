```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.calculator">

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="Ø­Ø§Ø³Ø¨Ù"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.Calculator"
        android:screenOrientation="portrait">
        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

</manifest>
```

```java
package com.example.calculator;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    private TextView display;
    private String currentInput = "";
    private String operator = "";
    private double firstOperand = 0;
    private boolean isNewInput = true;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        display = findViewById(R.id.display);

        // Number buttons
        int[] numberIds = {
            R.id.btn_0, R.id.btn_1, R.id.btn_2, R.id.btn_3, R.id.btn_4,
            R.id.btn_5, R.id.btn_6, R.id.btn_7, R.id.btn_8, R.id.btn_9
        };

        for (int id : numberIds) {
            findViewById(id).setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Button btn = (Button) v;
                    onNumberClick(btn.getText().toString());
                }
            });
        }

        // Operator buttons
        findViewById(R.id.btn_add).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onOperatorClick("+");
            }
        });

        findViewById(R.id.btn_subtract).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onOperatorClick("-");
            }
        });

        findViewById(R.id.btn_multiply).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onOperatorClick("*");
            }
        });

        findViewById(R.id.btn_divide).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onOperatorClick("/");
            }
        });

        // Equals button
        findViewById(R.id.btn_equals).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onEqualsClick();
            }
        });

        // Clear button
        findViewById(R.id.btn_clear).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onClearClick();
            }
        });

        // Decimal point
        findViewById(R.id.btn_decimal).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onDecimalClick();
            }
        });

        // Backspace
        findViewById(R.id.btn_backspace).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onBackspaceClick();
            }
        });

        // Percentage
        findViewById(R.id.btn_percent).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onPercentClick();
            }
        });

        // Plus/Minus toggle
        findViewById(R.id.btn_plus_minus).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onPlusMinusClick();
            }
        });
    }

    private void onNumberClick(String number) {
        if (isNewInput) {
            currentInput = number;
            isNewInput = false;
        } else {
            currentInput += number;
        }
        updateDisplay();
    }

    private void onOperatorClick(String op) {
        if (!currentInput.isEmpty()) {
            if (!operator.isEmpty()) {
                calculate();
            }
            firstOperand = Double.parseDouble(currentInput);
            operator = op;
            isNewInput = true;
        }
    }

    private void onEqualsClick() {
        if (!operator.isEmpty() && !currentInput.isEmpty()) {
            calculate();
            operator = "";
            isNewInput = true;
        }
    }

    private void calculate() {
        double secondOperand = Double.parseDouble(currentInput);
        double result = 0;

        switch (operator) {
            case "+":
                result = firstOperand + secondOperand;
                break;
            case "-":
                result = firstOperand - secondOperand;
                break;
            case "*":
                result = firstOperand * secondOperand;
                break;
            case "/":
                if (secondOperand != 0) {
                    result = firstOperand / secondOperand;
                } else {
                    display.setText("Ø®Ø·Ø£");
                    return;
                }
                break;
        }

        // Format result to avoid unnecessary decimal places
        if (result == (long) result) {
            currentInput = String.valueOf((long) result);
        } else {
            currentInput = String.valueOf(result);
        }
        updateDisplay();
    }

    private void onClearClick() {
        currentInput = "";
        operator = "";
        firstOperand = 0;
        isNewInput = true;
        display.setText("0");
    }

    private void onDecimalClick() {
        if (isNewInput) {
            currentInput = "0.";
            isNewInput = false;
        } else if (!currentInput.contains(".")) {
            currentInput += ".";
        }
        updateDisplay();
    }

    private void onBackspaceClick() {
        if (!currentInput.isEmpty()) {
            currentInput = currentInput.substring(0, currentInput.length() - 1);
            if (currentInput.isEmpty()) {
                currentInput = "0";
                isNewInput = true;
            }
            updateDisplay();
        }
    }

    private void onPercentClick() {
        if (!currentInput.isEmpty()) {
            double value = Double.parseDouble(currentInput) / 100;
            if (value == (long) value) {
                currentInput = String.valueOf((long) value);
            } else {
                currentInput = String.valueOf(value);
            }
            updateDisplay();
        }
    }

    private void onPlusMinusClick() {
        if (!currentInput.isEmpty() && !currentInput.equals("0")) {
            if (currentInput.startsWith("-")) {
                currentInput = currentInput.substring(1);
            } else {
                currentInput = "-" + currentInput;
            }
            updateDisplay();
        }
    }

    private void updateDisplay() {
        display.setText(currentInput);
    }
}
```

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="16dp"
    android:background="#1a1a2e">

    <!-- Display -->
    <TextView
        android:id="@+id/display"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="2"
        android:gravity="end|bottom"
        android:padding="16dp"
        android:text="0"
        android:textColor="#ffffff"
        android:textSize="48sp"
        android:textStyle="bold"
        android:background="#16213e"
        android:layout_marginBottom="16dp"/>

    <!-- Buttons Grid -->
    <GridLayout
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="4"
        android:columnCount="4"
        android:rowCount="5"
        android:useDefaultMargins="true"
        android:alignmentMode="alignMargins">

        <!-- Row 1 -->
        <Button
            android:id="@+id/btn_clear"
            android:text="C"
            style="@style/CalculatorButton"
            android:backgroundTint="#e94560" />

        <Button
            android:id="@+id/btn_backspace"
            android:text="â«"
            style="@style/CalculatorButton"
            android:backgroundTint="#e94560" />

        <Button
            android:id="@+id/btn_percent"
            android:text="%"
            style="@style/CalculatorButton"
            android:backgroundTint="#533483" />

        <Button
            android:id="@+id/btn_divide"
            android:text="Ã·"
            style="@style/CalculatorButton"
            android:backgroundTint="#533483" />

        <!-- Row 2 -->
        <Button
            android:id="@+id/btn_7"
            android:text="7"
            style="@style/CalculatorButton"
            android:backgroundTint="#0f3460" />

        <Button
            android:id="@+id/btn_8"
            android:text="8"
            style="@style/CalculatorButton"
            android:backgroundTint="#0f3460" />

        <Button
            android:id="@+id/btn_9"
            android:text="9"
            style="@style/CalculatorButton"
            android:backgroundTint="#0f3460" />

        <Button
            android:id="@+id/btn_multiply"
            android:text="Ã"
            style="@style/CalculatorButton"
            android:backgroundTint="#533483" />

        <!-- Row 3 -->
        <Button
            android:id="@+id/btn_4"
            android:text="4"
            style="@style/CalculatorButton"
            android:backgroundTint="#0f3460" />

        <Button
            android:id="@+id/btn_5"
            android:text="5"
            style="@style/CalculatorButton"
            android:backgroundTint="#0f3460" />

        <Button
            android:id="@+id/btn_6"
            android:text="6"
            style="@style/CalculatorButton"
            android:backgroundTint="#0f3460" />

        <Button
            android:id="@+id/btn_subtract"
            android:text="-"
            style="@style/CalculatorButton"
            android:backgroundTint="#533483" />

        <!-- Row 4 -->
        <Button
            android:id="@+id/btn_1"
            android:text="1"
            style="@style/CalculatorButton"
            android:backgroundTint="#0f3460" />

        <Button
            android:id="@+id/btn_2"
            android:text="2"
            style="@style/CalculatorButton"
            android:backgroundTint="#0f3460" />

        <Button
            android:id="@+id/btn_3"
            android:text="3"
            style="@style/CalculatorButton"
            android:backgroundTint="#0f3460" />

        <Button
            android:id="@+id/btn_add"
            android:text="+"
            style="@style/CalculatorButton"
            android:backgroundTint="#533483" />

        <!-- Row 5 -->
        <Button
            android:id="@+id/btn_plus_minus"
            android:text="Â±"
            style="@style/CalculatorButton"
            android:backgroundTint="#0f3460" />

        <Button
            android:id="@+id/btn_0"
            android:text="0"
            style="@style/CalculatorButton"
            android:backgroundTint="#0f3460" />

        <Button
            android:id="@+id/btn_decimal"
            android:text="."
            style="@style/CalculatorButton"
            android:backgroundTint="#0f3460" />

        <Button
            android:id="@+id/btn_equals"
            android:text="="
            style="@style/CalculatorButton"
            android:backgroundTint="#e94560" />

    </GridLayout>

</LinearLayout>
```

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <style name="Theme.Calculator" parent="Theme.AppCompat.DayNight.NoActionBar">
        <item name="android:statusBarColor">#1a1a2e</item>
        <item name="android:navigationBarColor">#1a1a2e</item>
    </style>

    <style name="CalculatorButton">
        <item name="android:layout_width">0dp</item>
        <item name="android:layout_height">0dp</item>
        <item name="android:layout_columnWeight">1</item>
        <item name="android:layout_rowWeight">1</item>
        <item name="android:textSize">24sp</item>
        <item name="android:textColor">#ffffff</item>
        <item name="android:textStyle">bold</item>
        <item name="android:gravity">center</item>
        <item name="android:layout_margin">4dp</item>
        <item name="android:backgroundTint">#0f3460</item>
        <item name="cornerRadius">12dp</item>
    </style>
</resources>
```

```groovy
// build.gradle (Module: app)
plugins {
    id 'com.android.application'
}

android {
    compileSdk 33

    defaultConfig {
        applicationId "com.example.calculator"
        minSdk 21
        targetSdk 33
        versionCode 1
        versionName "1.0"
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
}

dependencies {
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.9.0'
    implementation 'androidx.constraintlayout:constraintlayout:2.1.4'
}
```

```groovy
// build.gradle (Project)
plugins {
    id 'com.android.application' version '7.4.2' apply false
}
```

To complete the project, create the following file structure:
- `app/src/main/java/com/example/calculator/MainActivity.java`
- `app/src/main/res/layout/activity_main.xml`
- `app/src/main/res/values/themes.xml` (contains both styles)
- `app/src/main/AndroidManifest.xml`
- `app/build.gradle`
- `build.gradle` (project level)

The app is a fully functional calculator with RTL support for Arabic, featuring:
- Basic operations (+, -, Ã, Ã·)
- Percentage calculation
- Plus/minus toggle
- Backspace and clear
- Error handling for division by zero
- Dark theme with modern design
- Proper decimal formatting