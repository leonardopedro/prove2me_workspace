-- Generated from ChapterShannonSampling.lean — solution of BookProof.ChapterShannonSampling.exists_rep
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling




open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

variable {T : ℝ} [hT : Fact (0 < T)]

set_option maxHeartbeats 1000000 in
theorem solution (z : AddCircle T) :
    ∃ ξ : ℝ, ξ ∈ Ioc (-(T / 2)) (-(T / 2) + T) ∧ (ξ : AddCircle T) = z :=
  ⟨(equivIoc T (-(T / 2)) z : ℝ), (equivIoc T (-(T / 2)) z).2, by
      conv_rhs => rw [← (equivIoc T (-(T / 2))).symm_apply_apply z]
      rfl⟩
