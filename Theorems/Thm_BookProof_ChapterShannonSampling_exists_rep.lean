-- Generated from ChapterShannonSampling.lean — theorem BookProof.ChapterShannonSampling.exists_rep
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling



open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

variable {T : ℝ} [hT : Fact (0 < T)]

theorem BookProof.ChapterShannonSampling.exists_rep (z : AddCircle T) :
    ∃ ξ : ℝ, ξ ∈ Ioc (-(T / 2)) (-(T / 2) + T) ∧ (ξ : AddCircle T) = z := by sorry
