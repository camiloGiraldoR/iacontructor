# IAConstructor — Asistente de Medición y Estimación de Materiales para iOS

## 1. Visión General
**IAConstructor** es una aplicación nativa para iOS concebida como un asistente inteligente para la industria de la construcción y remodelación. Utiliza la cámara del dispositivo y la tecnología **LiDAR** de Apple para medir dimensiones en tiempo real (muros, pisos, ventanas), evaluar la condición del espacio y estimar los materiales necesarios de manera eficiente.

---

## 2. Estructura y Flujo de la Aplicación

```
[ WelcomeView ]
       │
       ▼ (Botón "Comencemos")
[ ProjectDashboardView ] ◄──────────────────┐
       │                                     │
       ▼ (Botón "Analizar Espacio")         │
[ Selector de Espacio (Modal/Menu) ]        │ (Guardar registro)
       │                                     │
       ▼ (Selección: Piso / Ventana / Muro) │
[ ARScannerView (LiDAR) ]                   │
       │                                     │
       ▼ (Botón "Analizar")                 │
[ SpaceSummaryView ] ────────────────────────┘
```

---

## 3. Pantallas y Componentes Claves

### 3.1. Pantalla de Bienvenida (`WelcomeView`)
* **Propósito:** Presentación de la marca y onboarding inicial.
* **Componentes:**
  * Título y logotipo de **IAConstructor**.
  * Texto explicativo sobre el uso de la cámara y tecnología LiDAR para medición de precisión y cálculo de materiales.
  * Botón de acción principal: `"Comencemos"`.

### 3.2. Panel de Proyectos (`ProjectDashboardView`)
* **Propósito:** Gestión global del proyecto activo e historial de capturas.
* **Componentes:**
  * Botón `"Crear Proyecto"` para iniciar una nueva sesión de obra.
  * Lista / Grid con el historial de espacios gestionados dentro del proyecto.
  * Botón destacado `"Analizar Espacio"`.

### 3.3. Selector de Espacio (`SpaceSelectorModal`)
* **Propósito:** Definir la categoría del elemento arquitectónico a medir antes de activar la cámara.
* **Opciones del menú:**
  * 📐 **Piso**
  * 🪟 **Ventana**
  * 🧱 **Muro**

### 3.4. Vista de Escaneo LiDAR (`ARScannerView`)
* **Propósito:** Captura espacial mediante realidad aumentada y sensores de profundidad.
* **Componentes:**
  * Vértice/Feed de cámara con superposición métrica en tiempo real.
  * Indicadores visuales de cotas y dimensiones (largo, alto, área).
  * Botón principal `"Analizar"` para congelar y capturar la geometría detectada.

### 3.5. Resumen y Condición (`SpaceSummaryView`)
* **Propósito:** Validación de los datos escaneados y enriquecimiento del registro antes de persistirlo.
* **Datos mostrados:**
  * Categoría del espacio seleccionado (Piso, Ventana o Muro).
  * Medidas exactas (superficie $m^2$, perímetro, dimensiones).
* **Selector de Condición de Obra:**
  * `Obra Negra`
  * `Obra Gris`
  * `Obra Blanca`
* **Acción:** Guardar registro en el proyecto activo.

---

## 4. Pila Tecnológica (Tech Stack)

| Capa | Tecnología / Framework | Propósito |
| :--- | :--- | :--- |
| **Interfaz de Usuario** | **SwiftUI** | Construcción de una UI reactiva, moderna y 100% nativa en iOS. |
| **Escaneo Espacial** | **ARKit** + **RoomPlan** | Procesamiento del sensor LiDAR para detección de planos, muros, aperturas y dimensiones métricas. |
| **Persistencia Local** | **SwiftData** | Almacenamiento local tipo ORM para los proyectos, espacios y sus propiedades geométricas. |

---

## 5. Modelo de Datos Sugerido (SwiftData)

```swift
import Foundation
import SwiftData

enum SpaceCategory: String, Codable, CaseIterable {
    case floor = "Piso"
    case window = "Ventana"
    case wall = "Muro"
}

enum ConstructionStage: String, Codable, CaseIterable {
    case roughIn = "Obra Negra"
    case grayStructure = "Obra Gris"
    case finished = "Obra Blanca"
}

@Model
final class ScannedSpace {
    var id: UUID
    var category: SpaceCategory
    var width: Double
    var height: Double
    var area: Double
    var stage: ConstructionStage
    var createdAt: Date
    
    init(category: SpaceCategory, width: Double, height: Double, area: Double, stage: ConstructionStage) {
        self.id = UUID()
        self.category = category
        self.width = width
        self.height = height
        self.area = area
        self.stage = stage
        self.createdAt = Date()
    }
}
```