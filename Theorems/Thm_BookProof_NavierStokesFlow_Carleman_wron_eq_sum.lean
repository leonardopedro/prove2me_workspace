-- Generated from ChapterNavierStokesCarleman.lean — theorem BookProof.NavierStokesFlow.Carleman.wron_eq_sum
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.Carleman


open scoped ENNReal



open LpNat DiagonalEsa FullEsa

theorem BookProof.NavierStokesFlow.Carleman.wron_eq_sum (c w : ℕ → ℂ) (z : ℂ)
    (hrec : ∀ n, tridiagFun c w n = z * w n) (N : ℕ) :
    wron c w N
      = (z - starRingEnd ℂ z) * ∑ n ∈ Finset.range (N + 1), starRingEnd ℂ (w n) * w n := by sorry
