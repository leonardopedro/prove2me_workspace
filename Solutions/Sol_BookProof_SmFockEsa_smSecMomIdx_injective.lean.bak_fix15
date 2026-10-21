-- Generated from ChapterSmFockEsa.lean — solution of BookProof.SmFockEsa.smSecMomIdx_injective
import Mathlib
import Definitions.Def_ChapterSmFockEsa
open BookProof.SmFockEsa




open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian BookProof.SmOuterFock
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.TensorCore BookProof.SecondQuantizationCore
open BookProof.YangMillsNonAbelianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : Function.Injective (smSecMomIdx n) := by

  intro m m' h
  have h1 : (((smMomFinN n).symm m).1, smMomCoord ((smMomFinN n).symm m).2)
      = (((smMomFinN n).symm m').1, smMomCoord ((smMomFinN n).symm m').2) :=
    finProdFinEquiv.injective h
  have h2 : (smMomFinN n).symm m = (smMomFinN n).symm m' :=
    Prod.ext (Prod.ext_iff.1 h1).1 (BookProof.SmFarisLavine.smMomCoord_injective
      (Prod.ext_iff.1 h1).2)
  exact (smMomFinN n).symm.injective h2
