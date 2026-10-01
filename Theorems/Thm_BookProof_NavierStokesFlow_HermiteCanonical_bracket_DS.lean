-- Generated from ChapterNavierStokesHermiteCanonical.lean — theorem BookProof.NavierStokesFlow.HermiteCanonical.bracket_DS
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteCanonical

variable {κ : ℝ}


open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine

theorem BookProof.NavierStokesFlow.HermiteCanonical.bracket_DS :
    (cre - ann).comp (cre + ann) - (cre + ann).comp (cre - ann) = (-2 : ℂ) • LinearMap.id := by sorry
