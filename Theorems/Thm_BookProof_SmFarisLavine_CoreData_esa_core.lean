-- Generated from ChapterSmFarisLavine.lean — theorem BookProof.SmFarisLavine.CoreData.esa_core
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Mathlib
import Definitions.Def_ChapterSmFarisLavine
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterQgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL
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

theorem BookProof.SmFarisLavine.CoreData.esa_core (d : CoreData F) (hsym : SymmetricOn d.C₀ d.H₀) {c : ℝ}
    (hc : 0 ≤ c) (hcomm : ∀ p : d.C₀, |commForm d.H₀ d.coreN p| ≤ c * quadForm d.coreN p) :
    EssentiallySelfAdjointOn d.C₀ d.H₀ := by sorry
