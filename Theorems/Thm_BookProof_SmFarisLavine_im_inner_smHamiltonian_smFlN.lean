-- Generated from ChapterSmFarisLavine.lean — theorem BookProof.SmFarisLavine.im_inner_smHamiltonian_smFlN
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Mathlib
import Definitions.Def_ChapterSmFarisLavine
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterA4
open BookProof.HashimotoShiftInvert
open BookProof.HermiteProductCore
open BookProof.SmHamiltonian
open BookProof.SmFarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable [CompleteSpace F]



open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL

noncomputable section

theorem BookProof.SmFarisLavine.im_inner_smHamiltonian_smFlN (P : SmParams) (c0 : ℝ)
    (x : polyGaussCore (d := 163)) :
    (inner ℂ (smHamiltonian P x) (smFlN P c0 x) : ℂ).im
      = (inner ℂ (smHamiltonian P x) (smQL x) : ℂ).im := by sorry
