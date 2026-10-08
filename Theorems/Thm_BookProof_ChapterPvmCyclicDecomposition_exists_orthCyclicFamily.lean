-- Generated from ChapterPvmCyclicDecomposition.lean — theorem BookProof.ChapterPvmCyclicDecomposition.exists_orthCyclicFamily
import Definitions.Def_ChapterPvmMeasure
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
open BookProof.ChapterPvmCyclicDecomposition


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]


theorem BookProof.ChapterPvmCyclicDecomposition.exists_orthCyclicFamily [CompleteSpace H] (P : Pvm X H) :
    ∃ S : Set H, OrthCyclicFamily P S ∧
      Dense ((Submodule.span ℂ (familyOrbit P S) : Submodule ℂ H) : Set H) := by sorry
