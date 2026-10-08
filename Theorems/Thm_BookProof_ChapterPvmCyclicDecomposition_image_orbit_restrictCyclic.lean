-- Generated from ChapterPvmCyclicDecomposition.lean — theorem BookProof.ChapterPvmCyclicDecomposition.image_orbit_restrictCyclic
import Definitions.Def_ChapterPvmMeasure
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
open BookProof.ChapterPvmCyclicDecomposition


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]


theorem BookProof.ChapterPvmCyclicDecomposition.image_orbit_restrictCyclic [CompleteSpace H] (P : Pvm X H) (ψ : H) :
    (Subtype.val '' pvmOrbit (restrictCyclic P ψ) ⟨ψ, mem_cyclicSubspace_self P ψ⟩)
      = pvmOrbit P ψ := by sorry
