-- Generated from ChapterNavierStokesFockCanonical.lean — theorem BookProof.NavierStokesFlow.FockCanonical.fock_hamiltonian_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesFockCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockCanonical

variable {d : ℕ} {κ : Fin d → ℝ}


open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian FockManyMode HermiteCanonical

variable {d : ℕ} {κ : Fin d → ℝ}

 i := h
      push_cast [Nat.cast_sub h2]
      ring
    rw [hc1, hc2]
    push_cast
    change (1 / 2 * (Complex.I * ↑(κ i) * (↑(Real.sqrt ↑(β i)) * ↑(Real.sqrt (↑(β i) - 1))
      * ((x : L2I (Occ d)) : Occ d → ℂ) (dn i (dn i β))
      - ↑(Real.sqrt (↑(β i) + 1)) * ↑(Real.sqrt (↑(β i) + 2))
        * ((x : L2I (Occ d)) : Occ d → ℂ) (modeShift i β)))) =
      (Complex.I * (↑(κ i) / 2 * ↑(Real.sqrt (↑(β i) - 1)) * := by sorry
