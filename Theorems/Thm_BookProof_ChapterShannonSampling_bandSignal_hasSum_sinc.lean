-- Generated from ChapterShannonSampling.lean — theorem BookProof.ChapterShannonSampling.bandSignal_hasSum_sinc
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling

variable {T : ℝ} [hT : Fact (0 < T)]



open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

theorem BookProof.ChapterShannonSampling.bandSignal_hasSum_sinc (F : Lp ℂ 2 (haarAddCircle (T := T))) (x : ℝ) :
    HasSum (fun n : ℤ =>
        bandSignal (T := T) (F : AddCircle T → ℂ) (n / T) * (sinc (T * x - n) : ℝ))
      (bandSignal (T := T) (F : AddCircle T → ℂ) x) := by sorry
