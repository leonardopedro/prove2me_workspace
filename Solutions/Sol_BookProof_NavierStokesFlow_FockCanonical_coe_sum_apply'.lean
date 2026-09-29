-- Generated from ChapterNavierStokesFockCanonical.lean — solution of BookProof.NavierStokesFlow.FockCanonical.coe_sum_apply'
import Mathlib
import Definitions.Def_ChapterNavierStokesFockCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockCanonical








open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.ShiftHamiltonian BookProof.NavierStokesFlow.FockManyMode BookProof.NavierStokesFlow.HermiteCanonical

variable {d : ℕ} {κ : Fin d → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (s : Finset (Fin d)) (v : Fin d → L2I (Occ d)) (α : Occ d) :
    (((∑ i ∈ s, v i : L2I (Occ d))) : Occ d → ℂ) α
      = ∑ i ∈ s, ((v i : L2I (Occ d)) : Occ d → ℂ) α := by

  classical
  induction s using Finset.induction with
  | empty => simp
  | insert i t hi ih =>
      rw [Finset.sum_insert hi, Finset.sum_insert hi, ← ih]
      simp only [lp.coeFn_add, Pi.add_apply]
