-- Generated from ChapterG2.lean — 
theorem BookProof.ChapterG2.integral_haarAverage [MeasurableSpace X] [MeasurableSMul G X]
    [MeasurableMul G]
    (μ : Measure X) [IsProbabilityMeasure μ]
    (hμ : ∀ g : G, MeasurePreserving (fun x : X => g • x) μ μ)
    (f : X → ℝ)
    (hint : Integrable (fun p : G × X => f (p.1⁻¹ • p.2)) (μG.prod μ)) :
    ∫ x, haarAverage (μG := μG) f x ∂μ = ∫ x, f x ∂μ := by sorry
