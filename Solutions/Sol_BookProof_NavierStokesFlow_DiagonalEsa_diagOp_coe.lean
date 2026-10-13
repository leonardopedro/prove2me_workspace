-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.DiagonalEsa.diagOp_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiagonalEsa



open scoped ENNReal lp

set_option maxHeartbeats 1000000 in

theorem solution (c : ℕ → ℝ) (f : lpFiniteModes ℕ) :
    (((diagOp c f : lpFiniteModes ℕ) : L2N) : ℕ → ℂ) = diagFun c ((f : L2N) : ℕ → ℂ) := rfl

/-- The canonical basis state `e_n`, as an element of the finite-mode domain. -/
noncomputable def basis (n : ℕ) : lpFiniteModes ℕ :=
  ⟨lp.single 2 n 1, lpSingle_mem_lpFiniteModes n 1⟩

/-- The basis states are eigenvectors of the diagonal operator. -/
theorem diagOp_basis (c : ℕ → ℝ) (n : ℕ) : diagOp c (basis n) = ((c n : ℂ)) • basis n := by
  ext m
  by_cases hmn : m = n
  · subst hmn
    simp [diagOp, basis, diagFun, lp.single_apply]
    change ↑(c m) = c m • ((lp.single 2 m 1 : lp (fun _ : ℕ => ℂ) 2) : ℕ → ℂ) m
    simp [lp.single_apply]
  · simp [diagOp, basis, diagFun, lp.single_apply, Pi.single_eq_of_ne hmn]
    change 0 = c n • ((lp.single 2 n 1 : lp (fun _ : ℕ => ℂ) 2) : ℕ → ℂ) m
    simp [Pi.single_eq_of_ne hmn]
