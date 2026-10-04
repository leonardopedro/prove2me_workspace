-- Generated from ChapterPvmCyclicDecomposition.lean — theorem BookProof.ChapterPvmCyclicDecomposition.exists_orthCyclicFamily
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
import Definitions.Def_ChapterA4
open BookProof.ChapterPvmCyclicDecomposition

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure


theorem BookProof.ChapterPvmCyclicDecomposition.exists_orthCyclicFamily [CompleteSpace H] (P : Pvm X H) :
    ∃ S : Set H, OrthCyclicFamily P S ∧
      Dense ((Submodule.span ℂ (familyOrbit P S) : Submodule ℂ H) : Set H) := by sorry
