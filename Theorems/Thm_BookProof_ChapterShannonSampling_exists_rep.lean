-- Generated from ChapterShannonSampling.lean — theorem BookProof.ChapterShannonSampling.exists_rep
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling

variable {T : ℝ} [hT : Fact (0 < T)]



open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

theorem BookProof.ChapterShannonSampling.exists_rep (z : AddCircle T) :
    ∃ ξ : ℝ, ξ ∈ Ioc (-(T / 2)) (-(T / 2) + T) ∧ (ξ : AddCircle T) = z := by sorry
