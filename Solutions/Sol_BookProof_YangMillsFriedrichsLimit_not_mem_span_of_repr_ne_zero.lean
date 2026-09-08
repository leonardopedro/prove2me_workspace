-- Generated from ChapterYangMillsFriedrichsLimit.lean — solution of BookProof.YangMillsFriedrichsLimit.not_mem_span_of_repr_ne_zero
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichsLimit
open BookProof.YangMillsFriedrichsLimit









open BookProof.FarisLavine BookProof.YangMillsFriedrichs



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]











open scoped InnerProductSpace ENNReal

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F)
    (x : F) (hx : ∀ i, b.repr x i ≠ 0) : x ∉ Submodule.span ℂ (Set.range b) := by

  intro hmem
  obtain ⟨T, hTsub, hxT⟩ := Submodule.mem_span_finite_of_mem_span hmem
  have hinj : Function.Injective b := b.orthonormal.linearIndependent.injective
  have hfin : (b ⁻¹' (T : Set F)).Finite := (T.finite_toSet).preimage hinj.injOn
  obtain ⟨i, hi⟩ := hfin.infinite_compl.nonempty
  have hle : Submodule.span ℂ (T : Set F) ≤ LinearMap.ker (innerSL ℂ (b i)).toLinearMap := by
    refine Submodule.span_le.mpr ?_
    rintro y hy
    obtain ⟨j, rfl⟩ := hTsub hy
    have hji : j ≠ i := by
      rintro rfl
      exact hi hy
    simp only [SetLike.mem_coe, LinearMap.mem_ker, ContinuousLinearMap.coe_coe,
      innerSL_apply_apply]
    exact b.orthonormal.2 (Ne.symm hji)
  have h0 : (inner ℂ (b i) x : ℂ) = 0 := by simpa using hle hxT
  exact hx i (by rw [b.repr_apply_apply]; exact h0)
