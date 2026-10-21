-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.smYukawaFullHam_symmetricOn
import Mathlib
import Definitions.Def_ChapterSmYukawaCoupling
import Theorems.Thm_BookProof_SmYukawaCoupling_higgsMul_symmetricOn
import Theorems.Thm_BookProof_SmYukawaCoupling_smYukawa_symmetricOn
import Theorems.Thm_BookProof_KatoRellich_symmetricOn_add
import Theorems.Thm_BookProof_SmFullEnclosure_smFullHam_symmetricOn
import Theorems.Thm_BookProof_TensorKatoRellich_symmetricOn_coupling
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
theorem solution (P : SmParams) {n : ℕ} {hD : Matrix (Fin n) (Fin n) ℂ}
    (M : Matrix (Fin n) (Fin n) ℂ) (hh : hD.conjTranspose = hD) :
    SymmetricOn (smFullCore n) (smYukawaFullHam P hD M) :=
  KatoRellich.symmetricOn_add (smFullHam_symmetricOn P 0 0 hh)
      (symmetricOn_coupling (L2dSpace 163) (smFermiSpace n) (polyGaussCore (d := 163))
        (fullDom n) yukV (yukY M)
        (fun i => by fin_cases i <;> exact higgsMul_symmetricOn _)
        (fun i => by fin_cases i <;> exact smYukawa_symmetricOn M _))
