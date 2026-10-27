-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.fermiBilin_smul
import Mathlib
import Definitions.Def_ChapterSmYukawaCoupling
open BookProof.SmYukawaCoupling




open scoped TensorProduct
open MeasureTheory MvPolynomial
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa BookProof.SmFullEnclosure BookProof.TensorKatoRellich

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (c : ℂ) (A : Matrix (Fin n) (Fin n) ℂ) :
    fermiBilin (c • A) = c • fermiBilin A := by

  simp only [fermiBilin, Matrix.smul_apply, smul_eq_mul, Finset.smul_sum, mul_smul]
