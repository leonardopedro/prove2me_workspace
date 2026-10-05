-- Generated from ChapterMackeyCocycle.lean — theorem BookProof.ChapterMackeyCocycle.image_preimage_smul
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterPvmCyclicUnitary
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
open BookProof.ChapterMackeyCocycle

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary


theorem BookProof.ChapterMackeyCocycle.image_preimage_smul (g : G) (F : Set X) :
    (fun x : X => g • x) '' ((fun x : X => g • x) ⁻¹' F) = F := by sorry
