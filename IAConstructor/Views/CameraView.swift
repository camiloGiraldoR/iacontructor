import SwiftUI
import AVFoundation

struct CameraView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = CameraViewController()
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update if needed
    }
}

class CameraViewController: UIViewController {
    var captureSession: AVCaptureSession?
    let previewLayer = AVCaptureVideoPreviewLayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        setupCamera()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if let session = captureSession, session.isRunning {
            DispatchQueue.global(qos: .userInitiated).async {
                session.stopRunning()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let session = captureSession, !session.isRunning {
            DispatchQueue.global(qos: .userInitiated).async {
                session.startRunning()
            }
        }
    }

    private func setupCamera() {
        let session = AVCaptureSession()
        session.sessionPreset = .high

        // Usar solo cámara trasera (back camera)
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("❌ No se pudo acceder a la cámara trasera")
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: backCamera)

            if session.canAddInput(input) {
                session.addInput(input)
            }

            // Configurar salida de video simple (sin procesar frames)
            let videoOutput = AVCaptureVideoDataOutput()

            if session.canAddOutput(videoOutput) {
                session.addOutput(videoOutput)
            }

            // Configurar orientación
            if let connection = videoOutput.connection(with: .video) {
                connection.isVideoMirrored = false
            }

            // Configurar preview layer
            previewLayer.session = session
            previewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer)

            self.captureSession = session

            // Iniciar sesión en background thread
            DispatchQueue.global(qos: .userInitiated).async {
                session.startRunning()
            }

        } catch {
            print("❌ Error al configurar cámara: \(error.localizedDescription)")
        }
    }
}

#Preview {
    CameraView()
        .frame(height: 300)
}
