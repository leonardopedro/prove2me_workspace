-- Generated from ChapterNavierStokesHermiteCanonical.lean — theorem BookProof.NavierStokesFlow.HermiteCanonical.cre_cre_coe_add_two
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteCanonical
import Definitions.Def_ChapterBosonicCCR
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.Bosonic
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteCanonical


open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine

theorem BookProof.NavierStokesFlow.HermiteCanonical.cre_cre_coe_add_two (x : lpFiniteModes ℕ) (k : ℕ) :
    (((cre (cre x) : lpFiniteModes ℕ) : L2I ℕ) : ℕ → ℂ) (k + 2)
      = (Real.sqrt ((k : ℝ) + 2) : ℂ) * (Real.sqrt ((k : ℝ) + 1) : ℂ)
        * ((x : L2I ℕ) : ℕ → ℂ) k := by sorry
