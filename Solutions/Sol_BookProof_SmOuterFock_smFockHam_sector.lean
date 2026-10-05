-- Generated from ChapterSmOuterFock.lean — solution of BookProof.SmOuterFock.smFockHam_sector
import Mathlib
import Definitions.Def_ChapterSmOuterFock
open BookProof.SmOuterFock




open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge
open BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) (x : smFockCore) (n : ℕ) :
    ((smFockHam P x : smFockSpace) : ∀ n : ℕ, L2d (n * 163)) n
      = smSectorHam P n ⟨((x : smFockSpace) : ∀ n : ℕ, L2d (n * 163)) n, x.2.2 n⟩ := rfl
