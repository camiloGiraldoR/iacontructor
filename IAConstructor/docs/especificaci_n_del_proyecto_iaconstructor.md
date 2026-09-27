# IAConstructor — Asistente de Medición y Estimación de Materiales para iOS

## 1. Visión General
**IAConstructor** es una aplicación nativa para iOS concebida como un asistente inteligente para la industria de la construcción y remodelación. Utiliza la cámara del dispositivo y la tecnología **LiDAR** de Apple para medir dimensiones en tiempo real (muros, pisos, ventanas), evaluar la condición del espacio y estimar los materiales necesarios de manera eficiente.

---

## 2. Estructura y Flujo de la Aplicación (Actualizado)

```
[ WelcomeView ]
       │
       ▼ (Botón "Comencemos")
[ ProjectListView ] ◄────────────────────────────────────┐
       │                                                  │
       ├─ Botón "Crear Proyecto" → [ CreateProjectView ] │
       │                              (Nombre, dirección,│
       │                              persona encargada, │
       │                              tipo, # plantas)   │
       │                                  │               │
       │                                  ▼ (Toast)       │
       │                              [ProjectListView]   │
       │                                                   │
       ▼ (Seleccionar proyecto)                           │
[ ProjectDetailView ]                                      │
  (Resumen + Lista de Plantas)                            │
       │                                                   │
       ▼ (Seleccionar planta)                             │
[ FloorDetailView ]                                        │
  (Listado de Espacios)                                   │
       │                                                   │
       ├─ Botón "Crear Espacio" → [ CreateSpaceView ]     │
       │                           (Nombre, descripción) │
       │                                  │                │
       │                                  ▼ (Toast)        │
       │                           [FloorDetailView]       │
       │                                                   │
       ▼ (Seleccionar espacio → "Analizar Espacio")       │
[ SpaceTypeSelectView ]                                    │
  (Piso / Ventana / Muro)                                 │
       │                                                   │
       ▼                                                   │
[ ARScannerView (LiDAR) ]                                  │
       │                                                   │
       ▼ (Botón "Analizar")                               │
[ AnalysisResultView ]                                     │
  (Medidas, Condición, Materiales)                        │
       │                                                   │
       ▼ (Botón "Guardar Análisis")                       │
[ AnalysisSavedView ] ────────────────────────────────────┤
  (Resumen) → Botón "Volver a Espacios"                   │
       │                                                   │
       └─────────────────────────────────────────────────┘
       
[ SpaceDetailView ] (Al seleccionar espacio)
  (Listado de análisis guardados)
```

---

## 3. Pantallas y Componentes Claves

### 3.1. Pantalla de Bienvenida (`WelcomeView`)
* **Propósito:** Presentación de la marca y onboarding inicial.
* **Componentes:**
  * Título y logotipo de **IAConstructor**.
  * Texto explicativo sobre el uso de la cámara y tecnología LiDAR para medición de precisión y cálculo de materiales.
  * Botón de acción principal: `"Comencemos"`.

### 3.2. Listado de Proyectos (`ProjectListView`)
* **Propósito:** Mostrar todos los proyectos creados y permitir crear uno nuevo.
* **Componentes:**
  * Botón `"Crear Proyecto"` para iniciar una nueva sesión de obra.
  * Lista de proyectos con: nombre, ubicación, tipo, número de plantas.
  * Acceso rápido a detalles del proyecto.

### 3.3. Crear Proyecto (`CreateProjectView`)
* **Propósito:** Formulario para crear un nuevo proyecto.
* **Campos:**
  * **Nombre del Proyecto** (texto)
  * **Dirección** (texto)
  * **Persona Encargada** (texto)
  * **Tipo:** Casa / Edificio / Oficina (selector)
  * **Número de Plantas** (número)
* **Validación:** Toast de "Proyecto creado exitosamente".

### 3.4. Detalle del Proyecto (`ProjectDetailView`)
* **Propósito:** Vista del proyecto con resumen y listado de plantas.
* **Componentes:**
  * Resumen: nombre, dirección, tipo, personas encargada.
  * Listado de plantas numeradas (1, 2, 3, etc.).
  * Botón "Atrás" para regresar al listado de proyectos.

### 3.5. Detalle de Planta (`FloorDetailView`)
* **Propósito:** Gestión de espacios en una planta específica.
* **Componentes:**
  * Botón `"Crear Espacio"` para agregar un nuevo espacio a la planta.
  * Listado de espacios con nombre y descripción.
  * Botón `"Analizar Espacio"` para iniciar escaneo en un espacio seleccionado.

### 3.6. Crear Espacio (`CreateSpaceView`)
* **Propósito:** Formulario para crear un espacio en la planta.
* **Campos:**
  * **Nombre del Espacio** (Ej: Cuarto Principal, Sala, Cocina)
  * **Descripción** (Ej: Cuarto de 3 paredes de concreto, 1 ventana, piso repellado)
* **Validación:** Toast de "Espacio creado exitosamente".

### 3.7. Selector de Tipo de Espacio (`SpaceTypeSelectView`)
* **Propósito:** Definir la categoría del elemento arquitectónico a medir antes de activar la cámara.
* **Opciones:**
  * 📐 **Piso** - Medición de áreas horizontales, losas y contrapisos.
  * 🪟 **Ventana** - Análisis de marcos, aberturas y paneles de vidrio.
  * 🧱 **Muro** - Escaneo vertical para revoque, pintura y repellos.

### 3.8. Vista de Escaneo LiDAR (`ScanningView`)
* **Propósito:** Captura espacial mediante realidad aumentada y sensores de profundidad.
* **Componentes:**
  * Visualización 3D simulada con superposición métrica en tiempo real.
  * Indicadores visuales de cotas y dimensiones (3.20 m ancho, 2.85 m alto).
  * Indicador de "Superfície detectada | 9.12 m²".
  * Botón principal `"Analizar"` para proceder con el análisis de resultados.

### 3.9. Resultado del Análisis (`AnalysisResultView`)
* **Propósito:** Validación de los datos escaneados y enriquecimiento del registro antes de persistirlo.
* **Datos mostrados:**
  * Categoría del espacio seleccionado (Piso, Ventana o Muro).
  * Medidas exactas (superficie $m^2$, dimensiones, perímetro).
  * Selector de Condición de Obra: `Obra Negra`, `Obra Gris`, `Obra Blanca`.
  * Materiales estimados según el tipo y condición.
* **Acciones:** 
  * `"Guardar Análisis"` - Persiste el análisis en el espacio.
  * `"Volver a Escanear"` - Reinicia el escaneo.

### 3.10. Análisis Guardado (`AnalysisSavedView`)
* **Propósito:** Confirmación de que el análisis fue guardado exitosamente.
* **Componentes:**
  * Resumen del análisis guardado.
  * Botón `"Volver a Espacios"` - Regresa al listado de espacios de la planta.

### 3.11. Detalle de Espacio (`SpaceDetailView`)
* **Propósito:** Ver el listado de análisis guardados para un espacio específico.
* **Componentes:**
  * Nombre del espacio y descripción.
  * Listado de análisis con fecha, tipo (Piso/Ventana/Muro), medidas y condición.
  * Botón para agregar nuevo análisis.

---

## 4. Componentes y Módulos de la Aplicación

### Módulos Implementados

1. **App** (`App/`)
   - `AppRootView.swift` - Punto de entrada con NavigationStack y routing centralizado

2. **Navigation** (`Navigation/`)
   - `NavigationRouter.swift` - Enum `NavigationScreen` con todas las rutas (type-safe navigation)
   - Casos: welcome, projectList, createProject, projectDetail, floorDetail, createSpace, spaceTypeSelect, scanning, analysisResult, analysisSaved, spaceDetail

3. **Views** (`Views/`)
   - `WelcomeView.swift` - Pantalla de bienvenida (logo, descripción, botón "Comencemos")
   - `ProjectListView.swift` - Dashboard de proyectos (métricas + lista de cards)
   - `OtherViews.swift` - Contiene:
     - `CreateProjectView.swift` - Formulario crear proyecto (nombre, dirección, tipo, plantas)
     - `ProjectDetailView.swift` - Resumen proyecto + lista de plantas ([FICHA TÉCNICA])
     - `FloorDetailView.swift` - Lista de espacios + indicador LiDAR 3D ACTIVO
     - `CreateSpaceView.swift` - Input para nombre del espacio
     - `SpaceTypeSelectView.swift` - Selector de tipo (Piso/Ventana/Muro)
     - `ScanningView.swift` - Visualización 3D con medidas superpuestas
     - `AnalysisResultView.swift` - Dimensiones, condición de obra, materiales estimados
     - `AnalysisSavedView.swift` - Confirmación de análisis guardado
     - `SpaceDetailView.swift` - Dossier del espacio + listado de análisis guardados

4. **Models** (`Models.swift`)
   - Entidades: `Project`, `Floor`, `Space`, `Analysis`
   - Enumeraciones: `ProjectType`, `AnalysisType`, `ConstructionStage`

5. **Utilities**
   - `ToastView.swift` - Componente de notificación reutilizable
   - `ToastManager.swift` - Gestor de toasts globales

---

## 4. Pila Tecnológica (Tech Stack)

| Capa | Tecnología / Framework | Propósito |
| :--- | :--- | :--- |
| **Interfaz de Usuario** | **SwiftUI** | Construcción de una UI reactiva, moderna y 100% nativa en iOS. |
| **Escaneo Espacial** | **ARKit** + **RoomPlan** | Procesamiento del sensor LiDAR para detección de planos, muros, aperturas y dimensiones métricas. |
| **Persistencia Local** | **SwiftData** | Almacenamiento local tipo ORM para los proyectos, plantas, espacios, y análisis. |
| **Notificaciones** | **Toast** | Sistema unificado de notificaciones para crear proyecto, crear espacio, guardar análisis. |

---

## 6. Comportamientos Esperados

### Crear Proyecto
1. Usuario presiona "Crear Proyecto" en `ProjectListView`
2. Navega a `CreateProjectView`
3. Completa formulario (nombre, dirección, persona encargada, tipo, # plantas)
4. Presiona "Crear Proyecto"
5. Sistema crea `Project` y automáticamente `Floor` para cada número de planta (1, 2, 3, etc.)
6. Toast: "Proyecto creado exitosamente"
7. Regresa a `ProjectListView` con el nuevo proyecto visible

### Navegar a Planta
1. Usuario selecciona un proyecto en `ProjectListView`
2. Va a `ProjectDetailView` (resumen + lista de plantas)
3. Selecciona una planta (Ej: Planta 2)
4. Navega a `FloorDetailView` (listado de espacios de esa planta)

### Crear Espacio
1. En `FloorDetailView`, usuario presiona "Crear Espacio"
2. Navega a `CreateSpaceView`
3. Completa nombre y descripción
4. Presiona "Crear Espacio"
5. Toast: "Espacio creado exitosamente"
6. Regresa a `FloorDetailView` con el nuevo espacio en la lista

### Analizar Espacio
1. En `FloorDetailView`, usuario selecciona un espacio y presiona "Analizar Espacio"
2. Navega a `SpaceTypeSelectView`
3. Selecciona tipo (Piso, Ventana o Muro)
4. Navega a `ARScannerView` (escaneo simulado)
5. Presiona "Analizar"
6. Navega a `AnalysisResultView` (muestra medidas, permite seleccionar condición)
7. Presiona "Guardar Análisis"
8. Sistema crea `Analysis` y lo asocia al `Space`
9. Navega a `AnalysisSavedView` (resumen del análisis guardado)
10. Presiona "Volver a Espacios"
11. Regresa a `FloorDetailView`

### Ver Análisis de un Espacio
1. En `FloorDetailView`, usuario presiona sobre un espacio (en lugar de "Analizar")
2. Navega a `SpaceDetailView`
3. Muestra listado de análisis guardados para ese espacio
4. Puede seleccionar un análisis para ver detalles o crear uno nuevo

### Toast Unificado
- Se muestra en la esquina superior/inferior de la pantalla
- Desaparece automáticamente después de 3 segundos
- Mensajes: "Proyecto creado exitosamente", "Espacio creado exitosamente", "Análisis guardado exitosamente"

---

## 5. Modelo de Datos (SwiftData)

### Enumeraciones

```swift
import Foundation
import SwiftData

enum ProjectType: String, Codable, CaseIterable {
    case house = "Casa"
    case building = "Edificio"
    case office = "Oficina"
}

enum AnalysisType: String, Codable, CaseIterable {
    case floor = "Piso"
    case window = "Ventana"
    case wall = "Muro"
}

enum ConstructionStage: String, Codable, CaseIterable {
    case roughIn = "Obra Negra"
    case grayStructure = "Obra Gris"
    case finished = "Obra Blanca"
}
```

### Entidades Principales

```swift
@Model
final class Project {
    @Attribute(.unique) var id: UUID
    var name: String
    var address: String
    var responsiblePerson: String
    var type: ProjectType
    var numberOfFloors: Int
    var createdAt: Date
    var updatedAt: Date
    
    @Relationship(deleteRule: .cascade, inverse: \Floor.project) 
    var floors: [Floor] = []
    
    init(name: String, address: String, responsiblePerson: String, 
         type: ProjectType, numberOfFloors: Int) {
        self.id = UUID()
        self.name = name
        self.address = address
        self.responsiblePerson = responsiblePerson
        self.type = type
        self.numberOfFloors = numberOfFloors
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}

@Model
final class Floor {
    @Attribute(.unique) var id: UUID
    var number: Int  // 1, 2, 3, etc.
    var project: Project?
    var createdAt: Date
    
    @Relationship(deleteRule: .cascade, inverse: \Space.floor)
    var spaces: [Space] = []
    
    init(number: Int) {
        self.id = UUID()
        self.number = number
        self.createdAt = Date()
    }
}

@Model
final class Space {
    @Attribute(.unique) var id: UUID
    var name: String  // Ej: Cuarto Principal, Sala, Cocina
    var description: String  // Ej: Cuarto de 3 paredes de concreto, 1 ventana, piso repellado
    var floor: Floor?
    var createdAt: Date
    
    @Relationship(deleteRule: .cascade, inverse: \Analysis.space)
    var analyses: [Analysis] = []
    
    init(name: String, description: String) {
        self.id = UUID()
        self.name = name
        self.description = description
        self.createdAt = Date()
    }
}

@Model
final class Analysis {
    @Attribute(.unique) var id: UUID
    var type: AnalysisType  // Piso, Ventana, Muro
    var width: Double  // en metros
    var height: Double  // en metros
    var area: Double  // en m²
    var stage: ConstructionStage
    var materials: [String: String]  // Nombre material -> cantidad
    var space: Space?
    var createdAt: Date
    
    init(type: AnalysisType, width: Double, height: Double, 
         area: Double, stage: ConstructionStage) {
        self.id = UUID()
        self.type = type
        self.width = width
        self.height = height
        self.area = area
        self.stage = stage
        self.materials = [:]
        self.createdAt = Date()
    }
}
```

### Relaciones

- **Project** → **Floor** (1 a muchos)
  - Un proyecto tiene múltiples plantas (número de plantas definido al crear)
  
- **Floor** → **Space** (1 a muchos)
  - Una planta contiene múltiples espacios
  
- **Space** → **Analysis** (1 a muchos)
  - Un espacio puede tener múltiples análisis (del mismo tipo o diferentes)