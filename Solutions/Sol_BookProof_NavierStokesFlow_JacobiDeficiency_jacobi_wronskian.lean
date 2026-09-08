-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.JacobiDeficiency.jacobi_wronskian
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency










open scoped ENNReal











open LpNat

set_option maxHeartbeats 1000000 in
theorem solution (x y : ℕ → ℂ) (N : ℕ) :
    ∑ n ∈ Finset.range (N + 1),
        (starRingEnd ℂ (jacobiFun x n) * y n - starRingEnd ℂ (x n) * jacobiFun y n)
      = (jacobiWeight N : ℂ) *
          (starRingEnd ℂ (x (N + 1)) * y N - starRingEnd ℂ (x N) * y (N + 1)) := by

  induction N with
  | zero =>
    simp [jacobiFun, Complex.conj_ofReal]
    ring
  | succ N ih =>
    rw [Finset.sum_range_succ, ih]
    simp only [jacobiFun, map_add, map_mul, Complex.conj_ofReal]
    ring
