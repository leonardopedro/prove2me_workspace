-- Generated from ChapterSmFarisLavine.lean — theorem BookProof.SmFarisLavine.sm_h_esa_of_comparison_esa
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
import Definitions.Def_ChapterA4
open BookProof.HermiteProductCore
open BookProof.SmHamiltonian
open BookProof.SmFarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable [CompleteSpace F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL

noncomputable section

theorem BookProof.SmFarisLavine.sm_h_esa_of_comparison_esa (P : SmParams) {c0 : ℝ} (hc0 : 0 ≤ c0)
    (hN : EssentiallySelfAdjointOn (polyGaussCore (d := 163)) (smFlN P c0)) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 163)) (smHamiltonian P) := by sorry
