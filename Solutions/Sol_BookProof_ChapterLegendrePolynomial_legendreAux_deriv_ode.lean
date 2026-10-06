-- Generated from ChapterLegendrePolynomial.lean — solution of BookProof.ChapterLegendrePolynomial.legendreAux_deriv_ode
import Mathlib
import Definitions.Def_ChapterLegendrePolynomial
import Theorems.Thm_BookProof_ChapterLegendrePolynomial_iterD_add
import Theorems.Thm_BookProof_ChapterLegendrePolynomial_iterD_X_mul
import Theorems.Thm_BookProof_ChapterLegendrePolynomial_iterD_Xsq_mul
import Theorems.Thm_BookProof_ChapterLegendrePolynomial_legendreAux_ode
open BookProof.ChapterLegendrePolynomial




open Polynomial

set_option maxHeartbeats 1000000 in
theorem solution (l μ : ℕ) :
    (X ^ 2 - 1) * derivative^[2] (derivative^[μ] (legendreAux l))
      + C (2 * (μ : ℝ) + 2) * X * derivative (derivative^[μ] (legendreAux l))
      + C ((μ : ℝ) * ((μ : ℝ) + 1) - (l : ℝ) * ((l : ℝ) + 1)) * derivative^[μ] (legendreAux l)
      = 0 := by

  set u : ℝ[X] := legendreAux l with hu
  have sh : ∀ (a b : ℕ), derivative^[a] (derivative^[b] u) = derivative^[a+b] u := by
    intro a b; rw [← Function.iterate_add_apply]
  have key := congrArg (fun p => derivative^[μ] p) (legendreAux_ode l)
  simp only [← hu] at key
  have e1 : (X ^ 2 - 1 : ℝ[X]) * derivative^[2] u
      = X ^ 2 * derivative^[2] u - derivative^[2] u := by ring
  rw [e1, iterate_derivative_sub, iterD_add, iterate_derivative_sub,
    iterD_Xsq_mul μ (derivative^[2] u),
    show C 2 * X * derivative u = C (2 : ℝ) * (X * derivative u) from by ring,
    iterate_derivative_C_mul, iterD_X_mul μ (derivative u),
    iterate_derivative_C_mul, iterate_derivative_zero] at key
  have n1 : derivative^[μ] (derivative^[2] u) = derivative^[μ+2] u := sh μ 2
  have n2 : derivative^[μ] (derivative u) = derivative^[μ+1] u := by
    rw [show derivative u = derivative^[1] u from rfl, sh μ 1]
  have n3 : C ((μ : ℝ) * ((μ : ℝ) - 1)) * derivative^[μ-2] (derivative^[2] u)
      = C ((μ : ℝ) * ((μ : ℝ) - 1)) * derivative^[μ] u := by
    match μ with
    | 0 => norm_num
    | 1 => norm_num
    | (n+2) => rw [show n + 2 - 2 = n from rfl, sh n 2]
  have n4 : C (2 * (μ : ℝ)) * X * derivative^[μ-1] (derivative^[2] u)
      = C (2 * (μ : ℝ)) * X * derivative^[μ+1] u := by
    match μ with
    | 0 => norm_num
    | (n+1) => rw [show n + 1 - 1 = n from rfl, sh n 2]
  have n5 : C ((μ : ℝ)) * derivative^[μ-1] (derivative u)
      = C ((μ : ℝ)) * derivative^[μ] u := by
    match μ with
    | 0 => norm_num
    | (n+1) => rw [show n + 1 - 1 = n from rfl, show derivative u = derivative^[1] u from rfl,
        sh n 1]
  rw [n1, n4, n3, n2, n5] at key
  rw [sh 2 μ, Nat.add_comm 2 μ, show derivative (derivative^[μ] u) = derivative^[μ+1] u from by
    rw [← Function.iterate_succ_apply' derivative μ u]]
  simp only [C_add, C_1, C_mul, map_ofNat, C_sub] at key ⊢
  linear_combination key
