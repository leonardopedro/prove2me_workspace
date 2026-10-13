-- Generated from ChapterSmDiracYukawa.lean — solution of BookProof.SmDiracYukawa.diagOp_symmetric
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


theorem solution (d : Finset (Fin n) → ℝ) (ψ φ : FermiFock n) :
    (inner ℂ (diagOp d ψ) φ : ℂ) = inner ℂ ψ (diagOp d φ) := by
  rw [inner_eq_sum, inner_eq_sum]
  refine Finset.sum_congr rfl fun S _ => ?_
  simp only [diagOp_apply, map_mul, Complex.conj_ofReal]
  ring
