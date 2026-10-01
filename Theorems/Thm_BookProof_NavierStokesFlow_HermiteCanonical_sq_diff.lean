-- Generated from ChapterNavierStokesHermiteCanonical.lean — theorem BookProof.NavierStokesFlow.HermiteCanonical.sq_diff
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteCanonical

variable {κ : ℝ}


open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine

theorem BookProof.NavierStokesFlow.HermiteCanonical.sq_diff :
    (cre + ann).comp (cre + ann) - (cre - ann).comp (cre - ann)
      = (2 : ℂ) • (cre.comp ann + ann.comp cre) := by sorry
