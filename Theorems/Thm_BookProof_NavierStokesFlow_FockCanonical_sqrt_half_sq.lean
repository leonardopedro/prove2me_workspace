-- Generated from ChapterNavierStokesFockCanonical.lean — theorem BookProof.NavierStokesFlow.FockCanonical.sqrt_half_sq
import Mathlib
import Definitions.Def_ChapterNavierStokesFockCanonical
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockCanonical


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ShiftHamiltonian FockManyMode HermiteCanonical

variable {d : ℕ} {κ : Fin d → ℝ}


theorem BookProof.NavierStokesFlow.FockCanonical.sqrt_half_sq (i : Fin d) (hκ : 0 ≤ κ i) :
    (Real.sqrt (κ i / 2) : ℂ) * (Real.sqrt (κ i / 2) : ℂ) = (κ i : ℂ) / 2 := by sorry
