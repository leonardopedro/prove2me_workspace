-- Generated from ChapterShannonSampling.lean — theorem BookProof.ChapterShannonSampling.continuous_bandSignal_lp
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling

variable {T : ℝ} [hT : Fact (0 < T)]



open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

theorem BookProof.ChapterShannonSampling.continuous_bandSignal_lp (F : Lp ℂ 2 (haarAddCircle (T := T))) :
    Continuous (bandSignal (T := T) (F : AddCircle T → ℂ)) := by sorry
