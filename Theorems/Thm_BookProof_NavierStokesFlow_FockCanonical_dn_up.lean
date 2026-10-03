-- Generated from ChapterNavierStokesFockCanonical.lean — theorem BookProof.NavierStokesFlow.FockCanonical.dn_up
import Mathlib
import Definitions.Def_ChapterNavierStokesFockCanonical
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesFockManyMode
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockCanonical

variable {d : ℕ} {κ : Fin d → ℝ}


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ShiftHamiltonian FockManyMode HermiteCanonical


theorem BookProof.NavierStokesFlow.FockCanonical.dn_up (i : Fin d) (α : Occ d) : dn i (up i α) = α := by
  funext j
  by_cases hj : j = i
  · subst hj; simp [up, dn]
  · simp [up, dn, hj]

theorem up_dn (i : Fin d) {α : Occ d} (h : 1 ≤ α i) : up i (dn i α) = α := by sorry
