-- Generated from ChapterNavierStokesFockCanonical.lean — solution of BookProof.NavierStokesFlow.FockCanonical.fock_hamiltonian_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesFockCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_FockCanonical_mode_hamiltonian_eq
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockCanonical



open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian FockManyMode HermiteCanonical

variable {d : ℕ} {κ : Fin d → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hκ : ∀ i, 0 ≤ κ i) :
    (lpFiniteModes (Occ d)).subtype.comp
        (∑ i, ((1 : ℂ) / 2) • ((mom κ i).comp (drift κ i) + (drift κ i).comp (mom κ i)))
      = (fockH hκ).comp (Submodule.inclusion (finiteModes_le_maxDom (fockSym κ))) := by

  refine LinearMap.ext fun x => lp.ext (funext fun β => ?_)
  have hmode : ∀ i : Fin d,
      (((((1 : ℂ) / 2) • ((mom κ i).comp (drift κ i) + (drift κ i).comp (mom κ i)) x :
          lpFiniteModes (Occ d)) : L2I (Occ d)) : Occ d → ℂ) β
        = ((ShiftData.shiftH (modeData hκ i)
            (Submodule.inclusion (finiteModes_le_maxDom (fockSym κ)) x) :
              L2I (Occ d)) : Occ d → ℂ) β := by
    intro i
    have h := congrFun (congrArg (fun v : L2I (Occ d) => (v : Occ d → ℂ))
      (congrFun (congrArg (fun T : lpFiniteModes (Occ d) →ₗ[ℂ] L2I (Occ d) =>
        (T : lpFiniteModes (Occ d) → L2I (Occ d))) (mode_hamiltonian_eq hκ i)) x)) β
    exact h
  have hsumleft : ((((∑ i, ((1 : ℂ) / 2) •
        ((mom κ i).comp (drift κ i) + (drift κ i).comp (mom κ i))) x :
          lpFiniteModes (Occ d)) : L2I (Occ d)) : Occ d → ℂ) β
      = ∑ i, (((((1 : ℂ) / 2) • ((mom κ i).comp (drift κ i) + (drift κ i).comp (mom κ i)) x :
          lpFiniteModes (Occ d)) : L2I (Occ d)) : Occ d → ℂ) β := by
    rw [LinearMap.sum_apply]
    induction (Finset.univ : Finset (Fin d)) using Finset.induction with
    | empty => simp
    | insert i s hi ih =>
        rw [Finset.sum_insert hi, Finset.sum_insert hi, ← ih]
        rfl
  have hsumright : ((fockH hκ (Submodule.inclusion (finiteModes_le_maxDom (fockSym κ)) x) :
        L2I (Occ d)) : Occ d → ℂ) β
      = ∑ i, ((ShiftData.shiftH (modeData hκ i)
          (Submodule.inclusion (finiteModes_le_maxDom (fockSym κ)) x) :
            L2I (Occ d)) : Occ d → ℂ) β := by
    rw [fockH_apply]
    induction (Finset.univ : Finset (Fin d)) using Finset.induction with
    | empty => simp
    | insert i s hi ih =>
        rw [Finset.sum_insert hi, Finset.sum_insert hi, ← ih]
        rfl
  simp only [LinearMap.comp_apply, Submodule.subtype_apply]
  rw [hsumleft, hsumright]
  exact Finset.sum_congr rfl fun i _ => hmode i
