-- Generated from ChapterNavierStokesHermiteCanonical.lean — theorem BookProof.NavierStokesFlow.HermiteCanonical.anti_DS
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteCanonical

variable {κ : ℝ}


open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine

theorem BookProof.NavierStokesFlow.HermiteCanonical.anti_DS :
    (cre - ann).comp (cre + ann) + (cre + ann).comp (cre - ann)
      = (2 : ℂ) • (cre.comp cre - ann.comp ann) := by sorry
