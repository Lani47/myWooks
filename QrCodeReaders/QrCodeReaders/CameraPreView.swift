//
//  CameraPreView.swift
//  QrCodeReaders
//
//  Created by cmStudent on 2021/10/28.
//

import UIKit
import AVFoundation

class CameraPreView: UIView {

    private var label:UILabel?

    var previewLayer: AVCaptureVideoPreviewLayer?
    var session = AVCaptureSession()
    weak var delegate: QRCodeProspector?

    init(session: AVCaptureSession) {
        super.init(frame: .zero)
        self.session = session
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func onClick(){
        delegate?.onSimulateScanning()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer?.frame = self.bounds
    }
}

