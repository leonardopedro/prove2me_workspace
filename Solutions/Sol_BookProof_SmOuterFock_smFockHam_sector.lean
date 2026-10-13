-- Generated from ChapterSmOuterFock.lean — solution of BookProof.SmOuterFock.smFockHam_sector
import Mathlib
import Definitions.Def_ChapterSmOuterFock
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmHamiltonian
open BookProof.SmOuterFock




open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge
open BookProof.ChapterStoneResolvent
open BookProof.HermiteProductCore
open BookProof.SmHamiltonian

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) (x : smFockCore) (n : ℕ) :
    ((smFockHam P x : smFockSpace) : ∀ n : ℕ, L2d (n * 163)) n
      = smSectorHam P n ⟨((x : smFockSpace) : ∀ n : ℕ, L2d (n * 163)) n, x.2.2 n⟩ := rfl
