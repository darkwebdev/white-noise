import AVFoundation
import Combine

enum NoiseType: String, CaseIterable, Hashable {
    case white = "White Noise"
    case pink = "Pink Noise"
    case brown = "Brown Noise"
    case blue = "Blue Noise"
    case shushSoft = "Soft Shush"
    case shushRhythmic = "Soothing"
    case shushDeep = "Deep Shush"
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
        case .shushSoft: return "speaker.wave.1.fill"
        case .shushRhythmic: return "speaker.wave.2.fill"
        case .shushDeep: return "speaker.wave.3.fill"
        case .seaWaves: return "water.waves"
        case .heartbeat: return "heart.fill"
        case .cafe: return "cup.and.saucer.fill"
        case .rain: return "cloud.rain.fill"
        case .beach: return "beach.umbrella.fill"
        }
    }

    var isSampleBased: Bool {
        switch self {
        case .shushSoft, .shushRhythmic, .shushDeep, .seaWaves, .heartbeat, .cafe, .rain, .beach:
            return true
        default:
            return false
        }
    }

    var audioFileName: String {
        switch self {
        case .shushSoft: return "shush_soft"
        case .shushRhythmic: return "shush_rhythmic"
        case .shushDeep: return "shush_deep"
        case .seaWaves: return "sea_waves"
        case .heartbeat: return "heartbeat"
        case .cafe: return "cafe"
        case .rain: return "rain"
        case .beach: return "beach"
        default: return ""
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
    private var shushPhase: Float = 0
    private var shushBurstState: Float = 0
    private var wavePhase: Float = 0
    private var waveAmplitude: Float = 0
    private var waveLowpassState: Float = 0
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
            return Float.random(in: -1.0...1.0) * 0.15
        case .pink:
            return generatePinkNoise() * 0.5
        case .brown:
            return generateBrownNoise() * 0.3
        case .blue:
            return generateBlueNoise() * 0.5
        case .shushSoft:
            return generateShushSoft()
        case .shushRhythmic:
            return generateShushRhythmic()
        case .shushDeep:
            return generateShushDeep()
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

    private func generateShushSoft() -> Float {
        // Continuous "ssshhhh" sound - band-pass filter around 4-8kHz (human "sh" sound)
        let white = Float.random(in: -1.0...1.0)

        // First stage high-pass to remove low frequencies
        let alpha1: Float = 0.98  // High-pass around 400Hz at 44.1kHz
        shushState = alpha1 * shushState + alpha1 * (white - shushState)

        // Second stage high-pass to emphasize sibilance
        let alpha2: Float = 0.95  // High-pass around 1kHz
        let hp2 = alpha2 * (shushState - brownValue)
        brownValue = shushState

        return hp2 * 0.4
    }

    private func generateShushRhythmic() -> Float {
        let sampleRate: Float = 44100

        // Rhythmic "shh-shh-shh" pattern (0.7s on, 0.3s off)
        let burstPeriod: Float = 1.0
        let burstFreq: Float = 1.0 / burstPeriod

        shushPhase += 2.0 * Float.pi * burstFreq / sampleRate
        if shushPhase > 2.0 * Float.pi {
            shushPhase -= 2.0 * Float.pi
        }

        let normalizedPhase = shushPhase / (2.0 * Float.pi)

        // Envelope: quick attack, sustain, quick release
        var burstEnvelope: Float = 0.0
        if normalizedPhase < 0.05 {
            // Quick attack (50ms)
            burstEnvelope = normalizedPhase / 0.05
        } else if normalizedPhase < 0.70 {
            // Sustain at full volume
            burstEnvelope = 1.0
        } else if normalizedPhase < 0.75 {
            // Quick release (50ms)
            burstEnvelope = (0.75 - normalizedPhase) / 0.05
        }
        // else: silence from 0.75 to 1.0

        // Band-pass filtered noise for "sh" sound
        let white = Float.random(in: -1.0...1.0)

        // High-pass stage
        let alpha1: Float = 0.98
        shushState = alpha1 * shushState + alpha1 * (white - shushState)

        // Second high-pass stage
        let alpha2: Float = 0.94
        let hp2 = alpha2 * (shushState - shushBurstState)
        shushBurstState = shushState

        return hp2 * burstEnvelope * 0.5
    }

    private func generateShushDeep() -> Float {
        // Deep "womb" sound - low rumble (brown) with gentle whooshing (pink)
        let white = Float.random(in: -1.0...1.0)

        // Deep brown noise rumble (very low frequency)
        brownValue = (brownValue + (0.02 * white)) / 1.02

        // Pink noise for gentle whooshing texture
        pinkState.0 = 0.99886 * pinkState.0 + white * 0.0555179
        pinkState.1 = 0.99332 * pinkState.1 + white * 0.0750759
        let pink = (pinkState.0 + pinkState.1) * 0.15

        // Mix: mostly brown rumble, gentle pink whoosh
        return brownValue * 3.5 * 0.6 + pink * 0.4
    }

    private func generateSeaWaves() -> Float {
        let sampleRate: Float = 44100

        // Wave cycle: 16.5 seconds (very slow, calm ocean with longer pauses)
        let wavePeriod: Float = 16.5
        let baseFreq: Float = 1.0 / wavePeriod

        wavePhase += 2.0 * Float.pi * baseFreq / sampleRate
        if wavePhase > 2.0 * Float.pi {
            wavePhase = 0
            waveAmplitude = Float.random(in: 0.7...1.0)
        }

        let normalizedPhase = wavePhase / (2.0 * Float.pi)
        var envelope: Float = 0.0

        // Asymmetric wave envelope: quick rise, slow fall (like real ocean waves)
        // Start at 30% volume to avoid silence
        if normalizedPhase < 0.3 {
            // Quick rise (30% of cycle)
            envelope = 0.3 + 0.7 * pow(normalizedPhase / 0.3, 2.5)
        } else {
            // Slow, gradual fall (70% of cycle)
            let fallPhase = (normalizedPhase - 0.3) / 0.7
            envelope = 0.3 + 0.7 * pow(1.0 - fallPhase, 1.5)
        }

        // Use brown noise as base (more natural than white)
        let white = Float.random(in: -1.0...1.0)
        brownValue = brownValue * 0.99 + white * 0.01

        return brownValue * envelope * waveAmplitude * 0.8
    }

    private func generateHeartbeat() -> Float {
        let sampleRate: Float = 44100
        let bpm: Float = 45  // Very slow, deeply restful
        let beatFreq: Float = bpm / 60.0

        heartbeatPhase += 2.0 * Float.pi * beatFreq / sampleRate
        if heartbeatPhase > 2.0 * Float.pi {
            heartbeatPhase -= 2.0 * Float.pi
        }

        let normalizedPhase = heartbeatPhase / (2.0 * Float.pi)
        var sample: Float = 0.0

        // First beat (LUB) - deep, resonant
        if normalizedPhase < 0.06 {
            let t = normalizedPhase / 0.06
            let freq: Float = 80.0  // Low frequency thump
            sample = sin(t * Float.pi) * sin(t * freq) * exp(-t * 15.0) * 0.8
        }
        // Second beat (DUB) - shorter, higher
        else if normalizedPhase >= 0.10 && normalizedPhase < 0.14 {
            let t = (normalizedPhase - 0.10) / 0.04
            let freq: Float = 120.0  // Slightly higher
            sample = sin(t * Float.pi) * sin(t * freq) * exp(-t * 20.0) * 0.5
        }

        return sample * 1.0
    }

    func play() {
        if currentNoiseType.isSampleBased {
            playSampleAudio()
        } else {
            guard !audioEngine.isRunning else { return }
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
        NSLog("🔵 setNoiseType called with: \(type.rawValue), isSampleBased: \(type.isSampleBased)")

        if currentNoiseType == type && isPlaying {
            pause()
        } else {
            let wasPlaying = isPlaying

            if wasPlaying {
                pause()
            }

            currentNoiseType = type

            // If switching between generated and sample-based, need to reconfigure
            let isCurrentlySampleBased = playerNode != nil
            let needsReconfigure = type.isSampleBased != isCurrentlySampleBased
            NSLog("🔧 needsReconfigure: \(needsReconfigure), type.isSampleBased: \(type.isSampleBased), isCurrentlySampleBased: \(isCurrentlySampleBased)")

            if needsReconfigure {
                audioEngine.stop()
                if type.isSampleBased {
                    NSLog("🎵 Setting up sample playback")
                    setupSamplePlayback()
                } else {
                    NSLog("🎵 Setting up audio graph")
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

        // Connect without specifying format - will use the file's format when scheduled
        let mainMixer = audioEngine.mainMixerNode
        audioEngine.connect(player, to: mainMixer, format: nil)
        audioEngine.prepare()
    }

    private func playSampleAudio() {
        guard let player = playerNode else {
            NSLog("❌ ERROR: playerNode is nil")
            return
        }

        // Try to load actual audio file
        let fileName = currentNoiseType.audioFileName
        NSLog("🎵 Attempting to load audio file: \(fileName).wav")

        if let url = Bundle.main.url(forResource: fileName, withExtension: "wav") {
            NSLog("✅ Found audio file at: \(url.path)")
            do {
                let file = try AVAudioFile(forReading: url)
                let format = file.processingFormat
                let frameCount = AVAudioFrameCount(file.length)

                NSLog("📊 Audio file format: \(format)")
                NSLog("📊 Frame count: \(frameCount)")

                // Reconnect player with the file's format
                let mainMixer = audioEngine.mainMixerNode
                audioEngine.disconnectNodeOutput(player)
                audioEngine.connect(player, to: mainMixer, format: format)

                guard let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount) else {
                    NSLog("❌ ERROR: Failed to create buffer for \(fileName)")
                    return
                }

                try file.read(into: buffer)
                NSLog("✅ Successfully read \(frameCount) frames")

                // Start engine if not running
                if !audioEngine.isRunning {
                    try audioEngine.start()
                    NSLog("🎵 Audio engine started")
                }

                player.scheduleBuffer(buffer, at: nil, options: .loops)
                player.play()
                isPlaying = true
                NSLog("▶️ Playing audio file: \(fileName).wav")
                return
            } catch {
                NSLog("❌ ERROR: Failed to load audio file \(fileName).wav: \(error.localizedDescription)")
            }
        } else {
            NSLog("❌ ERROR: Audio file \(fileName).wav not found in bundle")
        }

        // Fallback: generate placeholder audio
        NSLog("⚠️ Using placeholder audio for \(fileName)")
        playPlaceholderAudio()
    }

    private func playPlaceholderAudio() {
        guard let player = playerNode else { return }

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
