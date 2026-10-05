-- Generated from ChapterA2e.lean — solution of BookProof.ChapterA.transK_realCommutes
import Mathlib
import Definitions.Def_ChapterA2e
import Theorems.Thm_BookProof_ChapterA_exists_source_of_isRealSystemIso
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

set_option maxHeartbeats 1000000 in
theorem solution {M : System ℂ V} {N : System ℂ W}
    {β : V ≃ₗᵢ[ℝ] W} (hβ : IsRealSystemIso M N β) : RealCommutes N (transK β) := by

  intro n hn x
  obtain ⟨m, hm, hmeq⟩ := exists_source_of_isRealSystemIso hβ hn
  -- `n x = β (m (β⁻¹ x))`; `K` is `β ∘ (i·) ∘ β⁻¹`; use `m` is ℂ-linear.
  have hsym : β.symm (n x) = m (β.symm x) := by
    rw [hmeq x, LinearIsometryEquiv.symm_apply_apply]
  simp only [transK_apply]
  rw [hsym, hmeq (β (Complex.I • β.symm x)), LinearIsometryEquiv.symm_apply_apply, ← map_smul]
