-- Generated from ChapterShannonSampling.lean — theorem BookProof.ChapterShannonSampling.bandSignal_eq_of_samples_eq
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling

variable {T : ℝ} [hT : Fact (0 < T)]



open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

theorem BookProof.ChapterShannonSampling.bandSignal_eq_of_samples_eq (F G : Lp ℂ 2 (haarAddCircle (T := T)))
    (h : ∀ n : ℤ, bandSignal (T := T) (F : AddCircle T → ℂ) (n / T)
      = bandSignal (T := T) (G : AddCircle T → ℂ) (n / T)) (x : ℝ) :
    bandSignal (T := T) (F : AddCircle T → ℂ) x
      = bandSignal (T := T) (G : AddCircle T → ℂ) x := by sorry
