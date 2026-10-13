-- Generated from ChapterSmDiracYukawa.lean — solution of BookProof.SmDiracYukawa.diagOp_inner
import Mathlib
import Definitions.Def_ChapterSmDiracYukawa
import Theorems.Thm_BookProof_SmCar_inner_eq_sum
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmDiracYukawa




open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine
open BookProof.ChapterAbelianDiagonalCountable
open BookProof.SmCar

variable {n : ℕ}

noncomputable section

variable {n : ℕ}


@[simp] private theorem diagOp_apply (d : EllInf) (f : Ell2C) (i : ℕ) :
    ((diagOp d f : Ell2C) : ℕ → ℂ) i = (d : ℕ → ℂ) i * (f : ℕ → ℂ) i := rfl

set_option maxHeartbeats 1000000 in

theorem solution (d : Finset (Fin n) → ℝ) (ψ : FermiFock n) :
    (inner ℂ ψ (diagOp d ψ) : ℂ)
      = ∑ S : Finset (Fin n), ((d S * ‖ψ S‖ ^ 2 : ℝ) : ℂ) := by
  rw [inner_eq_sum]
  refine Finset.sum_congr rfl fun S _ => ?_
  rw [diagOp_apply, Complex.ofReal_mul,
    show (starRingEnd ℂ) (ψ S) * ((d S : ℂ) * ψ S)
      = (d S : ℂ) * ((starRingEnd ℂ) (ψ S) * ψ S) by ring, ← Complex.normSq_eq_conj_mul_self]
  simp [Complex.normSq_eq_norm_sq]
