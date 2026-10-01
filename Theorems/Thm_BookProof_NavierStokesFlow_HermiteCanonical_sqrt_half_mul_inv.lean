-- Generated from ChapterNavierStokesHermiteCanonical.lean — theorem BookProof.NavierStokesFlow.HermiteCanonical.sqrt_half_mul_inv
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteCanonical

variable {κ : ℝ}


open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine

theorem BookProof.NavierStokesFlow.HermiteCanonical.sqrt_half_mul_inv (hκ : 0 < κ) :
    (Real.sqrt (κ / 2) : ℂ) * ((1 / Real.sqrt (2 * κ) : ℝ) : ℂ) = 1 / 2 := by sorry
