-- Generated from ChapterShannonSampling.lean — theorem BookProof.ChapterShannonSampling.bandSignal_eq_inner
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling



open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

variable {T : ℝ} [hT : Fact (0 < T)]

theorem BookProof.ChapterShannonSampling.bandSignal_eq_inner (F : Lp ℂ 2 (haarAddCircle (T := T))) (x : ℝ) :
    bandSignal (T := T) (F : AddCircle T → ℂ) x
      = (T : ℂ) * inner ℂ (kernLp (T := T) x) F := by sorry
