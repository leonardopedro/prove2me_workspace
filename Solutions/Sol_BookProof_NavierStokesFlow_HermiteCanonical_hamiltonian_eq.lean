-- Generated from ChapterNavierStokesHermiteCanonical.lean — solution of BookProof.NavierStokesFlow.HermiteCanonical.hamiltonian_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteCanonical_ann_ann_coe
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteCanonical_cre_cre_coe_add_two
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteCanonical_cre_cre_coe_zero
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteCanonical_cre_cre_coe_one
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteCanonical_anti_DS
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteCanonical_sqrt_half_sq
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteCanonical_amp_eq_sqrt_mul
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteCanonical








open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine
























variable {κ : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hκ : 0 ≤ κ) :
    (lpFiniteModes ℕ).subtype.comp
        (((1 : ℂ) / 2) • ((mom κ).comp (drift κ) + (drift κ).comp (mom κ)))
      = (nsH κ hκ).comp (Submodule.inclusion (finiteModes_le_maxDom (oscSymbol κ))) := by

  have hsym : (mom κ).comp (drift κ) + (drift κ).comp (mom κ)
      = (Complex.I * (κ : ℂ)) • (cre.comp cre - ann.comp ann) := by
    have h1 : (mom κ).comp (drift κ)
        = (Complex.I * ((Real.sqrt (κ / 2) : ℂ) * (Real.sqrt (κ / 2) : ℂ))) •
          (cre - ann).comp (cre + ann) := by
      simp only [mom, drift, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul]
      congr 1
      ring
    have h2 : (drift κ).comp (mom κ)
        = (Complex.I * ((Real.sqrt (κ / 2) : ℂ) * (Real.sqrt (κ / 2) : ℂ))) •
          (cre + ann).comp (cre - ann) := by
      simp only [mom, drift, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul]
      congr 1
      ring
    rw [h1, h2, ← smul_add, anti_DS, sqrt_half_sq hκ, smul_smul]
    congr 1
    ring
  refine LinearMap.ext fun x => lp.ext (funext fun m => ?_)
  simp only [LinearMap.comp_apply, hsym, Submodule.subtype_apply, LinearMap.smul_apply,
    Submodule.coe_smul, lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, LinearMap.sub_apply,
    Submodule.coe_sub, lp.coeFn_sub, Pi.sub_apply, nsH_coe, Submodule.inclusion_apply]
  rw [hFun, ann_ann_coe]
  rcases Nat.lt_or_ge m 2 with hm | hm
  · interval_cases m
    · rw [cre_cre_coe_zero]
      simp only [shift2_zero_apply]
      rw [amp_eq_sqrt_mul]
      push_cast
      ring
    · rw [cre_cre_coe_one]
      simp only [shift2_one_apply]
      rw [amp_eq_sqrt_mul]
      push_cast
      ring
  · obtain ⟨k, rfl⟩ : ∃ k, m = k + 2 := ⟨m - 2, by omega⟩
    rw [cre_cre_coe_add_two, shift2_add_two, amp_eq_sqrt_mul, amp_eq_sqrt_mul]
    push_cast
    ring
