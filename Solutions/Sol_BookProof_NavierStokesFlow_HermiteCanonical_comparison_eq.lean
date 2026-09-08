-- Generated from ChapterNavierStokesHermiteCanonical.lean — solution of BookProof.NavierStokesFlow.HermiteCanonical.comparison_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteCanonical_ann_cre_coe
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteCanonical_cre_ann_coe
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteCanonical_sq_diff
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteCanonical_sqrt_half_sq
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteCanonical








open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine
























variable {κ : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hκ : 0 ≤ κ) :
    (lpFiniteModes ℕ).subtype.comp
        ((mom κ).comp (mom κ) + (drift κ).comp (drift κ) + LinearMap.id)
      = (diagMax (oscSymbol κ)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (oscSymbol κ))) := by

  have hsq : (mom κ).comp (mom κ) + (drift κ).comp (drift κ)
      = (κ : ℂ) • (cre.comp ann + ann.comp cre) := by
    have h1 : (mom κ).comp (mom κ)
        = (-((Real.sqrt (κ / 2) : ℂ) * (Real.sqrt (κ / 2) : ℂ))) •
          (cre - ann).comp (cre - ann) := by
      simp only [mom, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul]
      congr 1
      have : Complex.I * Complex.I = -1 := Complex.I_mul_I
      ring_nf
      rw [Complex.I_sq]
      ring
    have h2 : (drift κ).comp (drift κ)
        = ((Real.sqrt (κ / 2) : ℂ) * (Real.sqrt (κ / 2) : ℂ)) • (cre + ann).comp (cre + ann) := by
      simp only [drift, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul]
    have hexp : (cre + ann).comp (cre + ann)
        = (cre - ann).comp (cre - ann) + (2 : ℂ) • (cre.comp ann + ann.comp cre) := by
      rw [← sq_diff]
      abel
    rw [h1, h2, sqrt_half_sq hκ, hexp]
    module
  refine LinearMap.ext fun x => lp.ext (funext fun n => ?_)
  simp only [LinearMap.comp_apply, LinearMap.add_apply, hsq, Submodule.subtype_apply,
    LinearMap.smul_apply, LinearMap.id_apply, Submodule.coe_add, Submodule.coe_smul,
    lp.coeFn_add, lp.coeFn_smul, Pi.add_apply, Pi.smul_apply, smul_eq_mul, diagMax_coe,
    ann_cre_coe, cre_ann_coe, Submodule.inclusion_apply]
  simp only [oscSymbol]
  push_cast
  ring
