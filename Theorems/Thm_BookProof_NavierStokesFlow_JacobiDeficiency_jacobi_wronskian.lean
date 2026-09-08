-- Generated from ChapterNavierStokesDeficiency.lean — theorem BookProof.NavierStokesFlow.JacobiDeficiency.jacobi_wronskian
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency









open scoped ENNReal











open LpNat

theorem BookProof.NavierStokesFlow.JacobiDeficiency.jacobi_wronskian (x y : ℕ → ℂ) (N : ℕ) :
    ∑ n ∈ Finset.range (N + 1),
        (starRingEnd ℂ (jacobiFun x n) * y n - starRingEnd ℂ (x n) * jacobiFun y n)
      = (jacobiWeight N : ℂ) *
          (starRingEnd ℂ (x (N + 1)) * y N - starRingEnd ℂ (x N) * y (N + 1)) := by sorry
