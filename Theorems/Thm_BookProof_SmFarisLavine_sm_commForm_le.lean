-- Generated from ChapterSmFarisLavine.lean — theorem BookProof.SmFarisLavine.sm_commForm_le
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Mathlib
import Definitions.Def_ChapterSmFarisLavine
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmHamiltonian
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

theorem BookProof.SmFarisLavine.sm_commForm_le (P : SmParams) {c0 : ℝ} (hc0 : 0 ≤ c0)
    (x : polyGaussCore (d := 163)) :
    |commForm (smHamiltonian P) (smFlN P c0) x| ≤ 1 * quadForm (smFlN P c0) x := by sorry
