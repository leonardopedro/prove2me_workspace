-- Generated from ChapterNavierStokesFockCanonical.lean — solution of BookProof.NavierStokesFlow.FockCanonical.mode_hamiltonian_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesFockCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_FockCanonical_dn_dn_self
import Theorems.Thm_BookProof_NavierStokesFlow_FockCanonical_ann_ann_coe
import Theorems.Thm_BookProof_NavierStokesFlow_FockCanonical_cre_cre_coe_of_two_le
import Theorems.Thm_BookProof_NavierStokesFlow_FockCanonical_cre_cre_coe_of_lt
import Theorems.Thm_BookProof_NavierStokesFlow_FockCanonical_anti_DS
import Theorems.Thm_BookProof_NavierStokesFlow_FockCanonical_sqrt_half_sq
import Theorems.Thm_BookProof_NavierStokesFlow_FockCanonical_hop_modeData_eq
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockCanonical



open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian FockManyMode HermiteCanonical

variable {d : ℕ} {κ : Fin d → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hκ : ∀ i, 0 ≤ κ i) (i : Fin d) :
    (lpFiniteModes (Occ d)).subtype.comp
        (((1 : ℂ) / 2) • ((mom κ i).comp (drift κ i) + (drift κ i).comp (mom κ i)))
      = (ShiftData.shiftH (modeData hκ i)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (fockSym κ))) := by

  have hsym : (mom κ i).comp (drift κ i) + (drift κ i).comp (mom κ i)
      = (Complex.I * (κ i : ℂ)) • ((cre i).comp (cre i) - (ann i).comp (ann i)) := by
    have h1 : (mom κ i).comp (drift κ i)
        = (Complex.I * ((Real.sqrt (κ i / 2) : ℂ) * (Real.sqrt (κ i / 2) : ℂ))) •
          (cre i - ann i).comp (cre i + ann i) := by
      simp only [mom, drift, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul]
      congr 1
      ring
    have h2 : (drift κ i).comp (mom κ i)
        = (Complex.I * ((Real.sqrt (κ i / 2) : ℂ) * (Real.sqrt (κ i / 2) : ℂ))) •
          (cre i + ann i).comp (cre i - ann i) := by
      simp only [mom, drift, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul]
      congr 1
      ring
    rw [h1, h2, ← smul_add, anti_DS i, sqrt_half_sq i (hκ i), smul_smul]
    congr 1
    ring
  refine LinearMap.ext fun x => lp.ext (funext fun β => ?_)
  simp only [LinearMap.comp_apply, hsym, Submodule.subtype_apply, LinearMap.smul_apply,
    Submodule.coe_smul, lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, LinearMap.sub_apply,
    Submodule.coe_sub, lp.coeFn_sub, Pi.sub_apply, ShiftData.shiftH_coe,
    Submodule.inclusion_apply]
  rw [ShiftData.hFun, hop_modeData_eq hκ i, ann_ann_coe]
  have hamp : ∀ γ : Occ d, ((modeData hκ i).amp γ : ℂ)
      = ((κ i / 2 : ℝ) : ℂ) * (Real.sqrt ((γ i : ℝ) + 1) : ℂ)
        * (Real.sqrt ((γ i : ℝ) + 2) : ℂ) := by
    intro γ
    have : (modeData hκ i).amp γ = modeAmp κ i γ := rfl
    rw [this, modeAmp, Real.sqrt_mul (by positivity)]
    push_cast
    ring
  have hshift : (modeData hκ i).shift β = modeShift i β := rfl
  rw [hshift, hamp β]
  by_cases h : 2 ≤ β i
  · rw [if_pos h, cre_cre_coe_of_two_le i x h, hamp (dn i (dn i β)), dn_dn_self]
    have hc1 : (((β i - 2 : ℕ) : ℝ) + 1) = (β i : ℝ) - 1 := by
      have h2 : (2 : ℕ) ≤ β i := h
      push_cast [Nat.cast_sub h2]
      ring
    have hc2 : (((β i - 2 : ℕ) : ℝ) + 2) = (β i : ℝ) := by
      have h2 : (2 : ℕ) ≤ β i := h
      push_cast [Nat.cast_sub h2]
      ring
    rw [hc1, hc2]
    push_cast
    ring
  · rw [if_neg h, cre_cre_coe_of_lt i x (by omega)]
    push_cast
    ring
