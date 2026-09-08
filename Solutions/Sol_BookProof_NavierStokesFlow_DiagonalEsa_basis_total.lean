-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.DiagonalEsa.basis_total
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiagonalEsa










open scoped ENNReal











open LpNat





























open LpNat

set_option maxHeartbeats 1000000 in
theorem solution (w : L2N) (hw : ∀ n, (inner ℂ ((basis n : lpFiniteModes ℕ) : L2N) w : ℂ) = 0) :
    w = 0 := by

  ext n
  have h := hw n
  rw [show ((basis n : lpFiniteModes ℕ) : L2N) = lp.single 2 n 1 from rfl,
    lp.inner_single_left] at h
  simpa using h
