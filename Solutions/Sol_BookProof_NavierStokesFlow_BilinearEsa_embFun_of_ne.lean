-- Generated from ChapterNavierStokesBilinearEsa.lean — solution of BookProof.NavierStokesFlow.BilinearEsa.embFun_of_ne
import Mathlib
import Definitions.Def_ChapterNavierStokesBilinearEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.BilinearEsa



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine

variable {J : Type*}

variable {J : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {j j' : J} (a : ℕ → ℂ) (n : ℕ) (h : j' ≠ j) : embFun j a (n, j') = 0 := by

  simp [embFun, h]
