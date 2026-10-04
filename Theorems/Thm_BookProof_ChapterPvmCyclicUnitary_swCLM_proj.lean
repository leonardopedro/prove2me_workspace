-- Generated from ChapterPvmCyclicUnitary.lean — theorem BookProof.ChapterPvmCyclicUnitary.swCLM_proj
import Definitions.Def_ChapterMackeyQuasiInvariant
import Mathlib
import Definitions.Def_ChapterPvmCyclicUnitary
import Definitions.Def_ChapterElectroweakFieldStrength
import Definitions.Def_ChapterA4
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterPvmCyclicUnitary

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (P : Pvm X H) (ψ : H)
variable [CompleteSpace H]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterMackeyQuasiInvariant

attribute [local instance] Lp.simpleFunc.module Lp.simpleFunc.normedSpace


theorem BookProof.ChapterPvmCyclicUnitary.swCLM_proj {E : Set X} (hE : MeasurableSet E) (f : Lp ℂ 2 (pvmMeasure P ψ)) :
    swCLM P ψ (proj (pvmMeasure P ψ) hE f) = P.p E (swCLM P ψ f) := by sorry
