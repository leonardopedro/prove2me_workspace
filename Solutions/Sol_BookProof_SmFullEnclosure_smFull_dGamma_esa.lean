-- Generated from ChapterSmFullEnclosure.lean — solution of BookProof.SmFullEnclosure.smFull_dGamma_esa
import Mathlib
import Definitions.Def_ChapterSmFullEnclosure
import Theorems.Thm_BookProof_SmFullEnclosure_smFullCore_dense
import Theorems.Thm_BookProof_SmFullEnclosure_smFullHam_symmetricOn
import Theorems.Thm_BookProof_SmFullEnclosure_smFull_h_esa
import Theorems.Thm_BookProof_EsaOneParticle_dGamma_essentiallySelfAdjointOn_of_esa
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
    EssentiallySelfAdjointOn
      (dsCore (fun k : ℕ => fockSectorCore (smFullSpace n) (smFullCore n) (smFullCore n) k))
      (dGammaCoreOp (smFullSpace n) (smFullCore n) (smFullHam P hD M z) (smFullCore n)) :=
  EsaOneParticle.dGamma_essentiallySelfAdjointOn_of_esa (Hs := smFullSpace n)
      (smFullHam P hD M z) (smFullCore_dense n) (smFullHam_symmetricOn P M z hh)
      (smFull_h_esa P M z hh)
