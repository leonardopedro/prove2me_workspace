-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.ae_eq_zero_of_moments
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

theorem BookProof.HermiteCore.ae_eq_zero_of_moments {u : ℝ → ℂ} (hu : MemLp u 2 (volume : Measure ℝ))
    (hmom : ∀ k : ℕ, ∫ x : ℝ, ((x ^ k * gaussH x : ℝ) : ℂ) * u x = 0) :
    ∀ᵐ x : ℝ, u x = 0 := by sorry
