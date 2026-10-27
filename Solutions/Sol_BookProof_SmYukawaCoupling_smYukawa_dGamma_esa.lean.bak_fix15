-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.smYukawa_dGamma_esa
import Mathlib
import Definitions.Def_ChapterSmYukawaCoupling
import Theorems.Thm_BookProof_SmYukawaCoupling_smYukawa_h_esa
import Theorems.Thm_BookProof_SmYukawaCoupling_smYukawaFullHam_symmetricOn
import Theorems.Thm_BookProof_EsaOneParticle_dGamma_essentiallySelfAdjointOn_of_esa
import Theorems.Thm_BookProof_SmFullEnclosure_smFullCore_dense
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
    EssentiallySelfAdjointOn
      (dsCore (fun k : ℕ => fockSectorCore (smFullSpace n) (smFullCore n) (smFullCore n) k))
      (dGammaCoreOp (smFullSpace n) (smFullCore n) (smYukawaFullHam P hD M) (smFullCore n)) :=
  EsaOneParticle.dGamma_essentiallySelfAdjointOn_of_esa (Hs := smFullSpace n)
      (smYukawaFullHam P hD M) (smFullCore_dense n) (smYukawaFullHam_symmetricOn P M hh)
      (smYukawa_h_esa P hlam M hh)
