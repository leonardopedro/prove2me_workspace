-- Generated from ChapterNavierStokesHermiteCanonical.lean — theorem BookProof.NavierStokesFlow.HermiteCanonical.cre_ann_coe
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

theorem BookProof.NavierStokesFlow.HermiteCanonical.cre_ann_coe (x : lpFiniteModes ℕ) (n : ℕ) :
    (((cre (ann x) : lpFiniteModes ℕ) : L2I ℕ) : ℕ → ℂ) n
      = (n : ℂ) * ((x : L2I ℕ) : ℕ → ℂ) n := by sorry
