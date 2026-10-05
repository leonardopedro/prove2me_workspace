-- Generated from ChapterA3h.lean — solution of BookProof.ChapterA3.upsilonC_real
import Mathlib
import Definitions.Def_ChapterA3h
import Theorems.Thm_BookProof_ChapterA3_pauliσ_herm
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (T : Matrix (Fin 2) (Fin 2) ℂ) (μ ν : Fin 4) :
    conj (UpsilonC T μ ν) = UpsilonC T μ ν := by

  simp only [UpsilonC, Matrix.of_apply, pauliCoeff]
  have hc : ∀ M : Matrix (Fin 2) (Fin 2) ℂ, conj (Matrix.trace M) = Matrix.trace (Mᴴ) := by
    intro M
    simp [Matrix.trace, Matrix.conjTranspose]
  have h2 : conj ((2:ℂ)⁻¹) = (2:ℂ)⁻¹ := by rw [Complex.conj_inv, Complex.conj_ofNat]
  have htr : Matrix.trace ((pauliσ μ * (Tᴴ * pauliσ ν * T))ᴴ)
      = Matrix.trace (pauliσ μ * (Tᴴ * pauliσ ν * T)) := by
    repeat rw [Matrix.conjTranspose_mul]
    rw [Matrix.conjTranspose_conjTranspose, pauliσ_herm μ, pauliσ_herm ν]
    rw [Matrix.trace_mul_comm]
    simp [mul_assoc]
  rw [map_mul, h2, hc, htr]
