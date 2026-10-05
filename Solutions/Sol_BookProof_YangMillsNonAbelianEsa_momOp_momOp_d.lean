-- Generated from ChapterYangMillsNonAbelianEsa.lean — solution of BookProof.YangMillsNonAbelianEsa.momOp_momOp_d
import Mathlib
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Theorems.Thm_BookProof_YangMillsHermite_momOp_apply
open BookProof.YangMillsNonAbelianEsa




open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.TensorCore BookProof.DirectSumEsa BookProof.SecondQuantizationCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {D : Submodule ℂ F}
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    momOp j (momOp j p) = -coreD j (coreD j p) := by

  have hstep : ∀ r : MvPolynomial (Fin d) ℂ, momOp j r = (-Complex.I) • coreD j r := by
    intro r
    rw [momOp_apply, coreD]
    congr 1
    congr 1
    rw [MvPolynomial.smul_eq_C_mul]
    norm_num
  rw [hstep, hstep, coreD_smul, smul_smul]
  have hII : (-Complex.I) * (-Complex.I) = -1 := by
    simp [Complex.I_mul_I]
  rw [hII]
  module
