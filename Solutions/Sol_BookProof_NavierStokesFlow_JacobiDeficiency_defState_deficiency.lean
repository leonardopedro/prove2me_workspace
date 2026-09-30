-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.JacobiDeficiency.defState_deficiency
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
import Theorems.Thm_BookProof_NavierStokesFlow_LpNat_inner_eq_sum_range
import Theorems.Thm_BookProof_NavierStokesFlow_JacobiDeficiency_jacobi_wronskian
import Theorems.Thm_BookProof_NavierStokesFlow_JacobiDeficiency_jacobiFun_defFun
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency










open scoped ENNReal











open LpNat

set_option maxHeartbeats 1000000 in
theorem solution (v : lpFiniteModes ℕ) :
    (inner ℂ ((jacobiOp v : lpFiniteModes ℕ) : L2N) defState : ℂ)
      = inner ℂ ((v : lpFiniteModes ℕ) : L2N) (Complex.I • defState) := by

  obtain ⟨N, hN⟩ := exists_tail_zero v.2
  have hlhs := inner_eq_sum_range (f := ((jacobiOp v : lpFiniteModes ℕ) : L2N))
    (g := defState) (N := N + 1) (by simpa using jacobiFun_tail_zero hN)
  have hrhs := inner_eq_sum_range (f := ((v : lpFiniteModes ℕ) : L2N))
    (g := Complex.I • defState) (N := N + 1) (fun n hn => hN n (by omega))
  rw [hlhs, hrhs, ← sub_eq_zero, ← Finset.sum_sub_distrib]
  have hsmul : ∀ n, ((Complex.I • defState : L2N) : ℕ → ℂ) n = jacobiFun defFun n := by
    intro n
    rw [jacobiFun_defFun]
    simp
  simp only [jacobiOp_coe, defState_coe, hsmul]
  rw [jacobi_wronskian]
  rw [hN N le_rfl, hN (N + 1) (by omega)]
  simp
