-- Generated from ChapterNavierStokesFullEsa.lean — solution of BookProof.NavierStokesFlow.FullEsa.latticeFullHamiltonianCLM_ne_zero
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
import Theorems.Thm_BookProof_ChapterContinuityUnitaryInfinite_momentum_apply
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa



open scoped ENNReal

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable (d : NSFullData F)

set_option maxHeartbeats 1000000 in
theorem solution :
    latticeFullHamiltonianCLM (fun _ => constField 1) 1 ≠ 0 := by

  intro hzero
  have hsingle : ((lp.single 2 (0 : ℤ) (1 : ℂ) : L2Z) : ℤ → ℂ) = Pi.single 0 1 := by
    funext k
    simp [lp.single_apply]
  have h := congrArg (fun T : L2Z →L[ℂ] L2Z =>
    ((T (lp.single 2 (0 : ℤ) (1 : ℂ)) : L2Z) : ℤ → ℂ) (-1)) hzero
  simp only [latticeFullHamiltonianCLM, latticeAdvectionCLM,
    ContinuousLinearMap.add_apply, ContinuousLinearMap.sub_apply, ContinuousLinearMap.mul_apply,
    ContinuousLinearMap.smul_apply, ContinuousLinearMap.zero_apply,
    lp.coeFn_add, lp.coeFn_sub, lp.coeFn_smul, lp.coeFn_zero, Pi.add_apply,
    Pi.sub_apply, Pi.smul_apply, Pi.zero_apply, smul_eq_mul, Fin.sum_univ_three,
    momentum_apply, velocityOp_apply, constField_apply, hsingle] at h
  norm_num [Pi.single_apply] at h
  have h6 : (6 : ℂ) * Complex.I = 0 := by linear_combination -h
  rcases mul_eq_zero.mp h6 with h' | h'
  · norm_num at h'
  · exact Complex.I_ne_zero h'
