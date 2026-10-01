-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — solution of BookProof.NavierStokesFlow.HermiteFarisLavine.commForm_testState
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteFarisLavine_hasSum_commForm
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteFarisLavine_testState_coe
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine



open scoped ENNReal



open LpNat FarisLavine IkebeKato

set_option maxHeartbeats 1000000 in
theorem solution (hκ : 0 ≤ κ) :
    commForm (nsH κ hκ) (diagMax (oscSymbol κ)) (testState κ) = 8 * κ * amp κ 0 := by

  have hcs := hasSum_commForm hκ (testState κ)
  have hsingle : HasSum (fun n => 8 * κ * (amp κ n
      * ((starRingEnd ℂ) (((testState κ : L2I ℕ) : ℕ → ℂ) n)
        * ((testState κ : L2I ℕ) : ℕ → ℂ) (n + 2)).re)) (8 * κ * (amp κ 0
      * ((starRingEnd ℂ) (((testState κ : L2I ℕ) : ℕ → ℂ) 0)
        * ((testState κ : L2I ℕ) : ℕ → ℂ) (0 + 2)).re)) := by
    refine hasSum_single 0 fun n hn => ?_
    rcases Nat.lt_or_ge n 3 with h | h
    · interval_cases n
      · exact absurd rfl hn
      · simp [testState_coe]
      · simp [testState_coe]
    · have h1 : ((testState κ : L2I ℕ) : ℕ → ℂ) n = 0 := by
        rw [testState_coe]
        have : n ≠ 0 := by omega
        have : n ≠ 2 := by omega
        simp [*]
      simp [h1]
  rw [hcs.unique hsingle]
  simp [testState_coe]
