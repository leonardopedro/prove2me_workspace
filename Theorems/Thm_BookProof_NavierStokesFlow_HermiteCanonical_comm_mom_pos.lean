-- Generated from ChapterNavierStokesHermiteCanonical.lean — theorem BookProof.NavierStokesFlow.HermiteCanonical.comm_mom_pos
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteCanonical







open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.HermiteFarisLavine
























variable {κ : ℝ}

theorem BookProof.NavierStokesFlow.HermiteCanonical.comm_mom_pos (hκ : 0 < κ) :
    (mom κ).comp (pos κ) - (pos κ).comp (mom κ) = (-Complex.I) • LinearMap.id := by sorry
