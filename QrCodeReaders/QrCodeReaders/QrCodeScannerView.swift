//
//  QrCodeScannerView.swift
//  QrCodeReaders
//
//  Created by cmStudent on 2021/10/28.
//

import SwiftUI
import AVFoundation

struct QrCodeScannerView: UIViewRepresentable {

    var supportedBarcodeTypes: [AVMetadataObject.ObjectType] = [.qr]
    typealias UIViewType = CameraPreView

    private let session = AVCaptureSession()
    private let delegate = QRCodeProspector()
 
    private let metadataOutput = AVCaptureMetadataOutput()

    func interval(delay: Double) -> QrCodeScannerView {
        delegate.scanInterval = delay
        return self
    }

    func found(r: @escaping (String) -> Void) -> QrCodeScannerView {
        print("found")
        delegate.onResult = r
        return self
    }

    func setupCamera(_ uiView: CameraPreView) {
        if let backCamera = AVCaptureDevice.default(for: AVMediaType.video) {
            if let input = try? AVCaptureDeviceInput(device: backCamera) {
                session.sessionPreset = .photo

                if session.canAddInput(input) {
                    session.addInput(input)
                }
                if session.canAddOutput(metadataOutput) {
                    session.addOutput(metadataOutput)

                    metadataOutput.metadataObjectTypes = supportedBarcodeTypes
                    metadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
                }
                let previewLayer = AVCaptureVideoPreviewLayer(session: session)

                uiView.backgroundColor = UIColor.gray
                previewLayer.videoGravity = .resizeAspectFill
                uiView.layer.addSublayer(previewLayer)
                uiView.previewLayer = previewLayer

                session.startRunning()
            }
        }

    }

    func makeUIView(context: UIViewRepresentableContext<QrCodeScannerView>) -> QrCodeScannerView.UIViewType {
        let cameraView = CameraPreView(session: session)

        checkCameraAuthorizationStatus(cameraView)

        return cameraView
    }

    static func dismantleUIView(_ uiView: CameraPreView, coordinator: ()) {
        uiView.session.stopRunning()
    }

    private func checkCameraAuthorizationStatus(_ uiView: CameraPreView) {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if cameraAuthorizationStatus == .authorized {
            setupCamera(uiView)
        } else {
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.sync {
                    if granted {
                        self.setupCamera(uiView)
                    }
                }
            }
        }
    }

    func updateUIView(_ uiView: CameraPreView, context: UIViewRepresentableContext<QrCodeScannerView>) {
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }

}
