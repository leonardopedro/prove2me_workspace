-- Generated from ChapterMackeyCocycle.lean — theorem BookProof.ChapterMackeyCocycle.mem_smul_image_iff
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterPvmCyclicUnitary
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
open BookProof.ChapterMackeyCocycle

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable {μ : Measure X} [IsFiniteMeasure μ]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary


theorem BookProof.ChapterMackeyCocycle.mem_smul_image_iff (g : G) (E : Set X) (x : X) :
    x ∈ (fun y : X => g • y) '' E ↔ g⁻¹ • x ∈ E := by sorry
