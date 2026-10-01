-- Generated from ChapterNavierStokesHermiteCanonical.lean — theorem BookProof.NavierStokesFlow.HermiteCanonical.drift_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteCanonical

variable {κ : ℝ}


open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine

theorem BookProof.NavierStokesFlow.HermiteCanonical.drift_eq (hκ : 0 < κ) : drift κ = (κ : ℂ) • pos κ := by sorry
