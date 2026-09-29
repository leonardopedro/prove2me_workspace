-- Generated from ChapterNavierStokesFockCanonical.lean — theorem BookProof.NavierStokesFlow.FockCanonical.cre_cre_coe_of_lt
import Mathlib
import Definitions.Def_ChapterNavierStokesFockCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockCanonical







open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.ShiftHamiltonian BookProof.NavierStokesFlow.FockManyMode BookProof.NavierStokesFlow.HermiteCanonical

variable {d : ℕ} {κ : Fin d → ℝ}

theorem BookProof.NavierStokesFlow.FockCanonical.cre_cre_coe_of_lt (i : Fin d) (x : lpFiniteModes (Occ d)) {β : Occ d}
    (h : β i < 2) :
    (((cre i (cre i x) : lpFiniteModes (Occ d)) : L2I (Occ d)) : Occ d → ℂ) β = 0 := by sorry
