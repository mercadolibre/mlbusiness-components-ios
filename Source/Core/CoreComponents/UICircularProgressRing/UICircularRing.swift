import UIKit

protocol UICircularProgressRingDelegate: class {
    func didFinishProgress(for ring: UICircularProgressRing)
    func didPauseProgress(for ring: UICircularProgressRing)
    func didContinueProgress(for ring: UICircularProgressRing)
    func didUpdateProgressValue(for ring: UICircularProgressRing, to newValue: CGFloat)
    func willDisplayLabel(for ring: UICircularProgressRing, _ label: UILabel)
}

// MARK: UICircularRing
// codebeat:disable[TOO_MANY_IVARS,TOO_MANY_FUNCTIONS,LOC,ABC,ARITY,CYCLO,TOTAL_COMPLEXITY,TOTAL_LOC]
class UICircularRing: UIView {
    var fullCircle: Bool = true {
        didSet { ringLayer.setNeedsDisplay() }
    }

    var style: UICircularRingStyle = .inside {
        didSet { ringLayer.setNeedsDisplay() }
    }

    var shouldShowValueText: Bool = true {
        didSet { ringLayer.setNeedsDisplay() }
    }

    var valueKnobStyle: UICircularRingValueKnobStyle? {
        didSet { ringLayer.setNeedsDisplay() }
    }

    var startAngle: CGFloat = 0 {
        didSet { ringLayer.setNeedsDisplay() }
    }

    var endAngle: CGFloat = 360 {
        didSet { ringLayer.setNeedsDisplay() }
    }

    var outerRingWidth: CGFloat = 10.0 {
        didSet { ringLayer.setNeedsDisplay() }
    }

    var outerRingColor: UIColor = UIColor.gray {
        didSet { ringLayer.setNeedsDisplay() }
    }

    var outerCapStyle: CGLineCap = .butt {
        didSet { ringLayer.setNeedsDisplay() }
    }

    var innerRingWidth: CGFloat = 5.0 {
        didSet { ringLayer.setNeedsDisplay() }
    }

    var innerRingColor: UIColor = UIColor.blue {
        didSet { ringLayer.setNeedsDisplay() }
    }

    var innerRingSpacing: CGFloat = 1 {
        didSet { ringLayer.setNeedsDisplay() }
    }

    var innerCapStyle: CGLineCap = .round {
        didSet { ringLayer.setNeedsDisplay() }
    }

    var fontColor: UIColor = UIColor.black {
        didSet { ringLayer.setNeedsDisplay() }
    }

    var innerCenterText: String? {
        didSet { ringLayer.setNeedsDisplay() }
    }

    var font: UIFont = UIFont.ml_semiboldSystemFont(ofSize: 28) {
        didSet { ringLayer.setNeedsDisplay() }
    }

    var isAnimating: Bool {
        return ringLayer.animation(forKey: .value) != nil
    }

    var isClockwise: Bool = true {
        didSet { ringLayer.setNeedsDisplay() }
    }

    typealias PropertyAnimationCompletion = (() -> Void)

    var ringLayer: UICircularRingLayer {
        return layer as! UICircularRingLayer
    }

    private var pausedTimeRemaining: TimeInterval = 0

    private var animationPauseTime: CFTimeInterval?

    var snapshottedAnimation: CAAnimation?

    var animationCompletionTimer: Timer?

    typealias AnimationCompletion = () -> Void

    override class var layerClass: AnyClass {
        return UICircularRingLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    func initialize() {
        ringLayer.ring = self

        ringLayer.contentsScale = UIScreen.main.scale
        ringLayer.shouldRasterize = true
        ringLayer.rasterizationScale = UIScreen.main.scale * 2
        ringLayer.masksToBounds = false

        backgroundColor = UIColor.clear
        ringLayer.backgroundColor = UIColor.clear.cgColor

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(restoreAnimation),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(snapshotAnimation),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    func didUpdateValue(newValue: CGFloat) { }

    func willDisplayLabel(label: UILabel) { }

    func startAnimation(duration: TimeInterval, completion: @escaping AnimationCompletion) {
        if isAnimating {
            animationPauseTime = nil
        }
        ringLayer.timeOffset = 0
        ringLayer.beginTime = 0
        ringLayer.speed = 1
        ringLayer.animated = duration > 0
        ringLayer.animationDuration = duration

        animationCompletionTimer?.invalidate()
        animationCompletionTimer = Timer.scheduledTimer(timeInterval: duration,
                                                        target: self,
                                                        selector: #selector(self.animationDidComplete),
                                                        userInfo: completion,
                                                    repeats: false)
    }

    func pauseAnimation() {
        guard isAnimating else {
            return
        }

        snapshotAnimation()

        let pauseTime = ringLayer.convertTime(CACurrentMediaTime(), from: nil)
        animationPauseTime = pauseTime

        ringLayer.speed = 0.0
        ringLayer.timeOffset = pauseTime

        if let fireTime = animationCompletionTimer?.fireDate {
            pausedTimeRemaining = fireTime.timeIntervalSince(Date())
        } else {
            pausedTimeRemaining = 0
        }

        animationCompletionTimer?.invalidate()
        animationCompletionTimer = nil
    }

    func continueAnimation(completion: @escaping AnimationCompletion) {
        guard let pauseTime = animationPauseTime else {
            return
        }

        restoreAnimation()

        ringLayer.speed = 1.0
        ringLayer.timeOffset = 0.0
        ringLayer.beginTime = 0.0

        let timeSincePause = ringLayer.convertTime(CACurrentMediaTime(), from: nil) - pauseTime

        ringLayer.beginTime = timeSincePause

        animationCompletionTimer?.invalidate()
        animationCompletionTimer = Timer.scheduledTimer(timeInterval: pausedTimeRemaining,
                                               target: self,
                                               selector: #selector(animationDidComplete),
                                               userInfo: completion,
                                               repeats: false)

        animationPauseTime = nil
    }

    func resetAnimation() {
        ringLayer.animated = false
        ringLayer.removeAnimation(forKey: .value)
        snapshottedAnimation = nil

        animationCompletionTimer?.invalidate()
        animationCompletionTimer = nil
        animationPauseTime = nil

    }

    func animateProperties(duration: TimeInterval, animations: () -> Void) {
        animateProperties(duration: duration, animations: animations, completion: nil)
    }

    func animateProperties(duration: TimeInterval, animations: () -> Void,
                                completion: PropertyAnimationCompletion? = nil) {
        ringLayer.shouldAnimateProperties = true
        ringLayer.propertyAnimationDuration = duration
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.ringLayer.shouldAnimateProperties = false
            self.ringLayer.propertyAnimationDuration = 0.0
            completion?()
        }
        animations()
        CATransaction.commit()
    }
}

extension UICircularRing {
    @objc func snapshotAnimation() {
        guard let animation = ringLayer.animation(forKey: .value) else { return }
        snapshottedAnimation = animation
    }

    @objc func restoreAnimation() {
        guard let animation = snapshottedAnimation else { return }
        ringLayer.add(animation, forKey: AnimationKeys.value.rawValue)
    }

    @objc func animationDidComplete(withTimer timer: Timer) {
        (timer.userInfo as? AnimationCompletion)?()
    }

    enum AnimationKeys: String {
        case value
    }
}

// MARK: UICircularProgressRing
final class UICircularProgressRing: UICircularRing {
    weak var delegate: UICircularProgressRingDelegate?
    var value: CGFloat = 0 {
        didSet {
            if value < minValue {
                ringLayer.value = minValue
            } else if value > maxValue {
                ringLayer.value = maxValue
            } else {
                ringLayer.value = value
            }
        }
    }

    var currentValue: CGFloat? {
        return isAnimating ? layer.presentation()?.value(forKey: .value) as? CGFloat : value
    }

    var minValue: CGFloat = 0.0 {
        didSet { ringLayer.minValue = minValue }
    }

    var maxValue: CGFloat = 100.0 {
        didSet { ringLayer.maxValue = maxValue }
    }

    var animationTimingFunction: CAMediaTimingFunctionName = .easeInEaseOut {
        didSet { ringLayer.animationTimingFunction = animationTimingFunction }
    }

    var valueFormatter: UICircularRingValueFormatter = UICircularProgressRingFormatter() {
        didSet { ringLayer.valueFormatter = valueFormatter }
    }

    typealias ProgressCompletion = (() -> Void)
    private var completion: ProgressCompletion?

    func startProgress(to value: CGFloat, duration: TimeInterval, completion: ProgressCompletion? = nil) {
        // Store the completion event locally
        self.completion = completion

        // call super class helper function to begin animating layer
        startAnimation(duration: duration) {
            self.delegate?.didFinishProgress(for: self)
            self.completion?()
        }

        self.value = value
    }

    func pauseProgress() {
        // call super class helper to stop layer animation
        pauseAnimation()
        delegate?.didPauseProgress(for: self)
    }

    func continueProgress() {
        // call super class helper to continue layer animation
        continueAnimation {
            self.delegate?.didFinishProgress(for: self)
            self.completion?()
        }
        delegate?.didContinueProgress(for: self)
    }

    func resetProgress() {
        // call super class helper to reset animation layer
        resetAnimation()
        value = minValue
        // Remove reference to the completion block
        completion = nil
    }

    override func initialize() {
        super.initialize()
        ringLayer.ring = self
        ringLayer.value = value
        ringLayer.maxValue = maxValue
        ringLayer.minValue = minValue
        ringLayer.valueFormatter = valueFormatter
    }

    override func didUpdateValue(newValue: CGFloat) {
        super.didUpdateValue(newValue: newValue)
        delegate?.didUpdateProgressValue(for: self, to: newValue)
    }

    override func willDisplayLabel(label: UILabel) {
        super.willDisplayLabel(label: label)
        delegate?.willDisplayLabel(for: self, label)
    }
}

// MARK: Extensions
internal extension CALayer {
    func removeAnimation(forKey key: UICircularRing.AnimationKeys) {
        removeAnimation(forKey: key.rawValue)
    }

    func animation(forKey key: UICircularRing.AnimationKeys) -> CAAnimation? {
        return animation(forKey: key.rawValue)
    }

    func value(forKey key: UICircularRing.AnimationKeys) -> Any? {
        return value(forKey: key.rawValue)
    }
}

internal extension CGFloat {
    var rads: CGFloat { return self * CGFloat.pi / 180 }
}

internal extension TimeInterval {
    var float: CGFloat { return CGFloat(self) }
}

internal extension CGFloat {
    var interval: TimeInterval { return TimeInterval(self) }
}

// MARK: UICircularRingLayer
// codebeat:disable[TOO_MANY_IVARS,TOO_MANY_FUNCTIONS,LOC,ABC,ARITY,CYCLO,TOTAL_COMPLEXITY,TOTAL_LOC]
class UICircularRingLayer: CAShapeLayer {
    // MARK: Properties
    @NSManaged var value: CGFloat
    @NSManaged var minValue: CGFloat
    @NSManaged var maxValue: CGFloat

    /// the delegate for the value, is notified when value changes
    @NSManaged weak var ring: UICircularRing!

    /// formatter for the text of the value label
    var valueFormatter: UICircularRingValueFormatter?

    /// the style for the value knob
    var valueKnobStyle: UICircularRingValueKnobStyle?

    // MARK: Animation members

    var animationDuration: TimeInterval = 1.0
    var animationTimingFunction: CAMediaTimingFunctionName = .easeInEaseOut
    var animated = false

    /// the value label which draws the text for the current value
    lazy var valueLabel: UILabel = UILabel(frame: .zero)

    // MARK: Animatable properties

    /// whether or not animatable properties should be animated when changed
    var shouldAnimateProperties: Bool = false

    /// the animation duration for a animatable property animation
    var propertyAnimationDuration: TimeInterval = 0.0

    /// the properties which are animatable
    static let animatableProperties: [String] = ["innerRingWidth", "innerRingColor",
                                                 "outerRingWidth", "outerRingColor",
                                                 "fontColor", "innerRingSpacing"]

    // Returns whether or not a given property key is animatable
    static func isAnimatableProperty(_ key: String) -> Bool {
        return animatableProperties.firstIndex(of: key) != nil
    }

    // MARK: Init

    override init() {
        super.init()
    }

    override init(layer: Any) {
        guard let layer = layer as? UICircularRingLayer else {
            super.init()
            return
        }
        valueFormatter = layer.valueFormatter
        valueKnobStyle = layer.valueKnobStyle
        animationDuration = layer.animationDuration
        animationTimingFunction = layer.animationTimingFunction
        animated = layer.animated
        shouldAnimateProperties = layer.shouldAnimateProperties
        propertyAnimationDuration = layer.propertyAnimationDuration
        super.init(layer: layer)
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    // MARK: Draw

    /**
     Overriden for custom drawing.
     Draws the outer ring, inner ring and value label.
     */
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        UIGraphicsPushContext(ctx)
        // Draw the rings
        drawOuterRing()
        drawInnerRing(in: ctx)
        // Draw the label
        drawValueLabel()
        // Call the delegate and notifiy of updated value
        if let updatedValue = value(forKey: "value") as? CGFloat {
            ring.didUpdateValue(newValue: updatedValue)
        }
        UIGraphicsPopContext()

    }

    // MARK: Animation methods

    /**
     Watches for changes in the value property, and setNeedsDisplay accordingly
     */
    override class func needsDisplay(forKey key: String) -> Bool {
        if key == "value" || isAnimatableProperty(key) {
            return true
        } else {
            return super.needsDisplay(forKey: key)
        }
    }

    /**
     Creates animation when value property is changed
     */
    override func action(forKey event: String) -> CAAction? {
        if event == "value" && animated {
            let animation = CABasicAnimation(keyPath: "value")
            animation.fromValue = presentation()?.value(forKey: "value")
            animation.timingFunction = CAMediaTimingFunction(name: animationTimingFunction)
            animation.duration = animationDuration
            return animation
        } else if UICircularRingLayer.isAnimatableProperty(event) && shouldAnimateProperties {
            let animation = CABasicAnimation(keyPath: event)
            animation.fromValue = presentation()?.value(forKey: event)
            animation.timingFunction = CAMediaTimingFunction(name: animationTimingFunction)
            animation.duration = propertyAnimationDuration
            return animation
        } else {
            return super.action(forKey: event)
        }
    }

    // MARK: Helpers

    /**
     Draws the outer ring for the view.
     Sets path properties according to how the user has decided to customize the view.
     */
    private func drawOuterRing() {
        guard ring.outerRingWidth > 0 else { return }
        let center: CGPoint = CGPoint(x: bounds.midX, y: bounds.midY)

        let knobSize = ring.valueKnobStyle?.size ?? 0
        let borderWidth: CGFloat
        if case let UICircularRingStyle.bordered(width, _) = ring.style {
            borderWidth = width
        } else {
            borderWidth = 0
        }

        let offSet = max(ring.outerRingWidth, ring.innerRingWidth) / 2
            + (knobSize / 4)
            + (borderWidth * 2)
        let outerRadius: CGFloat = min(bounds.width, bounds.height) / 2 - offSet
        let start: CGFloat = ring.fullCircle ? 0 : ring.startAngle.rads
        let end: CGFloat = ring.fullCircle ? .pi * 2 : ring.endAngle.rads
        let outerPath = UIBezierPath(arcCenter: center,
                                     radius: outerRadius + borderWidth,
                                     startAngle: start,
                                     endAngle: end,
                                     clockwise: true)
        outerPath.lineWidth = ring.outerRingWidth
        outerPath.lineCapStyle = ring.outerCapStyle
        // Update path depending on style of the ring
        updateOuterRingPath(outerPath, radius: outerRadius, style: ring.style)

        ring.outerRingColor.setStroke()
        outerPath.stroke()
    }

    /**
     Draws the inner ring for the view.
     Sets path properties according to how the user has decided to customize the view.
     */
    private func drawInnerRing(in ctx: CGContext) {
        guard ring.innerRingWidth > 0 else { return }

        let center: CGPoint = CGPoint(x: bounds.midX, y: bounds.midY)

        let innerEndAngle = calculateInnerEndAngle()
        let radiusIn = calculateInnerRadius()

        // Start drawing
        let innerPath: UIBezierPath = UIBezierPath(arcCenter: center,
                                                   radius: radiusIn,
                                                   startAngle: ring.startAngle.rads,
                                                   endAngle: innerEndAngle.rads,
                                                   clockwise: ring.isClockwise)

        // Draw path
        ctx.setLineWidth(ring.innerRingWidth)
        ctx.setLineJoin(.round)
        ctx.setLineCap(ring.innerCapStyle)
        ctx.setStrokeColor(ring.innerRingColor.cgColor)
        ctx.addPath(innerPath.cgPath)
        ctx.drawPath(using: .stroke)

        ctx.saveGState()
        ctx.addPath(innerPath.cgPath)
        ctx.replacePathWithStrokedPath()
        ctx.clip()

        ctx.setFillColor(ring.innerRingColor.cgColor)

        ctx.restoreGState()

        if let knobStyle = ring.valueKnobStyle, value > minValue {
            let knobOffset = knobStyle.size / 2
            drawValueKnob(in: ctx, origin: CGPoint(x: innerPath.currentPoint.x - knobOffset,
                                                   y: innerPath.currentPoint.y - knobOffset))
        }
    }

    /// Updates the outer ring path depending on the ring's style
    private func updateOuterRingPath(_ path: UIBezierPath, radius: CGFloat, style: UICircularRingStyle) {
        switch style {
        case .dashed(let pattern):
            path.setLineDash(pattern, count: pattern.count, phase: 0.0)

        case .dotted:
            path.setLineDash([0, path.lineWidth * 2], count: 2, phase: 0)
            path.lineCapStyle = .round

        case .bordered(let borderWidth, let borderColor):
            let center: CGPoint = CGPoint(x: bounds.midX, y: bounds.midY)
            let knobSize = valueKnobStyle?.size ?? 0
            let offSet = max(ring.outerRingWidth, ring.innerRingWidth) / 2
                + knobSize / 4
                + borderWidth * 2
            let outerRadius: CGFloat = min(bounds.width, bounds.height) / 2 - offSet
            let borderStartAngle = ring.outerCapStyle == .butt ? ring.startAngle - borderWidth : ring.startAngle
            let borderEndAngle = ring.outerCapStyle == .butt ? ring.endAngle + borderWidth : ring.endAngle
            let start: CGFloat = ring.fullCircle ? 0 : borderStartAngle.rads
            let end: CGFloat = ring.fullCircle ? .pi * 2 : borderEndAngle.rads
            let borderPath = UIBezierPath(arcCenter: center,
                                          radius: outerRadius + borderWidth,
                                          startAngle: start,
                                          endAngle: end,
                                          clockwise: true)
            UIColor.clear.setFill()
            borderPath.fill()
            borderPath.lineWidth = (borderWidth * 2) + ring.outerRingWidth
            borderPath.lineCapStyle = ring.outerCapStyle
            borderColor.setStroke()
            borderPath.stroke()
        default:
            break
        }
    }

    /// Returns the end angle of the inner ring
    private func calculateInnerEndAngle() -> CGFloat {
        let innerEndAngle: CGFloat

        if ring.fullCircle {
            if !ring.isClockwise {
                innerEndAngle = ring.startAngle - ((value - minValue) / (maxValue - minValue) * 360.0)
            } else {
                innerEndAngle = (value - minValue) / (maxValue - minValue) * 360.0 + ring.startAngle
            }
        } else {
            // Calculate the center difference between the end and start angle
            let angleDiff: CGFloat = (ring.startAngle > ring.endAngle) ? (360.0 - ring.startAngle + ring.endAngle) : (ring.endAngle - ring.startAngle)
            // Calculate how much we should draw depending on the value set
            if !ring.isClockwise {
                innerEndAngle = ring.startAngle - ((value - minValue) / (maxValue - minValue) * angleDiff)
            } else {
                innerEndAngle = (value - minValue) / (maxValue - minValue) * angleDiff + ring.startAngle
            }
        }

        return innerEndAngle
    }

    /// Returns the raidus of the inner ring
    private func calculateInnerRadius() -> CGFloat {
        // The radius for style 1 is set below
        // The radius for style 1 is a bit less than the outer,
        // this way it looks like its inside the circle
        let radiusIn: CGFloat

        let knobSize = ring.valueKnobStyle?.size ?? 0

        switch ring.style {
        case .inside:
            let difference = ring.outerRingWidth * 2 + ring.innerRingSpacing + knobSize / 2
            let offSet = ring.innerRingWidth / 2 + knobSize / 2
            radiusIn = (min(bounds.width - difference, bounds.height - difference) / 2) - offSet
        case .bordered(let borderWidth, _):
            let offSet = (max(ring.outerRingWidth, ring.innerRingWidth) / 2) + (knobSize / 4) + (borderWidth * 2)
            radiusIn = (min(bounds.width, bounds.height) / 2) - offSet + borderWidth
        default:
            let offSet = (max(ring.outerRingWidth, ring.innerRingWidth) / 2) + (knobSize / 4)
            radiusIn = (min(bounds.width, bounds.height) / 2) - offSet
        }

        return radiusIn
    }

    /**
     Draws a gradient with a start and end position inside the provided context
     */
    private func drawGradient(_ gradient: CGGradient,
                              start: UICircularRingGradientPosition,
                              end: UICircularRingGradientPosition,
                              in context: CGContext) {


        context.drawLinearGradient(gradient,
                                   start: start.pointForPosition(in: bounds),
                                   end: end.pointForPosition(in: bounds),
                                   options: .drawsBeforeStartLocation)
    }

    /**
     Draws the value knob inside the provided context
     */
    private func drawValueKnob(in context: CGContext, origin: CGPoint) {
        guard let knobStyle = ring.valueKnobStyle else { return }

        context.saveGState()

        let rect = CGRect(origin: origin, size: CGSize(width: knobStyle.size, height: knobStyle.size))
        let knobPath = UIBezierPath(ovalIn: rect)

        context.setShadow(offset: knobStyle.shadowOffset,
                          blur: knobStyle.shadowBlur,
                          color: knobStyle.shadowColor.cgColor)
        context.addPath(knobPath.cgPath)
        context.setFillColor(knobStyle.color.cgColor)
        context.setLineCap(.round)
        context.setLineWidth(12)
        context.drawPath(using: .fill)

        context.restoreGState()
    }

    /**
     Draws the value label for the view.
     Only drawn if shouldShowValueText = true
     */
    func drawValueLabel() {
        if let innerText = ring.innerCenterText {
            updateValueLabel(innerText)
        }
        guard ring.shouldShowValueText else { return }
        updateValueLabel(valueFormatter?.string(for: value))
    }

    func updateValueLabel(_ text: String?) {
        // Draws the text field
        // Some basic label properties are set
        valueLabel.font = ring.font
        valueLabel.textAlignment = .center
        valueLabel.textColor = ring.fontColor

        valueLabel.text = text
        ring.willDisplayLabel(label: valueLabel)
        valueLabel.sizeToFit()

        // Deterime what should be the center for the label
        valueLabel.center = CGPoint(x: bounds.midX, y: bounds.midY)
        valueLabel.drawText(in: bounds)
    }
}

// MARK: UICircularTimerRing
final class UICircularTimerRing: UICircularRing {

    var valueFormatter: UICircularRingValueFormatter = UICircularTimerRingFormatter() {
        didSet { ringLayer.valueFormatter = valueFormatter }
    }

    /**
     The handler for the timer.

     The handler is called whenever the timer finishes or is paused.
     If the timer is paused handler will be called with (false, elapsedTime)
     Otherwise the handler will be called with (true, finalTime)
     */
    typealias TimerHandler = (State) -> Void

    // MARK: Private Members

    /// This is the max value for the layer, which corresponds
    /// to the time that was set for the timer
    private var time: TimeInterval = 60

    /// the elapsed time since calling `startTimer`
    private var elapsedTime: TimeInterval? {
        return layer.presentation()?.value(forKey: .value) as? TimeInterval
    }

    /// the completion for over all timer
    private var timerHandler: TimerHandler?

    // MARK: API

    /**
     Starts the timer until the given time is elapsed.

     Parameters:
     - startTime: the time at which the timer will begin, default is 0.
     - endtime: the time at which the timer will end, the animation duration will be `endTime - startTime`.
     - handler: the handler which is called and updated depending on the state of the timer.
     */
    func startTimer(from startTime: TimeInterval = 0.0, to endTime: TimeInterval, handler: TimerHandler?) {
        // begin animation to start time, this should be done instantly thus 0 duration
        startAnimation(duration: 0) {
            // begin animation to end time, this is done with difference in endTime and startTime
            self.startAnimation(duration: endTime - startTime) {
                self.timerHandler?(.finished)
            }

            // this will cause the animation to the end time value
            self.ringLayer.value = endTime.float
            self.ringLayer.maxValue = endTime.float
        }

        // this causes the animation to the start time
        ringLayer.value = startTime.float
        ringLayer.maxValue = endTime.float

        // store time and handler
        time = endTime
        timerHandler = handler
    }

    /**
     Pauses the timer.

     Handler will be called with (false, elapsedTime)
     */
    func pauseTimer() {
        timerHandler?(.paused(elpasedTime: elapsedTime))
        pauseAnimation()
    }

    /**
     Continues the timer from a previously paused time.
     */
    func continueTimer() {
        self.timerHandler?(.continued(elapsedTime: elapsedTime))
        continueAnimation {
            self.timerHandler?(.finished)
        }
    }

    /**
     Resets the timer, this means the time is reset and
     previously set handler will no longer be used.
     */
    func resetTimer() {
        resetAnimation()
        ringLayer.value = 0
        timerHandler = nil
    }

    // MARK: Overrides

    /// initialize with some defaults relevant to this timer ring
    override func initialize() {
        super.initialize()
        ringLayer.ring = self
        ringLayer.minValue = 0
        ringLayer.value = 0
        ringLayer.maxValue = time.float
        ringLayer.valueFormatter = valueFormatter
        ringLayer.animationTimingFunction = .linear
    }
}

// MARK: UICircularTimerRing.State
// codebeat:disable[TOO_MANY_IVARS,TOO_MANY_FUNCTIONS,LOC,ABC,ARITY,CYCLO,TOTAL_COMPLEXITY,TOTAL_LOC]
extension UICircularTimerRing {
    /// state of the timer ring, used in handler
    enum State {
        /// the timer has finished
        case finished

        /// the timer was continued called `continueTimer`
        case continued(elapsedTime: TimeInterval?)

        /// the timer was paused called `pauseTimer`
        case paused(elpasedTime: TimeInterval?)
    }
}

// MARK: UICircularRingStyle
internal enum UICircularRingStyle {
    /// inner ring is inside the circle
    case inside
    /// inner ring is placed ontop of the outer ring
    case ontop
    /// outer ring is dashed, the pattern list is how the dashes should appear
    case dashed(pattern: [CGFloat])
    /// outer ring is dotted
    case dotted
    /// inner ring is placed ontop of the outer ring and outer ring has border
    case bordered(width: CGFloat, color: UIColor)
}

// codebeat:disable[TOO_MANY_IVARS,TOO_MANY_FUNCTIONS,LOC,ABC,ARITY,CYCLO,TOTAL_COMPLEXITY,TOTAL_LOC]
struct UICircularRingValueKnobStyle {
    /// default implmementation of the knob style
    static let `default` = UICircularRingValueKnobStyle(size: 15.0, color: .lightGray)
    /// the size of the knob
    let size: CGFloat
    /// the color of the knob
    let color: UIColor
    /// the amount of blur to give the shadow
    let shadowBlur: CGFloat
    /// the offset to give the shadow
    let shadowOffset: CGSize
    /// the color for the shadow
    let shadowColor: UIColor
    /// creates a new `UICircularRingValueKnobStyle`
    init(size: CGFloat,
                color: UIColor,
                shadowBlur: CGFloat = 2.0,
                shadowOffset: CGSize = .zero,
                shadowColor: UIColor = UIColor.black.withAlphaComponent(0.8)) {
        self.size = size
        self.color = color
        self.shadowBlur = shadowBlur
        self.shadowOffset = shadowOffset
        self.shadowColor = shadowColor
    }
}

// MARK: UICircularRingGradientPosition
internal enum UICircularRingGradientPosition {
    /// Gradient positioned at the top
    case top
    /// Gradient positioned at the bottom
    case bottom
    /// Gradient positioned to the left
    case left
    /// Gradient positioned to the right
    case right
    /// Gradient positioned in the top left corner
    case topLeft
    /// Gradient positioned in the top right corner
    case topRight
    /// Gradient positioned in the bottom left corner
    case bottomLeft
    /// Gradient positioned in the bottom right corner
    case bottomRight

    /**
     Returns a `CGPoint` in the coordinates space of the passed in `CGRect`
     for the specified position of the gradient.
     */
    func pointForPosition(in rect: CGRect) -> CGPoint {
        switch self {
        case .top:
            return CGPoint(x: rect.midX, y: rect.minY)
        case .bottom:
            return CGPoint(x: rect.midX, y: rect.maxY)
        case .left:
            return CGPoint(x: rect.minX, y: rect.midY)
        case .right:
            return CGPoint(x: rect.maxX, y: rect.midY)
        case .topLeft:
            return CGPoint(x: rect.minX, y: rect.minY)
        case .topRight:
            return CGPoint(x: rect.maxX, y: rect.minY)
        case .bottomLeft:
            return CGPoint(x: rect.minX, y: rect.maxY)
        case .bottomRight:
            return CGPoint(x: rect.maxX, y: rect.maxY)
        }
    }
}

// MARK: UICircularRingValueFormatter
/**
 UICircularRingValueFormatter

 Any custom formatter must conform to this protocol.

 */
protocol UICircularRingValueFormatter {
    /// returns a string for the given object
    func string(for value: Any) -> String?
}

// MARK: UICircularTimerRingFormatter
/**
 UICircularTimerRingFormatter

 The formatter used in UICircularTimerRing class, formats
 the ring value into a time string.
 */
// codebeat:disable[TOO_MANY_IVARS,TOO_MANY_FUNCTIONS,LOC,ABC,ARITY,CYCLO,TOTAL_COMPLEXITY,TOTAL_LOC]
struct UICircularTimerRingFormatter: UICircularRingValueFormatter {
    // MARK: Members
    /// defines the units allowed to be used when converting string, by default `[.minute, .second]`
    var units: NSCalendar.Unit {
        didSet { formatter.allowedUnits = units }
    }
    /// the style of the formatted string, by default `.short`
    var style: DateComponentsFormatter.UnitsStyle {
        didSet { formatter.unitsStyle = style }
    }
    /// formatter which formats the time string of the ring label
    private var formatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = units
        formatter.unitsStyle = style
        return formatter
    }

    // MARK: Init
    init(units: NSCalendar.Unit = [.minute, .second],
                style: DateComponentsFormatter.UnitsStyle = .short) {
        self.units = units
        self.style = style
    }

    // MARK: API
    /// formats the value of the ring using the date components formatter with given units/style
    func string(for value: Any) -> String? {
        guard let value = value as? CGFloat else { return nil }
        return formatter.string(from: value.interval)
    }
}

// MARK: UICircularProgressRingFormatter
/**
 UICircularProgressRingFormatter

 The formatter used in UICircularProgressRing class,
 responsible for formatting the value of the ring into a readable string
 */
// codebeat:disable[TOO_MANY_IVARS,TOO_MANY_FUNCTIONS,LOC,ABC,ARITY,CYCLO,TOTAL_COMPLEXITY,TOTAL_LOC]
struct UICircularProgressRingFormatter: UICircularRingValueFormatter {
    // MARK: Members
    /**
     The name of the value indicator the value label will
     appened to the value
     Example: " GB" -> "100 GB"

     ## Important ##
     Default = "%"

     ## Author
     Luis Padron
     */
    var valueIndicator: String

    /**
     A toggle for either placing the value indicator right or left to the value
     Example: true -> "GB 100" (instead of 100 GB)

     ## Important ##
     Default = false (place value indicator to the right)

     ## Author
     Elad Hayun
     */
    var rightToLeft: Bool

    /**
     A toggle for showing or hiding floating points from
     the value in the value label

     ## Important ##
     Default = false (dont show)

     To customize number of decmial places to show, assign a value to decimalPlaces.

     ## Author
     Luis Padron
     */
    var showFloatingPoint: Bool

    /**
     The amount of decimal places to show in the value label

     ## Important ##
     Default = 2

     Only used when showFloatingPoint = true

     ## Author
     Luis Padron
     */
    var decimalPlaces: Int

    // MARK: Init
    init(valueIndicator: String = "%",
                rightToLeft: Bool = false,
                showFloatingPoint: Bool = false,
                decimalPlaces: Int = 2) {
        self.valueIndicator = valueIndicator
        self.rightToLeft = rightToLeft
        self.showFloatingPoint = showFloatingPoint
        self.decimalPlaces = decimalPlaces
    }

    // MARK: API
    /// formats the value of the progress ring using the given properties
    func string(for value: Any) -> String? {
        guard let value = value as? CGFloat else { return nil }

        if rightToLeft {
            if showFloatingPoint {
                return "\(valueIndicator)" + String(format: "%.\(decimalPlaces)f", value)
            } else {
                return "\(valueIndicator)\(Int(value))"
            }

        } else {
            if showFloatingPoint {
                return String(format: "%.\(decimalPlaces)f", value) + "\(valueIndicator)"
            } else {
                return "\(Int(value))\(valueIndicator)"
            }
        }
    }
}
