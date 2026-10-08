-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.smYukawa_eq_re_im
import Mathlib
import Definitions.Def_ChapterSmYukawaCoupling
import Theorems.Thm_BookProof_SmYukawaCoupling_fermiBilin_smul
import Theorems.Thm_BookProof_SmDiracYukawa_fermiBilin_add
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
theorem solution {n : ℕ} (M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) :
    smYukawa M z = (z.re : ℂ) • smYukawa M 1 + (z.im : ℂ) • smYukawa M Complex.I := by

  rw [smYukawa, smYukawa, smYukawa, ← fermiBilin_smul, ← fermiBilin_smul, ← fermiBilin_add]
  congr 1
  ext i j
  simp only [Matrix.add_apply, Matrix.smul_apply, Matrix.conjTranspose_apply, smul_eq_mul,
    star_mul', one_mul, Complex.star_def]
  apply Complex.ext <;> simp <;> ring
