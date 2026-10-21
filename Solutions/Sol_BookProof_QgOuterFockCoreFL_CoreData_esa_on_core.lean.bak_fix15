-- Generated from ChapterFarisLavineOnly.lean — solution of BookProof.QgOuterFockCoreFL.CoreData.esa_on_core
import Mathlib
import Definitions.Def_ChapterFarisLavineOnly
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_ext_graph_approx
import Theorems.Thm_BookProof_FarisLavine_essentiallySelfAdjointOn_restrict_of_graph_core
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_ext_core
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_ext_essentiallySelfAdjointOn
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData



open scoped ENNReal

noncomputable section


open BookProof.FarisLavine


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


variable (d : CoreData F)

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable (d : CoreData F)

set_option maxHeartbeats 1000000 in
theorem solution (hsym : SymmetricOn d.C₀ d.H₀) {c : ℝ} (hc : 0 ≤ c)
    (hcomm : ∀ p : d.C₀, |commForm d.H₀ d.coreN p| ≤ c * quadForm d.coreN p) :
    EssentiallySelfAdjointOn d.C₀ d.H₀ := by

  have hres :=
    essentiallySelfAdjointOn_restrict_of_graph_core d.gc.le d.ext d.ext_graph_approx
      (d.ext_essentiallySelfAdjointOn hsym hc hcomm)
  have hid : d.ext.comp (Submodule.inclusion d.gc.le) = d.H₀ :=
    LinearMap.ext fun p => d.ext_core p
  rwa [hid] at hres
