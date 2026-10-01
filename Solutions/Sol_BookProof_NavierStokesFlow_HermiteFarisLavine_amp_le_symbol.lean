-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — solution of BookProof.NavierStokesFlow.HermiteFarisLavine.amp_le_symbol
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine



open scoped ENNReal



open LpNat FarisLavine IkebeKato

set_option maxHeartbeats 1000000 in
theorem solution (hκ : 0 ≤ κ) (n : ℕ) :
    amp κ n ≤ (1 / 4 + κ / 2) * oscSymbol κ n := by

  have h1 := amp_le_quarter hκ n
  have h2 : (1 : ℝ) ≤ oscSymbol κ n := oscSymbol_ge_one hκ n
  nlinarith
