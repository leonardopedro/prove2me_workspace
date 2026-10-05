-- Generated from ChapterNavierStokesBilinearEsa.lean — solution of BookProof.NavierStokesFlow.BilinearEsa.bilFun_embFun
import Mathlib
import Definitions.Def_ChapterNavierStokesBilinearEsa
open BookProof.NavierStokesFlow



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine

variable {J : Type*}

variable {J : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (κ : J → ℝ) (j : J) (a : ℕ → ℂ) :
    bilFun κ (embFun j a) = embFun j (hFun (κ j) a) := by

  funext p
  obtain ⟨m, j'⟩ := p
  by_cases hj : j' = j
  · subst hj
    simp [bilFun, embFun]
  · simp only [bilFun, embFun, hFun, shift2, hj, if_false]
    simp
