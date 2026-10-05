-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.smYukawa_h_esa
import Mathlib
import Definitions.Def_ChapterSmYukawaCoupling
import Theorems.Thm_BookProof_SmYukawaCoupling_higgsMul_symmetricOn
import Theorems.Thm_BookProof_SmYukawaCoupling_higgsMul_relBound
import Theorems.Thm_BookProof_SmYukawaCoupling_smYukawa_symmetricOn
import Theorems.Thm_BookProof_SmFullEnclosure_smFull_h_esa
import Theorems.Thm_BookProof_TensorKatoRellich_essentiallySelfAdjointOn_tensorSum_add_coupling
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
theorem solution (P : SmParams) (hlam : 0 < P.lam) {n : ℕ}
    {hD : Matrix (Fin n) (Fin n) ℂ} (M : Matrix (Fin n) (Fin n) ℂ)
    (hh : hD.conjTranspose = hD) :
    EssentiallySelfAdjointOn (smFullCore n) (smYukawaFullHam P hD M) := by

  exact @essentiallySelfAdjointOn_tensorSum_add_coupling (L2dSpace 163) (smFermiSpace n)
    (polyGaussCore (d := 163)) (fullDom n) _ _ (fullDom_finiteDimensional n)
    (smHamiltonian P) (onFull (smFermiHam hD 0 0))
    yukV (yukY M) (smHamiltonian_symmetricOn P)
    (smFermiHam_symmetricOn (M := 0) (z := 0) hh)
    (fun i => by fin_cases i <;> exact higgsMul_symmetricOn _)
    (fun i => by fin_cases i <;> exact smYukawa_symmetricOn M _)
    (fun i => by fin_cases i <;> exact higgsMul_relBound P hlam _)
    (smFull_h_esa P 0 0 hh)
