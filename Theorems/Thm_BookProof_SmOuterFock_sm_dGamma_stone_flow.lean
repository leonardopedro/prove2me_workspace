-- Generated from ChapterSmOuterFock.lean — theorem BookProof.SmOuterFock.sm_dGamma_stone_flow
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterSmOuterFock
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.HermiteProductCore
open BookProof.SmHamiltonian
open BookProof.StoneBridge
open BookProof.YangMillsFriedrichs
open BookProof.SmOuterFock



open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge
open BookProof.ChapterStoneResolvent

noncomputable section

theorem BookProof.SmOuterFock.sm_dGamma_stone_flow (P : SmParams) :
    ∃ (T : UnboundedSelfAdjoint smFockSpace) (U : ℝ → (smFockSpace →L[ℂ] smFockSpace)),
      IsStoneFlow T U := by sorry
