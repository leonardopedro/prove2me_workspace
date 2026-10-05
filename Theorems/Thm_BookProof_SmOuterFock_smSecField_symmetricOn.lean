-- Generated from ChapterSmOuterFock.lean — theorem BookProof.SmOuterFock.smSecField_symmetricOn
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterSmOuterFock
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterYangMillsHermite
open BookProof.ChapterF7
open BookProof.HermiteProductCore
open BookProof.SmHamiltonian
open BookProof.YangMillsHermite
open BookProof.SmOuterFock



open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge
open BookProof.ChapterStoneResolvent

noncomputable section

theorem BookProof.SmOuterFock.smSecField_symmetricOn (P : SmParams) (n : ℕ) (r : Fin (n * 49)) :
    SymmetricOn (polyGaussCore (d := n * 163))
      ((polyGaussCore (d := n * 163)).subtype.comp (smSecField P n r)) := by sorry
