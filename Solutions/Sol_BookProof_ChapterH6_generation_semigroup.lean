-- Generated from ChapterH6.lean — solution of BookProof.ChapterH6.generation_semigroup
import Mathlib
import Definitions.Def_ChapterH6
open BookProof.ChapterH6



noncomputable section

open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (A : Matrix (Fin m) (Fin m) ℂ) (s t : ℂ)
    (psi0 : Fin m → ℂ) :
    generatedState A (s + t) psi0 = generatedState A s (generatedState A t psi0) := by

  have hcomm : Commute ((-Complex.I * s) • A) ((-Complex.I * t) • A) := by
    unfold Commute SemiconjBy
    rw [Matrix.smul_mul, Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_smul, smul_smul, smul_smul,
      mul_comm (-Complex.I * s) (-Complex.I * t)]
  have hsplit : (-Complex.I * (s + t)) • A
      = ((-Complex.I * s) • A) + ((-Complex.I * t) • A) := by
    rw [← add_smul]
    congr 1
    ring
  rw [generatedState, generatedState, generatedState, hsplit,
    Matrix.exp_add_of_commute _ _ hcomm, ← Matrix.mulVec_mulVec]
