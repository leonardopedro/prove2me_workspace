-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — theorem BookProof.NavierStokesFlow.HermiteFarisLavine.commForm_ne_zero_of_pos
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}


open scoped ENNReal



open LpNat FarisLavine IkebeKato

theorem BookProof.NavierStokesFlow.HermiteFarisLavine.commForm_ne_zero_of_pos (hκ : 0 < κ) :
    commForm (nsH κ (le_of_lt hκ)) (diagMax (oscSymbol κ)) (testState κ) ≠ 0 := by sorry
