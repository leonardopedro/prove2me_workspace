-- Generated from ChapterSmFarisLavine.lean — theorem BookProof.SmFarisLavine.sm_h_esa_of_graph_core
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Mathlib
import Definitions.Def_ChapterSmFarisLavine
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterSmHamiltonian
open BookProof.GraphCore
open BookProof.HermiteProductCore
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData
open BookProof.SmHamiltonian
open BookProof.SmFarisLavine



open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable [CompleteSpace F]

theorem BookProof.SmFarisLavine.sm_h_esa_of_graph_core (P : SmParams) {c0 : ℝ} (hc0 : 0 ≤ c0)
    (hgc : IsGraphCore (smFlComparison P hc0) (polyGaussCore (d := 163))) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 163)) (smHamiltonian P) := by sorry
