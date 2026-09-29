-- Generated from ChapterNavierStokesFockCanonical.lean — theorem BookProof.NavierStokesFlow.FockCanonical.fock_comparison_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesFockCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockCanonical







open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.ShiftHamiltonian BookProof.NavierStokesFlow.FockManyMode BookProof.NavierStokesFlow.HermiteCanonical

variable {d : ℕ} {κ : Fin d → ℝ}

theorem BookProof.NavierStokesFlow.FockCanonical.fock_comparison_eq (hκ : ∀ i, 0 ≤ κ i) :
    (lpFiniteModes (Occ d)).subtype.comp
        ((∑ i, ((mom κ i).comp (mom κ i) + (drift κ i).comp (drift κ i))) + LinearMap.id)
      = (diagMax (fockSym κ)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (fockSym κ))) := by sorry
