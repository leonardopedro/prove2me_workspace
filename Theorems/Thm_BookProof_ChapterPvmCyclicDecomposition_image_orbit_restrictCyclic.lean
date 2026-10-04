-- Generated from ChapterPvmCyclicDecomposition.lean — theorem BookProof.ChapterPvmCyclicDecomposition.image_orbit_restrictCyclic
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
import Definitions.Def_ChapterA4
open BookProof.ChapterPvmCyclicDecomposition

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure


theorem BookProof.ChapterPvmCyclicDecomposition.image_orbit_restrictCyclic [CompleteSpace H] (P : Pvm X H) (ψ : H) :
    (Subtype.val '' pvmOrbit (restrictCyclic P ψ) ⟨ψ, mem_cyclicSubspace_self P ψ⟩)
      = pvmOrbit P ψ := by sorry
