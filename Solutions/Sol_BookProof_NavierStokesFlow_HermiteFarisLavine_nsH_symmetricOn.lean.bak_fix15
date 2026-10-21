-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — solution of BookProof.NavierStokesFlow.HermiteFarisLavine.nsH_symmetricOn
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteFarisLavine_hasSum_inner_nsH_left
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteFarisLavine_hasSum_inner_nsH_right
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}

set_option maxHeartbeats 1000000 in
theorem solution (hκ : 0 ≤ κ) : SymmetricOn (maxDom (oscSymbol κ)) (nsH κ hκ) := by

  intro x y
  exact (hasSum_inner_nsH_left hκ x (y : L2I ℕ)).unique (hasSum_inner_nsH_right hκ x y)
