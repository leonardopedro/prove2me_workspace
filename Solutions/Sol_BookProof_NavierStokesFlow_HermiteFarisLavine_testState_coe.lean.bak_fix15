-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — solution of BookProof.NavierStokesFlow.HermiteFarisLavine.testState_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}

set_option maxHeartbeats 1000000 in
theorem solution (κ : ℝ) (n : ℕ) :
    ((testState κ : L2I ℕ) : ℕ → ℂ) n = if n = 0 then 1 else if n = 2 then 1 else 0 := by

  simp only [testState, lp.coeFn_add, Pi.add_apply, lp.single_apply, Pi.single_apply]
  by_cases h0 : n = 0
  · subst h0; norm_num
  · by_cases h2 : n = 2
    · subst h2; norm_num
    · simp [h0, h2]
