-- Generated from ChapterNavierStokesDeficiency.lean — theorem BookProof.NavierStokesFlow.DiagonalEsa.diagOp_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiagonalEsa


open scoped ENNReal

    lp.inner_single_left] at h
  simpa using h

theorem BookProof.NavierStokesFlow.DiagonalEsa.diagOp_not_bounded (n : ℕ) : ‖basis n‖ = 1 := by
  have : ‖(basis n : L2N)‖ = ‖(1 : ℂ)‖ := lp.norm_single (by norm_num) n 1
  simpa using this

/-- **The diagonal operator really is unbounded** when its symbol is: no
constant `C` dominates it on the finite-mode domain.  Together with
`diagOp_hasZeroDeficiencyOn` this shows that es := by sorry
