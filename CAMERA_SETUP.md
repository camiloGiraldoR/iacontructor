# Configuración de Cámara - IAConstructor

## 📱 Resumen

Se ha implementado una prueba de concepto (PoC) que integra **captura de video en tiempo real** desde la cámara trasera del dispositivo directamente en la interfaz de `ScanningView`.

## 🎥 Características

- **Cámara Trasera Únicamente**: Solo usa `AVCaptureDevice` con posición `.back`
- **Sin LiDAR**: Por ahora captura video simple (LiDAR se integrará después)
- **UIViewControllerRepresentable**: Integración limpia entre UIKit (AVFoundation) y SwiftUI
- **Preview en Tiempo Real**: Muestra el feed de la cámara en un recuadro de 250pt altura
- **Gestión de Sesión**: Auto-pausa al cambiar de vista y resume cuando vuelve

## 🗂️ Archivos Principales

### `Views/CameraView.swift`
```swift
struct CameraView: UIViewControllerRepresentable
```

**Componentes:**

1. **CameraView** (SwiftUI struct)
   - Wrapper que hace puente entre SwiftUI y UIKit
   - Crea instancia de `CameraViewController`

2. **CameraViewController** (UIViewController)
   - Configura `AVCaptureSession` con cámara trasera
   - Maneja `AVCaptureVideoPreviewLayer` para mostrar feed
   - Ciclo de vida: setup → start → pause → resume → stop

**Métodos principales:**
- `setupCamera()` — Inicializa AVFoundation
- `viewWillAppear()` — Reanuda la sesión
- `viewWillDisappear()` — Pausa la sesión

### `Views/OtherViews.swift` - ScanningView

Integración en la pantalla de escaneo:

```swift
VStack(spacing: 16) {
    VStack {
        CameraView()
            .frame(height: 250)
            .cornerRadius(12)
            .clipped()
    }
    .background(Color(red: 0.067, green: 0.098, blue: 0.145))
    .cornerRadius(12)
    
    // Indicador de estado
    VStack(alignment: .leading, spacing: 8) {
        HStack {
            Image(systemName: "dot.circle.fill")
            Text("Cámara Trasera Activa")
        }
    }
}
```

## 🔐 Permisos Necesarios

### iOS 17+ (SwiftUI Info Configuration)

Los permisos deben agregarse en Xcode:

**Pasos:**
1. Seleccionar `IAConstructor.xcodeproj`
2. Ir a **Target > Info**
3. Agregar keys:
   - `NSCameraUsageDescription`: "Necesitamos acceso a tu cámara trasera para escanear y medir espacios usando la tecnología de visión por computadora."

### En tiempo de ejecución

El sistema iOS mostrará un diálogo pidiendo permiso la primera vez que se intente acceder a la cámara.

**Usuario verá:** "IAConstructor quiere acceder a tu cámara"
- [Permitir] [No permitir]

## 📊 Arquitectura

```
ScanningView
    ↓
CameraView (SwiftUI)
    ↓
CameraViewController (UIKit)
    ↓
AVCaptureSession
    ├── Input: AVCaptureDevice (.back)
    ├── Output: AVCaptureVideoDataOutput
    └── Preview: AVCaptureVideoPreviewLayer
```

## 🚀 Uso en la Pantalla

1. Usuario navega a `SpaceTypeSelectView`
2. Selecciona tipo (Piso/Ventana/Muro)
3. Va a `ScanningView`
4. **CameraView activa automáticamente**
5. Se ve el feed de la cámara trasera
6. Usuario puede presionar "Analizar"

## 🔄 Próximos Pasos

### Fase 1: Captura Mejorada (Corto Plazo)
- [ ] Agregar controles de enfoque (tap to focus)
- [ ] Indicadores visuales de calidad de imagen
- [ ] Captura de frames con button "Capturar"

### Fase 2: ARKit Integration (Mediano Plazo)
- [ ] Integrar `ARViewContainer` para visualización 3D
- [ ] Usar `ARFrame` para acceder a datos de profundidad

### Fase 3: LiDAR Integration (Largo Plazo)
- [ ] Integrar `RoomPlan` framework
- [ ] Procesar nube de puntos del LiDAR
- [ ] Calcular dimensiones en tiempo real

### Fase 4: Machine Learning (Futuro)
- [ ] Usar `Vision` framework para detección de planos
- [ ] ML models para clasificación de superficies
- [ ] Predicción de materiales basada en IA

## 🧪 Testing

### En Simulador
- La cámara no funciona en simulador (AVFoundation limitation)
- Use un device real con iOS 17+

### En Device Real
1. Abrir XCode con device conectado
2. Presionar ▶️ (Run)
3. Navegar a ScanningView
4. Permitir acceso a cámara en diálogo
5. Ver feed en tiempo real

## 📝 Notas de Desarrollo

### Performance
- La sesión se pausa al cambiar de vista para conservar batería
- La captura corre a 30fps (preset: `.high`)
- Thread seguro: operaciones en `DispatchQueue.global(qos: .userInitiated)`

### Seguridad
- Sin grabación de video (solo preview)
- Sin almacenamiento de imágenes
- Permiso explícito del usuario requerido
- Cámara frontal bloqueada (solo `.back`)

### Compatibilidad
- iOS 17.0+ requerido
- Dispositivos con cámara trasera (iPhone 12+)
- Próximas versiones de iOS mantendrán soporte

## 🐛 Troubleshooting

### "❌ No se pudo acceder a la cámara trasera"
**Causa:** Dispositivo sin cámara trasera (iPad sin cámara, etc.)
**Solución:** Testear en iPhone o iPad con cámara

### Permiso Negado
**Causa:** Usuario seleccionó "No permitir" en diálogo
**Solución:** Ir a Configuración > IAConstructor > Cámara > Permitir

### Pantalla Negra
**Causa:** Sesión no iniciada o permiso pendiente
**Solución:** Esperar diálogo de permisos, asegurar `.isRunning`

## 📚 Referencias

- [AVFoundation - Apple Developer](https://developer.apple.com/documentation/avfoundation)
- [UIViewControllerRepresentable - Apple Docs](https://developer.apple.com/documentation/swiftui/uiviewcontrollerrepresentable)
- [Privacy - Camera - Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/privacy)

---

**Última actualización:** 26 Septiembre 2026
**Status:** PoC - Funcional en device real
