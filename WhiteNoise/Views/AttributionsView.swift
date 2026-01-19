import SwiftUI

struct AttributionsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("This app uses audio files generously provided by their creators.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 8)

                    // Cafe
                    AttributionItem(
                        title: "Cafe Ambiance",
                        fileName: "cafe.wav",
                        description: "Pizzeria soundscape (1:30)",
                        source: "BigSoundBank - Restaurant",
                        license: "CC0 (Public Domain)",
                        url: "https://bigsoundbank.com/detail-0624-restaurant.html"
                    )

                    Divider()

                    // Rain
                    AttributionItem(
                        title: "Rain and Thunder",
                        fileName: "rain.wav",
                        description: "Heavy rain with thunderstorm (0:42)",
                        source: "BigSoundBank - Rain and Storm",
                        license: "CC0 (Public Domain)",
                        url: "https://bigsoundbank.com/detail-0124-rain-and-storm.html"
                    )

                    Divider()

                    // Beach
                    AttributionItem(
                        title: "Beach Waves",
                        fileName: "beach.wav",
                        description: "Holidaymakers on beach with waves (1:22)",
                        source: "BigSoundBank - Beach and Sea",
                        license: "CC0 (Public Domain)",
                        url: "https://bigsoundbank.com/beach-and-sea-s1059.html"
                    )

                    Divider()

                    // Sea Waves
                    AttributionItem(
                        title: "Beach Waves with Seagulls",
                        fileName: "sea_waves.wav",
                        description: "Gentle beach waves with seagulls",
                        source: "BigSoundBank",
                        license: "CC0 (Public Domain)",
                        url: "https://bigsoundbank.com/"
                    )

                    Divider()

                    // Shush
                    AttributionItem(
                        title: "Rhythmic Shushing",
                        fileName: "shush_rhythmic.wav",
                        description: "Processed shushing sound for baby soothing",
                        source: "Orange Free Sounds",
                        license: "CC BY 4.0",
                        url: "https://orangefreesounds.com/"
                    )

                    Divider()

                    // Thank you note
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Thank You")
                            .font(.headline)

                        Text("Special thanks to BigSoundBank and all sound designers who make their work available for projects like this.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
            }
            .navigationTitle("Attributions")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(colorScheme == .dark ? .pastelMintDark : .pastelLavender)
                }
            }
        }
    }
}

struct AttributionItem: View {
    let title: String
    let fileName: String
    let description: String
    let source: String
    let license: String
    let url: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)

            Text(fileName)
                .font(.system(.caption, design: .monospaced))
                .foregroundColor(.secondary)

            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)

            HStack(spacing: 4) {
                Text("Source:")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Link(source, destination: URL(string: url)!)
                    .font(.caption)
            }

            HStack(spacing: 4) {
                Text("License:")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(license)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    AttributionsView()
}
