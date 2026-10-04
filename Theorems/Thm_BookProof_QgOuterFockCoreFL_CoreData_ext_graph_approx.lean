-- Generated from ChapterFarisLavineOnly.lean — theorem BookProof.QgOuterFockCoreFL.CoreData.ext_graph_approx
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterFarisLavineOnly
import Definitions.Def_ChapterQgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable (d : CoreData F)


open scoped ENNReal

noncomputable section


open BookProof.FarisLavine





theorem BookProof.QgOuterFockCoreFL.CoreData.ext_graph_approx (x : d.C.dom) (ε : ℝ) (hε : 0 < ε) :
    ∃ y : d.C.dom, (y : F) ∈ d.C₀ ∧ ‖(y : F) - (x : F)‖ < ε ∧ ‖d.ext y - d.ext x‖ < ε := by sorry
