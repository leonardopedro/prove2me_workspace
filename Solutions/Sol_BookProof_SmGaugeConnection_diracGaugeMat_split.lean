-- Generated from ChapterSmGaugeConnection.lean — solution of BookProof.SmGaugeConnection.diracGaugeMat_split
import Mathlib
import Definitions.Def_ChapterSmGaugeConnection
import Theorems.Thm_BookProof_SmGaugeConnection_sum_kronecker_right
open BookProof.SmGaugeConnection




open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.ChapterCPTHamiltonian BookProof.SmCar
open BookProof.SmDiracYukawa BookProof.SmDiracSpinor BookProof.FarisLavine

noncomputable section

variable {N d : ℕ}

variable {N d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (k : Fin 3 → ℝ) (m1 m2 g : ℝ)
    (T : Fin d → Matrix (Fin N) (Fin N) ℂ) (A : Fin d → Fin 3 → ℝ) :
    diracGaugeMat k m1 m2 g T A
      = diracOneParticle k m1 m2 ⊗ₖ (1 : Matrix (Fin N) (Fin N) ℂ)
        + ∑ j : Fin 3, Kin j ⊗ₖ conn g T A j := by

  have hfree : diracOneParticle k m1 m2
      = (∑ j : Fin 3, ((k j : ℝ) : ℂ) • Kin j)
        + (((-Complex.I) * (m1 : ℂ)) • MassA + ((-Complex.I) * (m2 : ℂ)) • MassB) := by
    rw [diracOneParticle, diracHamOp, smul_add, smul_add, smul_smul, smul_smul, smul_smul]
    have hII : (-Complex.I) * Complex.I = 1 := by
      rw [neg_mul, Complex.I_mul_I, neg_neg]
    rw [hII, one_smul, add_assoc]
  rw [diracGaugeMat, hfree]
  simp only [Matrix.add_kronecker, sum_kronecker_right, Matrix.kronecker_add,
    Matrix.kronecker_smul, Matrix.smul_kronecker, Finset.sum_add_distrib]
  abel
