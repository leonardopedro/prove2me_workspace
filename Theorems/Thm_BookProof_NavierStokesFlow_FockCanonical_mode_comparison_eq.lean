-- Generated from ChapterNavierStokesFockCanonical.lean — theorem BookProof.NavierStokesFlow.FockCanonical.mode_comparison_eq
import Mathlib
import Definitions.Def_Chapter
import Definitions.Def_ChapterNavierStokesIkebeKatoNavierStokesFockCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockCanonical


open scoped ENNReal




variable {d : ℕ} {κ : Fin d → ℝ}

theorem BookProof.NavierStokesFlow.FockCanonical.mode_comparison_eq (i : Fin d) (hκ : 0 ≤ κ i) :
    (mom κ i).comp (mom κ i) + (drift κ i).comp (drift κ i)
      = (κ i : ℂ) • ((cre i).comp (ann i) + (ann i).comp (cre i)) := by sorry
