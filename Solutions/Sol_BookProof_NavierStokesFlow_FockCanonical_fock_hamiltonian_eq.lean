-- Generated from ChapterNavierStokesFockCanonical.lean — solution of BookProof.NavierStokesFlow.FockCanonical.fock_hamiltonian_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesFockCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_FockCanonical_mode_hamiltonian_eq
import Theorems.Thm_BookProof_NavierStokesFlow_FockManyMode_fockH_apply
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockCanonical



open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian FockManyMode HermiteCanonical

variable {d : ℕ} {κ : Fin d → ℝ}

variable {d : ℕ} {κ : Fin d → ℝ}

set_option maxHeartbeats 1000000 in
 i := h
      push_cast [Nat.cast_sub h2]
      ring
    rw [hc1, hc2]
    push_cast
    change (1 / 2 * (Complex.I * ↑(κ i) * (↑(Real.sqrt ↑(β i)) * ↑(Real.sqrt (↑(β i) - 1))
      * ((x : L2I (Occ d)) : Occ d → ℂ) (dn i (dn i β))
      - ↑(Real.sqrt (↑(β i) + 1)) * ↑(Real.sqrt (↑(β i) + 2))
        * ((x : L2I (Occ d)) : Occ d → ℂ) (modeShift i β)))) =
      (Complex.I * (↑(κ i) / 2 * ↑(Real.sqrt (↑(β i) - 1)) * :=
   ↑(Real.sqrt ↑(β i))
          * ((x : L2I (Occ d)) : Occ d → ℂ) (dn i (dn i β))
          - ↑(κ i) / 2 * ↑(Real.sqrt (↑(β i) + 1)) * ↑(Real.sqrt (↑(β i) + 2))
            * ((x : L2I (Occ d)) : Occ d → ℂ) (modeShift i β)))
      ring
    · rw [if_neg h, cre_cre_coe_of_lt i x (by omega)]
      push_cast
      change (1 / 2 * (Complex.I * ↑(κ i) * (0 - ↑(Real.sqrt (↑(β i) + 1)) * ↑(Real.sqrt (↑(β i) + 2))
        * ((x : L2I (Occ d)) : Occ d → ℂ) (modeShift i β)))) =
        (Complex.I * (0 - ↑(κ i) / 2 * ↑(Real.sqrt (↑(β i) + 1)) * ↑(Real.sqrt (↑(β i) + 2))
          * ((x : L2I (Occ d)) : Occ d → ℂ) (modeShift i β)))
      ring
  
  /-- **`∑ᵢ ½(πᵢVᵢ + Vᵢπᵢ) = Ĥ`**: the many-mode Navier–Stokes Hamiltonian of the
  Fock space is the sum over the modes of the symmetrised transport operators. -/
  theorem fock_hamiltonian_eq (hκ : ∀ i, 0 ≤ κ i) :
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
          ((mom κ i).comp (drift κ i) + (drift κ i).comp (mom κ
