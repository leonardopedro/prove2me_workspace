-- Generated from ChapterSmFullEnclosure.lean — solution of BookProof.SmFullEnclosure.smFullHam_symmetricOn
import Mathlib
import Definitions.Def_ChapterSmFullEnclosure
import Theorems.Thm_BookProof_SmDiracYukawa_smFermiHam_symmetricOn
import Theorems.Thm_BookProof_SmHamiltonian_smHamiltonian_symmetricOn
import Theorems.Thm_BookProof_TensorSumEsa_symmetricOn_cpairOp
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
    SymmetricOn (smFullCore n) (smFullHam P hD M z) :=
  symmetricOn_cpairOp (L2dSpace 163) (smFermiSpace n) _ _ _ _ (smHamiltonian_symmetricOn P)
      (smFermiHam_symmetricOn (M := M) (z := z) hh)
