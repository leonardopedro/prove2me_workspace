-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.smYukawa_symmetricOn
import Mathlib
import Definitions.Def_ChapterSmYukawaCoupling
import Theorems.Thm_BookProof_SmCar_fermiBilin_symmetric
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterSmFullEnclosure
import Definitions.Def_ChapterTensorKatoRellich
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterSmDiracYukawa
open BookProof.SmYukawaCoupling




open scoped TensorProduct
open MeasureTheory MvPolynomial
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa BookProof.SmFullEnclosure BookProof.TensorKatoRellich
open BookProof.SmCar
open BookProof.SmDiracYukawa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) :
    SymmetricOn (fullDom n) (onFull (smYukawa M z)) :=
  fun x y =>
    fermiBilin_symmetric (by rw [Matrix.conjTranspose_add, Matrix.conjTranspose_conjTranspose,
      add_comm]) (x : FermiFock n) (y : FermiFock n)
