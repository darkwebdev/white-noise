import AVFoundation
import Combine

@MainActor
class WhiteNoiseEngine: ObservableObject {
    private let audioEngine = AVAudioEngine()
    private var sourceNode: AVAudioSourceNode?

    @Published var isPlaying = false

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

        let sourceNode = AVAudioSourceNode { _, _, frameCount, audioBufferList -> OSStatus in
            let ablPointer = UnsafeMutableAudioBufferListPointer(audioBufferList)

            for frame in 0..<Int(frameCount) {
                let randomSample = Float.random(in: -1.0...1.0) * 0.3

                for buffer in ablPointer {
                    let buf: UnsafeMutableBufferPointer<Float> = UnsafeMutableBufferPointer(buffer)
                    buf[frame] = randomSample
                }
            }

            return noErr
        }

        self.sourceNode = sourceNode

        audioEngine.attach(sourceNode)
        audioEngine.connect(sourceNode, to: mainMixer, format: audioFormat)
        audioEngine.prepare()
    }

    func play() {
        guard !audioEngine.isRunning else { return }

        do {
            try audioEngine.start()
            isPlaying = true
        } catch {
            print("Failed to start audio engine: \(error.localizedDescription)")
        }
    }

    func pause() {
        guard audioEngine.isRunning else { return }

        audioEngine.pause()
        isPlaying = false
    }
}
