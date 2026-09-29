-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.DiagonalEsa.diagOp_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
import Theorems.Thm_BookProof_NavierStokesFlow_DiagonalEsa_diagOp_basis
import Theorems.Thm_BookProof_NavierStokesFlow_DiagonalEsa_basis_total
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiagonalEsa










open scoped ENNReal











open LpNat





























open LpNat

set_option maxHeartbeats 1000000 in
theorem solution (c : ℕ → ℝ) :
    HasZeroDeficiencyOn (lpFiniteModes ℕ) (diagOp c) := hasZeroDeficiencyOn_of_total_eigenvectors _ _ basis c (diagOp_basis c) basis_total
