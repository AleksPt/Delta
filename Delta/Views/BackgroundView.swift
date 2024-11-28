public struct BackgroundView<Content: View>: View {
    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        ZStack {
            Color.CustomColors.background.ignoresSafeArea()
            content
        }
    }
}