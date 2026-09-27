# IAConstructor - Guía de Desarrollo

## 📱 Estructura del Proyecto Modularizado

### Directorios Principales

```
IAConstructor/
├── App/                     # App entry point y routing
│   └── AppRootView.swift   # NavigationStack root
├── Navigation/              # Enrutamiento centralizado
│   └── NavigationRouter.swift
├── Views/                   # Todas las pantallas
│   ├── WelcomeView.swift
│   ├── ProjectListView.swift
│   └── OtherViews.swift    # Todas las demás vistas
├── Models.swift             # Entidades de datos
├── ToastView.swift          # Componentes reutilizables
└── docs/                    # Documentación
```

## 🗺️ Flujo de Navegación Completo

```
WelcomeView
    ↓ "Comencemos"
ProjectListView
    ├── Crear Proyecto → CreateProjectView → ProjectListView (con toast)
    └── Seleccionar → ProjectDetailView
                        ├── [FICHA TÉCNICA] (Dirección, Responsable, Fecha)
                        └── Seleccionar Planta → FloorDetailView
                                                  ├── "Crear Espacio" → CreateSpaceView → FloorDetailView
                                                  ├── "Ver Detalles" → SpaceDetailView
                                                  │                     ├── "Dossier del Espacio"
                                                  │                     └── "Análisis Guardados" (lista de análisis)
                                                  └── "Analizar" → SpaceTypeSelectView
                                                                    ├── Piso
                                                                    ├── Ventana
                                                                    └── Muro → ScanningView
                                                                               ├── Visualización 3D
                                                                               └── "Analizar" → AnalysisResultView
                                                                                                ├── Dimensiones Detectadas
                                                                                                ├── Condición de Obra (Negra/Gris/Blanca)
                                                                                                └── Materiales Estimados
                                                                                                    ├── "Guardar Análisis" → AnalysisSavedView
                                                                                                    │                        ├── Confirmación
                                                                                                    │                        └── "Ver Proyecto" o "Escanear Otro"
                                                                                                    └── "Volver a Escanear"
```

## 📋 Pantallas Implementadas

### 1. WelcomeView (`Views/WelcomeView.swift`)
- Logo con círculos concéntricos
- Descripción de la app
- Badge "Compatible con Apple LiDAR & ARKit"
- Botón principal "Comencemos"

### 2. ProjectListView (`Views/ProjectListView.swift`)
- Métricas: "03 Proyectos" y "17 Espacios Scan"
- Tarjetas de proyecto con:
  - Nombre y dirección
  - Badge de tipo (Casa/Edificio/Oficina)
  - Número de plantas
  - Fecha de creación
- Botón "+" para crear proyecto

### 3. CreateProjectView (`Views/OtherViews.swift`)
- Formulario con:
  - Nombre del proyecto
  - Dirección
  - Tipo (selector segmentado)
  - Número de plantas (botones +/-)
- Toast de éxito
- Regresa a ProjectListView

### 4. ProjectDetailView (`Views/OtherViews.swift`)
- Sección "[FICHA TÉCNICA]" con:
  - Dirección
  - Responsable
  - Fecha de creación
  - Badge de tipo
- Listado de plantas con contador "3 Total"
- Cada planta muestra: número, cantidad de espacios analizados

### 5. FloorDetailView (`Views/OtherViews.swift`)
- Indicador "MODO LIDAR 3D ACTIVO" con porcentaje (98.4% ACC.)
- Botón "Crear Espacio"
- Lista de espacios con:
  - Nombre
  - Contador de análisis
  - Descripción (materiales de construcción)
  - Botones "Ver Detalles" y "Analizar"

### 6. CreateSpaceView (`Views/OtherViews.swift`)
- Input simple para nombre del espacio
- Validación (botón deshabilitado si está vacío)
- Toast de éxito

### 7. SpaceTypeSelectView (`Views/OtherViews.swift`)
- 3 opciones:
  - Piso (square.fill)
  - Ventana (square.grid.2x2)
  - Muro (square.split.2x1)
- Cada opción es un botón con descripción

### 8. ScanningView (`Views/OtherViews.swift`)
- Visualización 3D simulada
- Medidas superpuestas (3.20 m ancho, 2.85 m alto)
- Indicador de "Superfície detectada | 9.12 m²"
- Botón "Analizar"

### 9. AnalysisResultView (`Views/OtherViews.swift`)
- Chip con tipo de espacio escaneado (Muro Escaneado | ID)
- **DIMENSIONES DETECTADAS:**
  - Ancho, Alto, Área de Superficie, Perímetro
- **Condición de Obra:**
  - 3 botones: Negra, Gris, Blanca (selectable)
- **MATERIALES ESTIMADOS:**
  - Lista de materiales con cantidades
- Botones "Guardar Análisis" y "Volver a Escanear"

### 10. AnalysisSavedView (`Views/OtherViews.swift`)
- Icono de confirmación (checkmark.circle.fill)
- Título "¡Análisis Guardado!"
- Checklist de acciones completadas
- Botones "Ver Proyecto" o "Escanear Otro Espacio"

### 11. SpaceDetailView (`Views/OtherViews.swift`)
- **Dossier del Espacio:** descripción del espacio
- **Análisis Guardados:** contador y lista de análisis previos
- Cada análisis muestra:
  - Icono tipo
  - Nombre del análisis
  - Badge con fase de construcción
  - Medidas
  - Fecha
- Botón "Nuevo Análisis" para crear otro

## 🎨 Paleta de Colores

| Elemento | RGB |
|----------|-----|
| Fondo principal | 11, 14, 23 (0.043, 0.055, 0.09) |
| Cyan/Acento | 0, 240, 255 (0, 0.94, 1) |
| Texto secundario | 143, 156, 179 (0.56, 0.61, 0.70) |
| Fondo cards | 17, 25, 37 (0.067, 0.098, 0.145) |
| Naranja (iconos) | 204, 102, 51 (0.8, 0.4, 0.2) |

## 🔀 Sistema de Navegación

### Uso de NavigationScreen Enum

```swift
// Push a new screen
navigationPath.append(.projectDetail(projectID))

// Pop current screen
navigationPath.removeLast()

// Pop N screens
navigationPath.removeLast(3)

// Navigate back to root
navigationPath = []
```

### Binding para sub-componentes

Todos los sub-componentes reciben `@Binding var navigationPath: [NavigationScreen]` para que puedan navegar.

## 🧪 Testing with Previews

Cada archivo de vista incluye un `#Preview` block:

```swift
#Preview {
    ProjectListView(navigationPath: .constant([]))
}
```

## 📦 Próximos Pasos

1. **Integración de SwiftData**: Conectar modelos a las vistas
2. **ARKit/RoomPlan**: Implementar escaneo LiDAR real
3. **Persistencia**: Guardar análisis en base de datos
4. **Cálculos**: Implementar estimador de materiales real
5. **Tests**: Agregar unit y UI tests

## 🛠️ Desarrollo de Nuevas Vistas

1. Crear archivo en `Views/` (o agregar a `OtherViews.swift`)
2. Importar `SwiftUI`
3. Crear struct con `@Binding var navigationPath: [NavigationScreen]`
4. Agregar case a `NavigationScreen` enum en `NavigationRouter.swift`
5. Agregar mapeo en `NavigationDestinationView` en `AppRootView.swift`
6. Agregar `#Preview` block para testing visual

Ejemplo:

```swift
struct MyNewView: View {
    @Binding var navigationPath: [NavigationScreen]
    
    var body: some View {
        ZStack {
            Color(red: 0.043, green: 0.055, blue: 0.09)
                .ignoresSafeArea()
            
            VStack {
                // Content
                Button(action: {
                    navigationPath.append(.welcome)
                }) {
                    Text("Go to Welcome")
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MyNewView(navigationPath: .constant([]))
}
```
