-- Generated from ChapterNavierStokesFockCanonical.lean — theorem BookProof.NavierStokesFlow.FockCanonical.comm_ann_cre
import Mathlib
import Definitions.Def_ChapterNavierStokesFockCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockCanonical







open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.ShiftHamiltonian BookProof.NavierStokesFlow.FockManyMode BookProof.NavierStokesFlow.HermiteCanonical

variable {d : ℕ} {κ : Fin d → ℝ}

theorem BookProof.NavierStokesFlow.FockCanonical.comm_ann_cre (i : Fin d) :
    (ann i).comp (cre i) - (cre i).comp (ann i) = LinearMap.id := by sorry
