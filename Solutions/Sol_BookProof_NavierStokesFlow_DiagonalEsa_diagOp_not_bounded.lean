-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.DiagonalEsa.diagOp_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
import Theorems.Thm_BookProof_NavierStokesFlow_DiagonalEsa_diagOp_basis
import Theorems.Thm_BookProof_NavierStokesFlow_DiagonalEsa_norm_basis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiagonalEsa



open scoped ENNReal

set_option maxHeartbeats 1000000 in
    lp.inner_single_left] at h
  simpa using h

theorem solution (n : ℕ) : ‖basis n‖ = 1 := by
  have : ‖(basis n : L2N)‖ = ‖(1 : ℂ)‖ := lp.norm_single (by norm_num) n 1
  simpa using this

/-- **The diagonal operator really is unbounded** when its symbol is: no
constant `C` dominates it on the finite-mode domain.  Together with
`diagOp_hasZeroDeficiencyOn` this shows that es :=
  sential self-adjointness on a
  proper dense domain is not a boundedness phenomenon. -/
  theorem diagOp_not_bounded (c : ℕ → ℝ) (hc : ∀ C : ℝ, ∃ n, C < |c n|) :
      ¬ ∃ C : ℝ, ∀ f : lpFiniteModes
