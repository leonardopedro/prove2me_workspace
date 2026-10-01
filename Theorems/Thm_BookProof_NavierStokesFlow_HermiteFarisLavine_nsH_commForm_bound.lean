-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — theorem BookProof.NavierStokesFlow.HermiteFarisLavine.nsH_commForm_bound
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}


open scoped ENNReal



open LpNat FarisLavine IkebeKato

theorem BookProof.NavierStokesFlow.HermiteFarisLavine.nsH_commForm_bound (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) :
    |commForm (nsH κ hκ) (diagMax (oscSymbol κ)) x|
      ≤ (2 * κ + 4 * κ ^ 2) * quadForm (diagMax (oscSymbol κ)) x := by sorry
