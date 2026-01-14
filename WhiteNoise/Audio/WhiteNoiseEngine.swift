import AVFoundation
import Combine

enum NoiseType: String, CaseIterable, Hashable {
    case white = "White Noise"
    case pink = "Pink Noise"
    case brown = "Brown Noise"
    case blue = "Blue Noise"
    case shush = "Soothing"
    case seaWaves = "Sea Waves"
    case heartbeat = "Heartbeat"
    case cafe = "Cafe"
    case rain = "Rain"
    case beach = "Beach"

    var icon: String {
        switch self {
        case .white: return "waveform"
        case .pink: return "waveform.path"
        case .brown: return "waveform.path.ecg"
        case .blue: return "waveform.circle"
        case .shush: return "mouth.fill"
        case .seaWaves: return "water.waves"
        case .heartbeat: return "heart.fill"
        case .cafe: return "cup.and.saucer.fill"
        case .rain: return "cloud.rain.fill"
        case .beach: return "beach.umbrella.fill"
        }
    }

    var isSampleBased: Bool {
        switch self {
        case .cafe, .rain, .beach:
            return true
        default:
            return false
        }
    }
}

@MainActor
class WhiteNoiseEngine: ObservableObject {
    private let audioEngine = AVAudioEngine()
    private var sourceNode: AVAudioSourceNode?
    private var playerNode: AVAudioPlayerNode?
    private var audioFile: AVAudioFile?

    @Published var isPlaying = false
    @Published var currentNoiseType: NoiseType = .white

    private var pinkState: (Float, Float, Float, Float, Float, Float, Float) = (0, 0, 0, 0, 0, 0, 0)
    private var brownValue: Float = 0
    private var shushState: Float = 0
    private var wavePhase: Float = 0
    private var waveAmplitude: Float = 0
    private var heartbeatPhase: Float = 0
    private var sampleIndex: Int = 0

    func setupAudioGraph() {
        let mainMixer = audioEngine.mainMixerNode
        let outputFormat = mainMixer.outputFormat(forBus: 0)
        let sampleRate = outputFormat.sampleRate

        let format = AVAudioFormat(
            standardFormatWithSampleRate: sampleRate,
            channels: 1
        )

        guard let audioFormat = format else {
            print("Failed to create audio format")
            return
        }

        let sourceNode = AVAudioSourceNode { [weak self] _, _, frameCount, audioBufferList -> OSStatus in
            guard let self = self else { return noErr }
            let ablPointer = UnsafeMutableAudioBufferListPointer(audioBufferList)

            for frame in 0..<Int(frameCount) {
                let sample = self.generateSample()

                for buffer in ablPointer {
                    let buf: UnsafeMutableBufferPointer<Float> = UnsafeMutableBufferPointer(buffer)
                    buf[frame] = sample
                }
            }

            return noErr
        }

        self.sourceNode = sourceNode

        audioEngine.attach(sourceNode)
        audioEngine.connect(sourceNode, to: mainMixer, format: audioFormat)
        audioEngine.prepare()
    }

    private func generateSample() -> Float {
        switch currentNoiseType {
        case .white:
            return Float.random(in: -1.0...1.0) * 0.3
        case .pink:
            return generatePinkNoise()
        case .brown:
            return generateBrownNoise()
        case .blue:
            return generateBlueNoise()
        case .shush:
            return generateShushNoise()
        case .seaWaves:
            return generateSeaWaves()
        case .heartbeat:
            return generateHeartbeat()
        case .cafe, .rain, .beach:
            return 0 // Sample-based, not generated
        }
    }

    private func generatePinkNoise() -> Float {
        let white = Float.random(in: -1.0...1.0)
        pinkState.0 = 0.99886 * pinkState.0 + white * 0.0555179
        pinkState.1 = 0.99332 * pinkState.1 + white * 0.0750759
        pinkState.2 = 0.96900 * pinkState.2 + white * 0.1538520
        pinkState.3 = 0.86650 * pinkState.3 + white * 0.3104856
        pinkState.4 = 0.55000 * pinkState.4 + white * 0.5329522
        pinkState.5 = -0.7616 * pinkState.5 - white * 0.0168980
        let pink = pinkState.0 + pinkState.1 + pinkState.2 + pinkState.3 + pinkState.4 + pinkState.5 + pinkState.6 + white * 0.5362
        pinkState.6 = white * 0.115926
        return pink * 0.11
    }

    private func generateBrownNoise() -> Float {
        let white = Float.random(in: -1.0...1.0)
        brownValue = (brownValue + (0.02 * white)) / 1.02
        return brownValue * 3.5
    }

    private func generateBlueNoise() -> Float {
        let white = Float.random(in: -1.0...1.0)
        return white * 0.2
    }

    private func generateShushNoise() -> Float {
        let white = Float.random(in: -1.0...1.0)

        // Simulate high-frequency shush sound (2-8kHz band-pass)
        shushState = 0.9 * shushState + white * 0.1
        let bandpass = white - shushState

        return bandpass * 0.35
    }

    private func generateSeaWaves() -> Float {
        let sampleRate: Float = 44100
        sampleIndex += 1

        // Wave period: 3-5 seconds for realistic ocean waves
        let wavePeriod: Float = 4.0
        let baseFreq: Float = 1.0 / wavePeriod

        wavePhase += 2.0 * Float.pi * baseFreq / sampleRate
        if wavePhase > 2.0 * Float.pi {
            wavePhase = 0
            waveAmplitude = Float.random(in: 0.6...1.0)
        }

        // Envelope: slow rise, quick fall (like waves crashing)
        let normalizedPhase = wavePhase / (2.0 * Float.pi)
        var envelope: Float = 0.0

        if normalizedPhase < 0.7 {
            // Slow rise
            envelope = pow(normalizedPhase / 0.7, 2.0)
        } else {
            // Quick fall
            let fallPhase = (normalizedPhase - 0.7) / 0.3
            envelope = 1.0 - pow(fallPhase, 0.5)
        }

        // Add filtered noise for wave texture
        let white = Float.random(in: -1.0...1.0)
        let lowpass = brownValue * 0.95 + white * 0.05
        brownValue = lowpass

        // Combine wave oscillation with noise
        let wave = sin(wavePhase * 3.0) * 0.3 + sin(wavePhase * 7.0) * 0.15

        return (wave + lowpass * 0.5) * envelope * waveAmplitude * 0.5
    }

    private func generateHeartbeat() -> Float {
        let sampleRate: Float = 44100
        let bpm: Float = 72
        let beatFreq: Float = bpm / 60.0

        heartbeatPhase += 2.0 * Float.pi * beatFreq / sampleRate
        if heartbeatPhase > 2.0 * Float.pi {
            heartbeatPhase -= 2.0 * Float.pi
        }

        let normalizedPhase = heartbeatPhase / (2.0 * Float.pi)
        var sample: Float = 0.0

        // First beat (LUB) - stronger, lower
        if normalizedPhase < 0.08 {
            let t = normalizedPhase / 0.08
            sample = sin(t * Float.pi) * exp(-t * 10.0) * 0.9
        }
        // Second beat (DUB) - softer, slightly higher
        else if normalizedPhase >= 0.12 && normalizedPhase < 0.18 {
            let t = (normalizedPhase - 0.12) / 0.06
            sample = sin(t * Float.pi) * exp(-t * 12.0) * 0.6
        }

        return sample * 0.7
    }

    func play() {
        guard !audioEngine.isRunning else { return }

        if currentNoiseType.isSampleBased {
            playSampleAudio()
        } else {
            do {
                try audioEngine.start()
                isPlaying = true
            } catch {
                print("Failed to start audio engine: \(error.localizedDescription)")
            }
        }
    }

    func pause() {
        if currentNoiseType.isSampleBased {
            playerNode?.stop()
        } else {
            audioEngine.pause()
        }
        isPlaying = false
    }

    func setNoiseType(_ type: NoiseType) {
        if currentNoiseType == type && isPlaying {
            pause()
        } else {
            let wasPlaying = isPlaying

            if wasPlaying {
                pause()
            }

            currentNoiseType = type

            // If switching between generated and sample-based, need to reconfigure
            if type.isSampleBased != (sourceNode != nil) {
                audioEngine.stop()
                if type.isSampleBased {
                    setupSamplePlayback()
                } else {
                    setupAudioGraph()
                }
            }

            play()
        }
    }

    private func setupSamplePlayback() {
        // Remove old nodes
        if let sourceNode = sourceNode {
            audioEngine.detach(sourceNode)
            self.sourceNode = nil
        }

        if let playerNode = playerNode {
            audioEngine.detach(playerNode)
        }

        let player = AVAudioPlayerNode()
        playerNode = player
        audioEngine.attach(player)

        let mainMixer = audioEngine.mainMixerNode
        audioEngine.connect(player, to: mainMixer, format: nil)
        audioEngine.prepare()
    }

    private func playSampleAudio() {
        guard let player = playerNode else { return }

        // For now, generate a simple looping buffer as placeholder
        // In a real app, you would load actual audio files
        let sampleRate: Double = 44100
        let duration: Double = 10.0
        let frameCount = AVAudioFrameCount(sampleRate * duration)

        guard let format = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 1) else {
            return
        }

        guard let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount) else {
            return
        }

        buffer.frameLength = frameCount

        // Generate placeholder audio based on type
        if let channelData = buffer.floatChannelData?[0] {
            for frame in 0..<Int(frameCount) {
                channelData[frame] = generatePlaceholderSample(for: currentNoiseType, frame: frame, sampleRate: Float(sampleRate))
            }
        }

        do {
            try audioEngine.start()
            player.scheduleBuffer(buffer, at: nil, options: .loops)
            player.play()
            isPlaying = true
        } catch {
            print("Failed to play sample audio: \(error.localizedDescription)")
        }
    }

    private func generatePlaceholderSample(for type: NoiseType, frame: Int, sampleRate: Float) -> Float {
        switch type {
        case .cafe:
            // Cafe: mix of brown noise and occasional clinks
            let brown = Float.random(in: -0.3...0.3)
            let clink = (frame % 22050 < 100) ? Float.random(in: -0.5...0.5) : 0
            return brown + clink * 0.3
        case .rain:
            // Rain: filtered white noise with varying intensity
            let intensity = sin(Float(frame) / sampleRate * 0.1) * 0.5 + 0.5
            return Float.random(in: -1.0...1.0) * 0.4 * intensity
        case .beach:
            // Beach: waves + seagulls (simplified)
            let waveFreq: Float = 0.2
            let wave = sin(2.0 * Float.pi * waveFreq * Float(frame) / sampleRate) * 0.5
            let noise = Float.random(in: -0.2...0.2)
            return wave + noise
        default:
            return 0
        }
    }
}
