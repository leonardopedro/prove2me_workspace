-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — solution of BookProof.NavierStokesFlow.HermiteFarisLavine.commForm_ne_zero_of_pos
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteFarisLavine_commForm_testState
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine



open scoped ENNReal



open LpNat FarisLavine IkebeKato

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}

set_option maxHeartbeats 1000000 in
theorem solution (hκ : 0 < κ) :
    commForm (nsH κ (le_of_lt hκ)) (diagMax (oscSymbol κ)) (testState κ) ≠ 0 := by

  rw [commForm_testState (le_of_lt hκ)]
  have hamp : 0 < amp κ 0 := by
    have : (0 : ℝ) < Real.sqrt ((0 + 1) * (0 + 2)) := by
      rw [Real.sqrt_pos]; norm_num
    simp only [amp]
    push_cast
    positivity
  positivity
