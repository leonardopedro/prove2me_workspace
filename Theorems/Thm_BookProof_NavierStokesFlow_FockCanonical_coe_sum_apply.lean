-- Generated from ChapterNavierStokesFockCanonical.lean — theorem BookProof.NavierStokesFlow.FockCanonical.coe_sum_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesFockCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockCanonical







open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.ShiftHamiltonian BookProof.NavierStokesFlow.FockManyMode BookProof.NavierStokesFlow.HermiteCanonical

variable {d : ℕ} {κ : Fin d → ℝ}

theorem BookProof.NavierStokesFlow.FockCanonical.coe_sum_apply (s : Finset (Fin d)) (v : Fin d → lpFiniteModes (Occ d)) (α : Occ d) :
    (((∑ i ∈ s, v i : lpFiniteModes (Occ d)) : L2I (Occ d)) : Occ d → ℂ) α
      = ∑ i ∈ s, (((v i : lpFiniteModes (Occ d)) : L2I (Occ d)) : Occ d → ℂ) α := by sorry
