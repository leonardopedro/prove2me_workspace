-- Generated from ChapterSmOuterFock.lean — solution of BookProof.SmOuterFock.smFockHam_number_conserving
import Mathlib
import Definitions.Def_ChapterSmOuterFock
import Theorems.Thm_BookProof_Qg3DGaugeFL_dsOp_number_conserving
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
theorem solution (P : SmParams) (x : smFockCore)
    {n : ℕ} (hx : ∀ m, m ≠ n → ((x : smFockSpace) : ∀ m : ℕ, L2d (m * 163)) m = 0) (m : ℕ)
    (hm : m ≠ n) : ((smFockHam P x : smFockSpace) : ∀ m : ℕ, L2d (m * 163)) m = 0 := BookProof.Qg3DGaugeFL.dsOp_number_conserving _ x hx m hm
