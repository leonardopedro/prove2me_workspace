-- Generated from ChapterSmFockEsa.lean — solution of BookProof.SmFockEsa.sm_dGamma_esa
import Mathlib
import Definitions.Def_ChapterSmFockEsa
import Theorems.Thm_BookProof_EsaOneParticle_dGamma_essentiallySelfAdjointOn_of_esa
import Theorems.Thm_BookProof_SmComparisonEsa_sm_h_esa
import Theorems.Thm_BookProof_SmHamiltonian_smHamiltonian_symmetricOn
open BookProof.SmFockEsa




open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian BookProof.SmOuterFock
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.TensorCore BookProof.SecondQuantizationCore
open BookProof.YangMillsNonAbelianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) :
    EssentiallySelfAdjointOn
      (dsCore (fun n : ℕ => fockSectorCore (L2dSpace 163) (polyGaussCore (d := 163))
        (polyGaussCore (d := 163)) n))
      (dGammaCoreOp (L2dSpace 163) (polyGaussCore (d := 163))
        (smHamiltonian P) (polyGaussCore (d := 163))) :=
  EsaOneParticle.dGamma_essentiallySelfAdjointOn_of_esa (Hs := L2dSpace 163)
      (smHamiltonian P) polyGaussCore_dense (smHamiltonian_symmetricOn P)
      (BookProof.SmComparisonEsa.sm_h_esa P)
