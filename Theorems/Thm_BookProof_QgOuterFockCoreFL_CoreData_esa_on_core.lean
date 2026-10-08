-- Generated from ChapterFarisLavineOnly.lean — theorem BookProof.QgOuterFockCoreFL.CoreData.esa_on_core
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterFarisLavineOnly
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterQgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL


open scoped ENNReal

noncomputable section


open BookProof.FarisLavine


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


variable (d : CoreData F)


theorem BookProof.QgOuterFockCoreFL.CoreData.esa_on_core (hsym : SymmetricOn d.C₀ d.H₀) {c : ℝ} (hc : 0 ≤ c)
    (hcomm : ∀ p : d.C₀, |commForm d.H₀ d.coreN p| ≤ c * quadForm d.coreN p) :
    EssentiallySelfAdjointOn d.C₀ d.H₀ := by sorry
