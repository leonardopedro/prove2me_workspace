-- Generated from ChapterShannonSampling.lean — theorem BookProof.ChapterShannonSampling.inner_kernLp_apply
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling



open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

variable {T : ℝ} [hT : Fact (0 < T)]

theorem BookProof.ChapterShannonSampling.inner_kernLp_apply (F : Lp ℂ 2 (haarAddCircle (T := T))) (x : ℝ) :
    inner ℂ (kernLp (T := T) x) F
      = ∫ z : AddCircle T, conj (kern (T := T) x z) * F z ∂haarAddCircle := by sorry
