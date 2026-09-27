# IAConstructor - iOS App para Medición y Estimación de Materiales

**IAConstructor** es una aplicación nativa para iOS que utiliza la tecnología **LiDAR** de Apple y **ARKit** para medir dimensiones de espacios en tiempo real y estimar automáticamente los materiales necesarios para proyectos de construcción y renovación.

## 🎯 Características Principales

- 📐 **Medición LiDAR Precisa**: Escanea muros, pisos y ventanas usando el sensor LiDAR del dispositivo
- 🏗️ **Estimación de Materiales**: Calcula automáticamente la cantidad de materiales según dimensiones y tipo de obra
- 📊 **Gestión de Proyectos**: Organiza múltiples proyectos, plantas y espacios de forma jerárquica
- 💾 **Persistencia Local**: Guarda análisis y proyectos en el dispositivo con SwiftData
- 🎨 **Interfaz Moderna**: Diseño intuitivo en SwiftUI con paleta dark y acentos cyan
- 📱 **Compatible con LiDAR**: iPhone 12 Pro+ o iPad Pro (2020+)

## 🚀 Inicio Rápido

### Requisitos
- macOS 13.0+
- Xcode 15.0+
- iOS 17.0+ para destino

### Instalación

```bash
# Clonar el repositorio
git clone <repo-url>
cd IAConstructor

# Abrir en Xcode
open IAConstructor.xcodeproj
```

### Compilar y Ejecutar

```bash
# Compilar proyecto
xcodebuild -project IAConstructor.xcodeproj -scheme IAConstructor -configuration Debug

# Ejecutar en simulador
xcodebuild -project IAConstructor.xcodeproj -scheme IAConstructor \
  -destination 'platform=iOS Simulator,name=iPhone 16'

# O desde Xcode: presiona ⌘R
```

## 📁 Estructura del Proyecto

```
IAConstructor/
├── App/                          # Punto de entrada
│   └── AppRootView.swift        # NavigationStack root con routing centralizado
├── Navigation/                   # Sistema de navegación
│   └── NavigationRouter.swift   # Enum NavigationScreen (type-safe routing)
├── Views/                        # Todas las pantallas
│   ├── WelcomeView.swift        # Pantalla de bienvenida
│   ├── ProjectListView.swift    # Dashboard de proyectos
│   └── OtherViews.swift         # Resto de vistas (9 componentes)
├── Models.swift                  # Entidades SwiftData
├── ToastView.swift               # Componentes reutilizables
├── ContentView.swift             # Entry point (@main)
├── IAConstructorApp.swift        # App config
├── Assets.xcassets/              # Imágenes, colores, iconos
└── docs/
    ├── especificaci_n_del_proyecto_iaconstructor.md  # Spec completa (ES)
    └── README.md                 # Este archivo
```

## 🗺️ Flujo de Navegación

```
WelcomeView
    ↓ "Comencemos"
ProjectListView (Dashboard)
    ├── "Crear Proyecto" → CreateProjectView → Toast → ProjectListView
    └── Seleccionar Proyecto → ProjectDetailView
                                 └── Seleccionar Planta → FloorDetailView
                                     ├── "Crear Espacio" → CreateSpaceView → Toast
                                     ├── "Ver Detalles" → SpaceDetailView (análisis previos)
                                     └── "Analizar" → SpaceTypeSelectView
                                         ├── Piso
                                         ├── Ventana
                                         └── Muro → ScanningView → AnalysisResultView
                                                     (3D + Medidas)  (Validar + Materiales)
                                                                       ↓
                                                         AnalysisSavedView (Confirmación)
                                                         ├── "Ver Proyecto"
                                                         └── "Escanear Otro"
```

## 📋 Pantallas Implementadas (11 vistas)

### 1. **WelcomeView**
Pantalla de bienvenida con logo, descripción y botón principal "Comencemos".

### 2. **ProjectListView**
Dashboard mostrando:
- Métricas: "03 Proyectos", "17 Espacios Scan"
- Tarjetas de proyecto con nombre, dirección, tipo, plantas y fecha
- Botón "+" para crear nuevo proyecto

### 3. **CreateProjectView**
Formulario con:
- Nombre del proyecto
- Dirección
- Tipo: Casa / Edificio / Oficina (selector segmentado)
- Número de plantas (botones +/-)
- Toast de éxito "Proyecto creado satisfactoriamente"

### 4. **ProjectDetailView**
Resumen del proyecto con:
- Sección "[FICHA TÉCNICA]": Dirección, Responsable, Fecha de creación
- Listado de plantas con contador "3 Total"
- Cada planta muestra cantidad de espacios analizados

### 5. **FloorDetailView**
Gestión de espacios en una planta:
- Indicador "MODO LIDAR 3D ACTIVO" (98.4% ACC.)
- Botón "Crear Espacio"
- Lista de espacios con descripción
- Botones "Ver Detalles" (outline) y "Analizar" (cyan)

### 6. **CreateSpaceView**
Formulario simple para nombre del espacio con validación.

### 7. **SpaceTypeSelectView**
Selector de 3 tipos de escaneo:
- **Piso** (square.fill)
- **Ventana** (square.grid.2x2)
- **Muro** (square.split.2x1)

### 8. **ScanningView**
Visualización 3D con:
- Medidas superpuestas (3.20 m ancho, 2.85 m alto)
- Indicador "Superfície detectada | 9.12 m²"
- Botón "Analizar"

### 9. **AnalysisResultView**
Validación de datos con:
- Chip identificativo (Ej: "Muro Escaneado | ESPACIO_04")
- **DIMENSIONES DETECTADAS**: Ancho, Alto, Área, Perímetro
- **Condición de Obra**: Negra / Gris / Blanca (selectable)
- **MATERIALES ESTIMADOS**: Lista de materiales con cantidades
- Botones "Guardar Análisis" y "Volver a Escanear"

### 10. **AnalysisSavedView**
Confirmación con:
- Icono checkmark
- Mensaje "¡Análisis Guardado!"
- Checklist de acciones completadas
- Botones "Ver Proyecto" o "Escanear Otro Espacio"

### 11. **SpaceDetailView**
Dossier del espacio con:
- Descripción del espacio
- **Análisis Guardados**: Lista de análisis previos con fecha, medidas y fase
- Botón "Nuevo Análisis"

## 🎨 Paleta de Colores

| Elemento | RGB | Hex |
|----------|-----|-----|
| Fondo principal | 11, 14, 23 | #0B0E17 |
| **Cyan/Acento** | 0, 240, 255 | #00F0FF |
| Texto secundario | 143, 156, 179 | #8F9CB3 |
| Fondo cards | 17, 25, 37 | #111925 |
| Naranja (iconos) | 204, 102, 51 | #CC6633 |

## 🔀 Sistema de Navegación Type-Safe

El proyecto usa un `NavigationScreen` enum centralizado en `NavigationRouter.swift`:

```swift
// Navegar adelante
navigationPath.append(.projectDetail("proj_1"))

// Volver atrás
navigationPath.removeLast()

// Volver múltiples niveles
navigationPath.removeLast(3)

// Ir a raíz
navigationPath = []
```

Todas las vistas reciben `@Binding var navigationPath: [NavigationScreen]` para poder navegar.

## 📦 Modelo de Datos (SwiftData)

### Entidades Principales

```swift
@Model final class Project {
    var id: UUID
    var name: String
    var address: String
    var responsiblePerson: String
    var type: ProjectType // Casa, Edificio, Oficina
    var numberOfFloors: Int
    @Relationship(deleteRule: .cascade) var floors: [Floor] = []
}

@Model final class Floor {
    var id: UUID
    var number: Int  // 1, 2, 3...
    @Relationship(deleteRule: .cascade) var spaces: [Space] = []
}

@Model final class Space {
    var id: UUID
    var name: String
    var description: String
    @Relationship(deleteRule: .cascade) var analyses: [Analysis] = []
}

@Model final class Analysis {
    var id: UUID
    var type: AnalysisType  // Piso, Ventana, Muro
    var width: Double      // metros
    var height: Double     // metros
    var area: Double       // m²
    var stage: ConstructionStage  // Negra, Gris, Blanca
    var materials: [String: String]  // nombre -> cantidad
}
```

## 🛠️ Desarrollo

### Agregar una Nueva Vista

1. Crear archivo en `Views/` (o agregar a `OtherViews.swift`)
2. Importar `SwiftUI` y crear struct con `@Binding var navigationPath`
3. Agregar case a `NavigationScreen` enum
4. Agregar mapeo en `NavigationDestinationView` en `AppRootView.swift`
5. Agregar `#Preview` block

### Ejemplo

```swift
struct MyNewView: View {
    @Binding var navigationPath: [NavigationScreen]
    
    var body: some View {
        ZStack {
            Color(red: 0.043, green: 0.055, blue: 0.09)
                .ignoresSafeArea()
            
            VStack {
                Text("Mi Vista")
                    .foregroundColor(.white)
                
                Button("Ir atrás") {
                    navigationPath.removeLast()
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

### Testing with Previews

Cada vista tiene un `#Preview` block para testing visual en Xcode:

```bash
# Abrir Xcode y presionar Cmd+Alt+Enter en cualquier preview
# O usar el botón Play en el canvas
```

## 📚 Documentación

- **[CLAUDE.md](CLAUDE.md)** - Instrucciones de desarrollo y arquitectura
- **[DEVELOPMENT.md](DEVELOPMENT.md)** - Guía técnica completa y próximos pasos
- **[especificación_del_proyecto_iaconstructor.md](IAConstructor/docs/especificaci_n_del_proyecto_iaconstructor.md)** - Spec completa en español

## 📋 Próximos Pasos

- [ ] Integración de SwiftData: Conectar modelos a las vistas
- [ ] ARKit/RoomPlan: Implementar escaneo LiDAR real
- [ ] Persistencia: Guardar análisis en base de datos
- [ ] Cálculos: Implementar estimador de materiales real
- [ ] Tests: Agregar unit y UI tests
- [ ] Autenticación: Sistema de usuarios y sincronización cloud
- [ ] Exportación: Generar reportes PDF de análisis

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📝 Licencia

Este proyecto está bajo licencia MIT. Ver archivo `LICENSE` para detalles.

## 📞 Contacto y Soporte

Para reportar bugs o solicitar features, abre un issue en este repositorio.

---

**Última actualización:** 26 de Septiembre de 2026

🏗️ Construyendo el futuro con tecnología LiDAR de Apple
