-- Generated from ChapterNavierStokesHermiteCanonical.lean — theorem BookProof.NavierStokesFlow.HermiteCanonical.cre_cre_coe_zero
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteCanonical
import Definitions.Def_ChapterBosonicCCR
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.Bosonic
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteCanonical


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine

theorem BookProof.NavierStokesFlow.HermiteCanonical.cre_cre_coe_zero (x : lpFiniteModes ℕ) :
    (((cre (cre x) : lpFiniteModes ℕ) : L2I ℕ) : ℕ → ℂ) 0 = 0 := by sorry
