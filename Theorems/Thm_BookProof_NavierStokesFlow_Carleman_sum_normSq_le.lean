-- Generated from ChapterNavierStokesCarleman.lean — theorem BookProof.NavierStokesFlow.Carleman.sum_normSq_le
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow


open scoped ENNReal



open LpNat DiagonalEsa FullEsa

theorem BookProof.NavierStokesFlow.Carleman.sum_normSq_le (c w : ℕ → ℂ) (hrec : ∀ n, tridiagFun c w n = Complex.I * w n) (N : ℕ) :
    ∑ n ∈ Finset.range (N + 1), ‖w n‖ ^ 2 ≤ ‖c N‖ * (‖w (N + 1)‖ * ‖w N‖) := by sorry
