-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.JacobiDeficiency.jacobiOp_symmetric
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
import Theorems.Thm_BookProof_NavierStokesFlow_LpNat_inner_eq_sum_range
import Theorems.Thm_BookProof_NavierStokesFlow_JacobiDeficiency_jacobi_wronskian
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency










open scoped ENNReal











open LpNat

set_option maxHeartbeats 1000000 in
theorem solution (x y : lpFiniteModes ℕ) :
    (inner ℂ ((jacobiOp x : lpFiniteModes ℕ) : L2N) ((y : lpFiniteModes ℕ) : L2N) : ℂ)
      = inner ℂ ((x : lpFiniteModes ℕ) : L2N) ((jacobiOp y : lpFiniteModes ℕ) : L2N) := by

  obtain ⟨Nx, hNx⟩ := exists_tail_zero x.2
  obtain ⟨Ny, hNy⟩ := exists_tail_zero y.2
  set N := max Nx Ny with hN
  have hx : ∀ n, N ≤ n → ((x : L2N) : ℕ → ℂ) n = 0 :=
    fun n hn => hNx n (le_trans (le_max_left _ _) hn)
  have hy : ∀ n, N ≤ n → ((y : L2N) : ℕ → ℂ) n = 0 :=
    fun n hn => hNy n (le_trans (le_max_right _ _) hn)
  have hlhs := inner_eq_sum_range (f := ((jacobiOp x : lpFiniteModes ℕ) : L2N))
    (g := ((y : lpFiniteModes ℕ) : L2N)) (N := N + 1)
    (by simpa using jacobiFun_tail_zero hx)
  have hrhs := inner_eq_sum_range (f := ((x : lpFiniteModes ℕ) : L2N))
    (g := ((jacobiOp y : lpFiniteModes ℕ) : L2N)) (N := N + 1)
    (fun n hn => hx n (by omega))
  rw [hlhs, hrhs, ← sub_eq_zero, ← Finset.sum_sub_distrib]
  simp only [jacobiOp_coe]
  rw [jacobi_wronskian]
  rw [hx N le_rfl, hx (N + 1) (by omega), hy N le_rfl, hy (N + 1) (by omega)]
  simp
