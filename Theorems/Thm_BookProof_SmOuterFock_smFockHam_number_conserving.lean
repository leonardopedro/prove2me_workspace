-- Generated from ChapterSmOuterFock.lean — theorem BookProof.SmOuterFock.smFockHam_number_conserving
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterSmOuterFock
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmHamiltonian
open BookProof.HermiteProductCore
open BookProof.SmHamiltonian
open BookProof.SmOuterFock



open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge
open BookProof.ChapterStoneResolvent

noncomputable section

theorem BookProof.SmOuterFock.smFockHam_number_conserving (P : SmParams) (x : smFockCore)
    {n : ℕ} (hx : ∀ m, m ≠ n → ((x : smFockSpace) : ∀ m : ℕ, L2d (m * 163)) m = 0) (m : ℕ)
    (hm : m ≠ n) : ((smFockHam P x : smFockSpace) : ∀ m : ℕ, L2d (m * 163)) m = 0 := by sorry
