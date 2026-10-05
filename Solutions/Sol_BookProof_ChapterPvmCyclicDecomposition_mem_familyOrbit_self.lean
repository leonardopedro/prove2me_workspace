-- Generated from ChapterPvmCyclicDecomposition.lean — solution of BookProof.ChapterPvmCyclicDecomposition.mem_familyOrbit_self
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
open BookProof.ChapterPvmCyclicDecomposition



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution {P : Pvm X H} {S : Set H} {ψ : H} (hψ : ψ ∈ S) :
    ψ ∈ familyOrbit P S := Set.mem_biUnion hψ ⟨Set.univ, MeasurableSet.univ, (P.univ ψ).symm⟩
