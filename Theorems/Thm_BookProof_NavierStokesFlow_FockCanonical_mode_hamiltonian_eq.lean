-- Generated from ChapterNavierStokesFockCanonical.lean — theorem BookProof.NavierStokesFlow.FockCanonical.mode_hamiltonian_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesFockCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockCanonical







open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.ShiftHamiltonian BookProof.NavierStokesFlow.FockManyMode BookProof.NavierStokesFlow.HermiteCanonical

variable {d : ℕ} {κ : Fin d → ℝ}

theorem BookProof.NavierStokesFlow.FockCanonical.mode_hamiltonian_eq (hκ : ∀ i, 0 ≤ κ i) (i : Fin d) :
    (lpFiniteModes (Occ d)).subtype.comp
        (((1 : ℂ) / 2) • ((mom κ i).comp (drift κ i) + (drift κ i).comp (mom κ i)))
      = (ShiftData.shiftH (modeData hκ i)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (fockSym κ))) := by sorry
