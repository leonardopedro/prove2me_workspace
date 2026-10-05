-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.smYukawa_symmetricOn
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
theorem solution {n : ℕ} (M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) :
    SymmetricOn (fullDom n) (onFull (smYukawa M z)) :=
  fun x y =>
    fermiBilin_symmetric (by rw [Matrix.conjTranspose_add, Matrix.conjTranspose_conjTranspose,
      add_comm]) (x : FermiFock n) (y : FermiFock n)
