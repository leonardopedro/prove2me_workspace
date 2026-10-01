-- Generated from ChapterNavierStokesFockCanonical.lean — theorem BookProof.NavierStokesFlow.FockCanonical.mode_hamiltonian_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesFockCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockCanonical

variable {d : ℕ} {κ : Fin d → ℝ}


open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian FockManyMode HermiteCanonical

variable {d : ℕ} {κ : Fin d → ℝ}

set_option maxHeartbeats 1000000 in
-- reason for change: the defeq checks of the two lattice `show` statements below
-- unify coercion towers over `↑↑x`/`Submodule.inclusion`-terms and exceed 200k
theorem BookProof.NavierStokesFlow.FockCanonical.mode_hamiltonian_eq (hκ : ∀ i, 0 ≤ κ i) (i : Fin d) :
    (lpFiniteModes (Occ d)).subtype.comp := by sorry
