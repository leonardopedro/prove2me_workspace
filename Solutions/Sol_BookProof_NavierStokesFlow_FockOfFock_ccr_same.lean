-- Generated from ChapterNavierStokesFockSpace.lean — solution of BookProof.NavierStokesFlow.FockOfFock.ccr_same
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_add_single_sub_single
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock









open FullEsa



variable {ι : Type*}














variable {ι : Type*}











variable {M : Type*} [DecidableEq M]

set_option maxHeartbeats 1000000 in
theorem solution (m : M) :
    (annih m).comp (creat m) - (creat m).comp (annih m)
      = LinearMap.id (R := ℂ) (M := FockDom M) := by

  ext f n
  simp only [LinearMap.sub_apply, LinearMap.comp_apply, LinearMap.id_apply,
    Submodule.coe_sub, Pi.sub_apply, annih_coe, creat_coe, lp.coeFn_sub]
  have h1 : ((n + Finsupp.single m 1 : Conf M) m : ℝ) = (n m : ℝ) + 1 := by push_cast; simp
  have h2 : (n + Finsupp.single m 1 : Conf M) - Finsupp.single m 1 = n :=
    add_single_sub_single m n
  rw [h1, h2]
  rcases Nat.eq_zero_or_pos (n m) with h | h
  · simp [h]
  · have h3 : ((n - Finsupp.single m 1 : Conf M) m : ℝ) + 1 = (n m : ℝ) := by
      have : (n - Finsupp.single m 1 : Conf M) m = n m - 1 := by simp
      rw [this]
      have : (1 : ℕ) ≤ n m := h
      push_cast [Nat.cast_sub this]
      ring
    have h4 : (n - Finsupp.single m 1 : Conf M) + Finsupp.single m 1 = n :=
      sub_single_add_single h
    rw [h3, h4]
    have hsq : (Real.sqrt ((n m : ℝ) + 1) : ℂ) * (Real.sqrt ((n m : ℝ) + 1) : ℂ)
        = ((n m : ℝ) + 1 : ℝ) := by
      rw [← Complex.ofReal_mul, Real.mul_self_sqrt (by positivity)]
    have hsq2 : (Real.sqrt (n m : ℝ) : ℂ) * (Real.sqrt (n m : ℝ) : ℂ) = ((n m : ℝ) : ℝ) := by
      rw [← Complex.ofReal_mul, Real.mul_self_sqrt (by positivity)]
    have hexp : ∀ z : ℂ, (Real.sqrt ((n m : ℝ) + 1) : ℂ) * ((Real.sqrt ((n m : ℝ) + 1) : ℂ) * z)
        - (Real.sqrt (n m : ℝ) : ℂ) * ((Real.sqrt (n m : ℝ) : ℂ) * z) = z := by
      intro z
      rw [← mul_assoc, ← mul_assoc, hsq, hsq2]
      push_cast
      ring
    exact hexp _
