-- Generated from ChapterNavierStokesHermiteCanonical.lean — solution of BookProof.NavierStokesFlow.HermiteCanonical.comm_mom_pos
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteCanonical_ann_cre_coe
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteCanonical_cre_ann_coe
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteCanonical_sqrt_half_mul_inv
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteCanonical








open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine
























variable {κ : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hκ : 0 < κ) :
    (mom κ).comp (pos κ) - (pos κ).comp (mom κ) = (-Complex.I) • LinearMap.id := by

  have hs : Complex.I * (Real.sqrt (κ / 2) : ℂ) * ((1 / Real.sqrt (2 * κ) : ℝ) : ℂ) * (-2)
      = -Complex.I := by
    linear_combination (-2 * Complex.I) * sqrt_half_mul_inv hκ
  refine LinearMap.ext fun x => Subtype.ext (lp.ext (funext fun n => ?_))
  simp only [LinearMap.sub_apply, LinearMap.comp_apply, mom, pos, LinearMap.smul_apply,
    LinearMap.id_apply, LinearMap.add_apply, map_smul, map_add, map_sub,
    Submodule.coe_sub, Submodule.coe_add, Submodule.coe_smul, lp.coeFn_sub, lp.coeFn_add,
    lp.coeFn_smul, Pi.sub_apply, Pi.add_apply, Pi.smul_apply, smul_eq_mul,
    ann_cre_coe, cre_ann_coe]
  linear_combination (((x : L2I ℕ) : ℕ → ℂ) n) * hs
