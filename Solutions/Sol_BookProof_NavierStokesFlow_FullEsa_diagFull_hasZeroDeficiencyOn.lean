-- Generated from ChapterNavierStokesFullEsa.lean — solution of BookProof.NavierStokesFlow.FullEsa.diagFull_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagFullData_hamiltonian
import Theorems.Thm_BookProof_NavierStokesFlow_DiagonalEsa_diagOp_hasZeroDeficiencyOn
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Theorems.Thm_BookProof_NavierStokesFlow_hasZeroDeficiencyOn_of_total_eigenvectors
import Theorems.Thm_BookProof_NavierStokesFlow_DiagonalEsa_diagOp_basis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa



open scoped ENNReal
open BookProof.ChapterAbelianDiagonalCountable
open BookProof.NavierStokesFlow.DiagonalEsa
open BookProof.NavierStokesFlow.JacobiDeficiency
open BookProof.NavierStokesFlow.LpNat
open NSFullData

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable (d : NSFullData F)


private theorem basis_total (w : L2N) (hw : ∀ n, (inner ℂ ((basis n : lpFiniteModes ℕ) : L2N) w : ℂ) = 0) :
    w = 0 := by
  ext n
  have h := hw n
  rw [show ((basis n : lpFiniteModes ℕ) : L2N) = lp.single 2 n 1 from rfl,
    lp.inner_single_left] at h
  simpa using h

private theorem diagOp_hasZeroDeficiencyOn (c : ℕ → ℝ) :
    HasZeroDeficiencyOn (lpFiniteModes ℕ) (diagOp c) :=
  hasZeroDeficiencyOn_of_total_eigenvectors _ _ basis c (diagOp_basis c) basis_total

set_option maxHeartbeats 1000000 in

theorem solution (c : Fin 15 → ℕ → ℝ) (p : Fin 3 → ℕ → ℝ) (nu : ℝ) :
    HasZeroDeficiencyOn (diagFullData c p nu).D (diagFullData c p nu).hamiltonian := by
  rw [diagFullData_hamiltonian]
  exact _root_.diagOp_hasZeroDeficiencyOn _
