-- Generated from ChapterShannonSampling.lean — theorem BookProof.ChapterShannonSampling.hasSum_sq_samples
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling



open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

variable {T : ℝ} [hT : Fact (0 < T)]

theorem BookProof.ChapterShannonSampling.hasSum_sq_samples (F : Lp ℂ 2 (haarAddCircle (T := T))) :
    HasSum (fun n : ℤ => ‖bandSignal (T := T) (F : AddCircle T → ℂ) (n / T)‖ ^ 2)
      (T * ∫ ξ in (-(T / 2))..(-(T / 2) + T), ‖(F : AddCircle T → ℂ) ξ‖ ^ 2) := by sorry
