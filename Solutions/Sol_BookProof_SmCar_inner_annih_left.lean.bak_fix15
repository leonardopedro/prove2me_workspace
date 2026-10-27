-- Generated from ChapterSmCarAlgebra.lean — solution of BookProof.SmCar.inner_annih_left
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Theorems.Thm_BookProof_SmCar_inner_creat_left
open BookProof.SmCar




open Finset

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin n) (ψ φ : FermiFock n) :
    (inner ℂ (annih i ψ) φ : ℂ) = inner ℂ ψ (creat i φ) := by

  have h := inner_creat_left i φ ψ
  have h2 := congrArg (starRingEnd ℂ) h
  rw [inner_conj_symm, inner_conj_symm] at h2
  exact h2.symm
