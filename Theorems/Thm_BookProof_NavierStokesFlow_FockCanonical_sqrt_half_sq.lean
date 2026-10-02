-- Generated from ChapterNavierStokesFockCanonical.lean — theorem BookProof.NavierStokesFlow.FockCanonical.sqrt_half_sq
import Mathlib
import Definitions.Def_ChapterNavierStokesFockCanonical
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockCanonical

variable {d : ℕ} {κ : Fin d → ℝ}


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ShiftHamiltonian FockManyMode HermiteCanonical


theorem BookProof.NavierStokesFlow.FockCanonical.sqrt_half_sq (i : Fin d) (hκ : 0 ≤ κ i) :
    (Real.sqrt (κ i / 2) : ℂ) * (Real.sqrt (κ i / 2) : ℂ) = (κ i : ℂ) / 2 := by sorry
