-- Generated from ChapterSmFullEnclosure.lean — solution of BookProof.SmFullEnclosure.smFull_h_esa
import Mathlib
import Definitions.Def_ChapterSmFullEnclosure
import Theorems.Thm_BookProof_SmFullEnclosure_fullDom_dense
import Theorems.Thm_BookProof_SmFullEnclosure_smFermiHam_esa
import Theorems.Thm_BookProof_SmComparisonEsa_sm_h_esa
import Theorems.Thm_BookProof_SmDiracYukawa_smFermiHam_symmetricOn
import Theorems.Thm_BookProof_SmHamiltonian_smHamiltonian_symmetricOn
import Theorems.Thm_BookProof_TensorSumEsa_essentiallySelfAdjointOn_cpairDom_esa
open BookProof.SmFullEnclosure




open scoped TensorProduct
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) {n : ℕ} {hD : Matrix (Fin n) (Fin n) ℂ}
    (M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) (hh : hD.conjTranspose = hD) :
    EssentiallySelfAdjointOn (smFullCore n) (smFullHam P hD M z) :=
  essentiallySelfAdjointOn_cpairDom_esa (Hs := L2dSpace 163) (Ks := smFermiSpace n)
      (smHamiltonian P) (onFull (smFermiHam hD M z)) polyGaussCore_dense (fullDom_dense n)
      (smHamiltonian_symmetricOn P) (smFermiHam_symmetricOn (M := M) (z := z) hh)
      (BookProof.SmComparisonEsa.sm_h_esa P) (smFermiHam_esa M z hh)
